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

@interface GlobalViewController ()

@end

@implementation GlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"全球购";
    UIImageView *bg = [[UIImageView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT -FUSONNAVIGATIONBAR_HEIGHT)];
    bg.image = [UIImage imageNamed:@"quanqiugou_bg"];
    [self.view addSubview:bg];
    
    UIImageView *item = [[UIImageView alloc] initWithFrame:RECT(15, SCREEN_HEIGHT - SCREEN_SCALE_HEIGHT(240), SCREEN_WIDTH * 0.45, SCREEN_SCALE_HEIGHT(70))];
    item.layer.cornerRadius = 5;
    item.backgroundColor = [RGBColor colorWithHexString:@"#565656"];
    item.image = [UIImage imageNamed:@"quanqiugou_item"];
    [self.view addSubview:item];
    
    UIView *PS = [[UIView alloc] initWithFrame:RECT(ORIGIN_X(item), SCREEN_HEIGHT - SCREEN_SCALE_HEIGHT(240), SCREEN_WIDTH / 2, SCREEN_SCALE_HEIGHT(90))];
    PS.backgroundColor = [RGBColor colorWithHexString:@"#565656"];
    [self.view insertSubview:PS belowSubview:item];
    
    YXFFloatMenuView *floatMenuView = [[YXFFloatMenuView alloc] initWithFrame:RECT(15, ORIGIN_Y_ADD_SIZE_H(item), SCREEN_WIDTH - 30, SCREEN_SCALE_HEIGHT(155))];
    floatMenuView.layer.cornerRadius = 5;
    [floatMenuView clickedItemsAction:^(NSInteger tag) {
        [self popDetailViewWithID:tag];
    }];
    [self.view addSubview:floatMenuView];
    
}


- (void)popDetailViewWithID:(NSInteger)ID
{
    PopShadowView *podView = [[PopShadowView alloc] init];
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
