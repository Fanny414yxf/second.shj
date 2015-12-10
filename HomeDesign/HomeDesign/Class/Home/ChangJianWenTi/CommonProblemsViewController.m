//
//  CommonProblemsViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CommonProblemsViewController.h"
#import "CommonProblemTableViewCell.h"

@interface CommonProblemsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *commonProblemsTablelView;
@property (nonatomic, strong) UIImageView *commonProblemsImage;//图片
//收索栏


@end

@implementation CommonProblemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"常见问题";
    
    UIView *headerView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 200)];;
    headerView.backgroundColor = [UIColor whiteColor];
    
    //图片
    _commonProblemsImage = [[UIImageView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 100)];
    _commonProblemsImage.backgroundColor = [UIColor grayColor];
    _commonProblemsImage.image = [UIImage imageNamed:@"changjianwenti_topimage.jpg"];
    [headerView addSubview:_commonProblemsImage];
    
    //收索栏
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:RECT(20, 110, SCREEN_WIDTH - 40, 30) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
    
    searchTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.placeholder = @"常见问题收索";
    [searchTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    searchTextField.delegate = self;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.returnKeyType = UIReturnKeySearch;
    [headerView addSubview:searchTextField];
    
    UIButton *searchbtn = [[UIButton alloc] initWithFrame:RECT(0, 0, 17, 17)];
    [searchbtn setImage:[UIImage imageNamed:@"changjianwenti_search"] forState:UIControlStateNormal];
    searchTextField.rightView = searchbtn;
    
    //4个问题标签
    NSArray *textarr = @[@"新房装修流程？", @"大户型装修注意事项？", @"设计费收取标准", @"正品建材的鉴别"];
    for (NSInteger i = 0; i < 4; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, 0, 0) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        label.text = textarr[i];
        [headerView addSubview:label];
        if (i == 0) {
            label.frame = RECT(30, 150, SCREEN_WIDTH/2, 20);
        }else if (i == 1){
            label.frame = RECT(SCREEN_WIDTH/2 + 30, 150, SCREEN_WIDTH/2, 20);
        }else if (i == 2){
            label.frame = RECT(30, 180, SCREEN_WIDTH/2, 20);
        }else{
            label.frame = RECT(SCREEN_WIDTH/2 + 30, 180, SCREEN_WIDTH/2, 20);
        }
    }
    
    _commonProblemsTablelView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    _commonProblemsTablelView.dataSource = self;
    _commonProblemsTablelView.delegate = self;
    _commonProblemsTablelView.showsVerticalScrollIndicator = NO;
    _commonProblemsTablelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commonProblemsTablelView registerClass:[CommonProblemTableViewCell class] forCellReuseIdentifier:@"commonProblemcell"];
    [self.view addSubview:_commonProblemsTablelView];
    _commonProblemsTablelView.tableHeaderView = headerView;
    
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonProblemTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"commonProblemcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if ([string isEqualToString:@"\n"]) {
        NSLog(@"shohfdsfdgdsh");
        [textField resignFirstResponder];
    }
    return YES;
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
