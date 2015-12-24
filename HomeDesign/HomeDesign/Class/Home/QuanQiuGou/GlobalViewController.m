//
//  GlobalViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "GlobalViewController.h"
#import "YXFFloatMenuView.h"
#import "PopShadowView.h"
#import "GlobalModel.h"
#import "GlobalViewModel.h"

@interface GlobalViewController ()
{
    NSArray *itemsArr;
    YXFFloatMenuView *floatMenuView;//浮动的菜单
}

@end

@implementation GlobalViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self networking];
    
}
- (void)networking
{
    NSString *selfid = [NSString stringWithFormat:@"%@", self.info[@"id"]];
    GlobalViewModel *globalViewModel = [[GlobalViewModel alloc] init];
    [globalViewModel getGlobalRequestWithType:@"3" ID:selfid];
    [globalViewModel setBlockWithReturnBlock:^(id data) {
        itemsArr = [NSArray arrayWithArray:data];
        floatMenuView.items = itemsArr;
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"全球购";
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quanqiugou_bg.jpg"]];
    bg.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -FUSONNAVIGATIONBAR_HEIGHT);
    bg.image = [UIImage imageNamed:@"quanqiugou_bg.jpg"];
    bg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bg];
    
    //大牌格调
    UIView *itembg = [[UIView alloc] initWithFrame:RECT(15, SCREEN_HEIGHT - SCREEN_SCALE_HEIGHT(240), SCREEN_WIDTH * 0.45, SCREEN_SCALE_HEIGHT(70))];
    itembg.backgroundColor = [RGBColor colorWithHexString:@"#565656"];
    itembg.layer.cornerRadius = 5;
    [self.view addSubview:itembg];
    
    UIImageView *item = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"quanqiugou_item"]];
    item.frame = RECT(5, 4, SIZE_W(itembg) - 10, SIZE_H(itembg) - 15);
    item.layer.cornerRadius = 5;
    item.contentMode = UIViewContentModeScaleAspectFit;
    item.backgroundColor = [RGBColor colorWithHexString:@"#565656"];
    [itembg addSubview:item];
    
//    NSMutableArray *items = [NSMutableArray array];
//    for (NSInteger i = 0; i < 12; i ++) {
//        [items addObject:@"quanqiugou_item2"];
//    }

    //浮动的菜单
    floatMenuView = [[YXFFloatMenuView alloc] initWithFrame:RECT(15, ORIGIN_Y_ADD_SIZE_H(itembg) - 10, SCREEN_WIDTH - 30, SCREEN_SCALE_HEIGHT(155))];
    floatMenuView.layer.cornerRadius = 5;
    floatMenuView.items = itemsArr;
    [floatMenuView clickedItemsAction:^(NSInteger tag) {
        [self popDetailViewWithID:tag];
    }];
    [self.view addSubview:floatMenuView];
}


- (void)popDetailViewWithID:(NSInteger)ID
{
    GlobalModel *model = itemsArr[ID];
    PopShadowView *podView = [[PopShadowView alloc] init];
    podView.topimageName = [NSString stringWithFormat:@"%@", model.cover_id];
    podView.contentImageName = [NSString stringWithFormat:@"%@",model.link_id];
    [self.view addSubview:podView];
    LxPrintf(@"弹出第%ld个小贱人", (long)ID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
