//
//  AppDelegate.m
//  HomeDesign
//
//  Created by apple on 15/11/13.
//  Copyright (c) 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "CityViewModel.h"

@interface AppDelegate ()
{
    BOOL locationSuccess;//定位是否成功
    BOOL locationServicesEnabled;//是否可以定位即dingwi
}
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;


@end

@implementation AppDelegate

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NOTIFICATION_RELOCATION];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initLocationManager) name:NOTIFICATION_RELOCATION object:nil];
    
    [self initLocationManager];
    [self keyboardSetting];
    
    NSLog(@".........................%@", NSStringFromCGSize([UIScreen mainScreen].bounds.size));
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainViewController *homeVC = [[NSClassFromString(@"MainViewController") alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = navc;
    
    return YES;
}

#pragma mark - APPKey
- (void)configureAPIKey
{
         

}

//开启定位
- (void)initLocationManager
{
    locationSuccess = NO;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager startUpdatingLocation];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
}

//逆地理编码
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        //定位成功后发送通知修改首页定位文字
        CLPlacemark *placemark=[placemarks firstObject];
        NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:placemark.addressDictionary];
        NSString *str = [NSString stringWithFormat:@"%@", dic[@"City"]];
        NSString *city =  [str substringToIndex:[str length] - 1];
        [UserInfo shareUserInfo].kCityName = city;
        [UserInfo shareUserInfo].currentCityName = city;
        
        CityViewModel *cityViewModel = [[CityViewModel alloc] init];
        [cityViewModel getCityList];
        [cityViewModel setBlockWithReturnBlock:^(id data) {
            
            NSArray *citysArr = [NSArray arrayWithArray:data];
            //遍历城市列表 找出城市列表中与定位城市相同，则为选中状态 为1 否则为0
            for (int i = 0; i < [citysArr count]; i ++) {
                NSString *str = ((CityModel *)data[i]).cityName;
                
                if ([str isEqualToString:city]) {
                    NSInteger cityid = [((CityModel *)data[i]).number integerValue];
                    [UserInfo shareUserInfo].cityID = cityid;
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY object:city];

        } WithErrorBlock:^(id errorCode) {
            [UserInfo shareUserInfo].kCityName = @"定位";
            [UserInfo shareUserInfo].currentCityName = @"定位";
            [UserInfo shareUserInfo].cityID = -1;
        } WithFailureBlock:^{
            [UserInfo shareUserInfo].kCityName = @"定位";
            [UserInfo shareUserInfo].currentCityName = @"定位";
            [UserInfo shareUserInfo].cityID = -1;
        }];
    }];
}

#pragma MARK - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    //注意：stopUpdatingLocation 并不会立即关闭定位，所以当定位成功后就locationSuccess为yes.，不再重复发送通知
    [_locationManager stopUpdatingLocation];
    if (locationSuccess == YES) {
        return;
    }
    
    [self getAddressByLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    locationSuccess = YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
{
    locationServicesEnabled = NO;
    NSLog(@"定位服务当前可能尚未打开，请设置打开！");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请打开设置->隐私->定位->生活家" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    [UserInfo shareUserInfo].cityID = -1;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY object:nil];
}


#pragma MARK - IQKeyboardManaagerSetting
- (void)keyboardSetting
{
    IQKeyboardManager *keyboardmanager  =[IQKeyboardManager sharedManager];
    keyboardmanager.enableAutoToolbar = NO;
    keyboardmanager.shouldShowTextFieldPlaceholder = YES;
    keyboardmanager.shouldResignOnTouchOutside = YES;
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self.window.rootViewController];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyGo;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.myi120.xf.HomeDesign" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HomeDesign" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HomeDesign.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
