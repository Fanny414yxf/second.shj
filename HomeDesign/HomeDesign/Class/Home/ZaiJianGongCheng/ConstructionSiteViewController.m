//
//  ConstructionSiteViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "ConstructionSiteViewController.h"
#import "ConstructionSiteCell.h"

@interface ConstructionSiteViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *constructionSiteTableview;

@end

@implementation ConstructionSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"在建工地";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    UIView *tabelHeaderView = [[UIView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 50)];
    tabelHeaderView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self.view addSubview:tabelHeaderView];
    [tabelHeaderView addSubview:[self tableViewHeaderView]];
    
    _constructionSiteTableview = [[UITableView alloc] initWithFrame:RECT(0, ORIGIN_Y_ADD_SIZE_H(tabelHeaderView), SCREEN_WIDTH, SCREEN_HEIGHT - 120)];
    _constructionSiteTableview.delegate = self;
    _constructionSiteTableview.dataSource = self;
    _constructionSiteTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _constructionSiteTableview.showsVerticalScrollIndicator = NO;
    [_constructionSiteTableview registerClass:[ConstructionSiteCell class] forCellReuseIdentifier:@"constructionsCell"];
    [self.view addSubview:_constructionSiteTableview];
}

- (UIView *)tableViewHeaderView
{
    CGFloat space = (SCREEN_WIDTH - 90 * 2) / 4;
    UIView *tabelHeaderView = [[UIView alloc] initWithFrame:RECT(-1, 0, SCREEN_WIDTH, 40)];
    tabelHeaderView.layer.borderColor = [[UIColor colorWithWhite:0.9 alpha:1]CGColor];
    tabelHeaderView.layer.borderWidth = 0.5;
    tabelHeaderView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:RECT(0, 0, 1, 20)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    line.center = CGPointMake(SCREEN_WIDTH/2, 20);
    [tabelHeaderView addSubview:line];
    
    NSArray *imnageName = @[@"zaijiangngcheng_shipai", @"zaijiangngcheng_shipin"];
    for (NSInteger i  = 0; i < 2; i ++) {
        UIImage *image = [UIImage imageNamed:imnageName[i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = RECT(space + i * (SCREEN_WIDTH / 2), 10, 20, 20);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [tabelHeaderView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X_ADD_SIZE_W(imageView) + 2, ORIGIN_Y(imageView), 70, 20)];
        label.textColor = [UIColor blackColor];
        label.font = FONT(12);
        label.textAlignment = NSTextAlignmentLeft;
        i == 0 ? (label.text = @"工地实拍") : (label.text = @"工艺视屏");
        [tabelHeaderView addSubview:label];
        
        UIButton *button = [[UIButton alloc] initWithFrame:RECT(0 + i * (SCREEN_WIDTH/2), 0, SCREEN_WIDTH/2, 40)];
        [button addTarget:self action:@selector(processbutton:) forControlEvents:UIControlEventTouchUpInside];
        [tabelHeaderView addSubview:button];
    }
    
    return tabelHeaderView;
}




#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConstructionSiteCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"constructionsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}


#pragma  mark - process
- (void)processbutton:(UIButton *)sender
{
    NSLog(@"ffffffffffffffffffffffffffff");
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
