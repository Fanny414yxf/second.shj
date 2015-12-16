//
//  HopShopingViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/7.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "HopShopingViewController.h"
#import "HotShopTableViewCell.h"

@interface HopShopingViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *shopImage;
    UILabel *shopDiscreptionLabel;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HopShopingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"嗨款";
    
    
   
    UIView *header = [self tabelViewHeader];
    
    _tableView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [_tableView registerClass:[HotShopTableViewCell class] forCellReuseIdentifier:@"hopShopCell"];
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = header;
}


- (UIView *)tabelViewHeader
{
    UIView *tabelHeaderView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 250)];
    shopImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"linbaozhuangplus_header"]];
    shopImage.frame = RECT(0, 5, SCREEN_WIDTH, 200);
    shopImage.contentMode = UIViewContentModeScaleAspectFit;
    [tabelHeaderView addSubview:shopImage];
    
    UIView *discreptionBg = [[UIView alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(shopImage), SCREEN_WIDTH, 40)];
    discreptionBg.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
    [tabelHeaderView addSubview:discreptionBg];
    
    shopDiscreptionLabel = [[UILabel alloc] initWithFrame:RECT(20, 0, SCREEN_WIDTH - 20, 40) textAlignment:NSTextAlignmentLeft font:FONT(14) textColor:[UIColor whiteColor]];
    shopDiscreptionLabel.text = @"5周年珍藏版， 黄金性价比飙升";
    [discreptionBg addSubview:shopDiscreptionLabel];
    
    UIImageView *timebg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haikuan_flgbg_time"]];
    timebg.frame = RECT(SCREEN_WIDTH - 100, 20, 100, 25);
    timebg.contentMode = UIViewContentModeScaleAspectFit;
    [tabelHeaderView addSubview:timebg];
    
    NSArray *arr = @[@"0", @"0", @":", @"1", @"2", @":", @"4", @"6"];
    UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, -2, 100, 25) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
    [timebg addSubview:label];
    
    for (NSInteger i = 0; i < 8; i ++) {
        discreptionBg.backgroundColor = [RGBColor colorWithHexString:@"#e0e0e0"];
        UILabel *time = [[UILabel alloc] initWithFrame:RECT(10 + i * 11, 7.5, 10, 15) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor whiteColor]];
        time.text = [NSString stringWithFormat:@"%@", arr[i]];
        if (i == 2 || i == 5) {
            time.backgroundColor = [UIColor clearColor];
        }else{
            time.backgroundColor = [RGBColor colorWithHexString:MAINCOLOR_GREEN];
        }
        [label addSubview:time];
    }

    return tabelHeaderView;
}


#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"hopShopCell";
    HotShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HotShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify row:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
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
