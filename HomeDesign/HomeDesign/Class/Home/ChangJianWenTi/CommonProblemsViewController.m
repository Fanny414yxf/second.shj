//
//  CommonProblemsViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CommonProblemsViewController.h"
#import "CommonProblemTableViewCell.h"
#import "ChangjianWentiModel.h"
#import "ChangjianWentiViewModel.h"

static NSString *cellIdentifier = @"commonProblemcell";

typedef NS_ENUM(NSInteger, QuestionType) {
    QuestionType1  = 1,
    QuestionType2,
    QuestionType3,
    QuestionType4
};

@interface CommonProblemsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UIView *headerView;//表头
    NSInteger currenPage;//当前页数
}

@property (nonatomic, strong) UITableView *commonProblemsTablelView;
@property (nonatomic, strong) UIImageView *commonProblemsImage;//图片

@property (nonatomic, strong) NSArray *questionAndAnswerArr;
@property (nonatomic, strong) NSMutableDictionary *offscreenCells;


@end

@implementation CommonProblemsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //默认第一页
    currenPage = 1;
    
    [self networkingWithQuestionType:0 page:1 keyword:nil];
    
    //4个问题标签
    for (NSInteger i = 1; i < 5; i ++) {
        NSDictionary *dic = self.questionTypeArr[i];
        UILabel *label = [[UILabel alloc] initWithFrame:RECT(0, 0, 100, 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
        label.text = dic[@"name"];
        [label sizeToFit];
        label.userInteractionEnabled = YES;
        [headerView addSubview:label];
        UIButton *button = [[UIButton alloc] initWithFrame:RECT(0, 0, SIZE_W(label), SIZE_H(label))];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(refreshWithQuestionType:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
        if (i == 1) {
            label.frame = RECT(30, 150, SIZE_W(label), 20);
            button.frame = label.frame;
        }else if (i == 2){
            label.frame = RECT(SCREEN_WIDTH/2 + 30, 150, SIZE_W(label), 20);
            button.frame = label.frame;
        }else if (i == 3){
            label.frame = RECT(30, 180, SIZE_W(label), 20);
            button.frame = label.frame;
        }else{
            label.frame = RECT(SCREEN_WIDTH/2 + 30, 180,SIZE_W(label), 20);
            button.frame = label.frame;
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"常见问题";
    
    headerView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 200)];;
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    //图片
    _commonProblemsImage = [[UIImageView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 100)];
    _commonProblemsImage.backgroundColor = [UIColor grayColor];
    _commonProblemsImage.image = [UIImage imageNamed:@"changjianwenti_topimage.jpg"];
    [headerView addSubview:_commonProblemsImage];
    
    //收索栏
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:RECT(20, 110, SCREEN_WIDTH - 40, 30)];
    searchTextField.textAlignment = NSTextAlignmentLeft;
    searchTextField.font = FONT(12);
    searchTextField.textColor = [UIColor blackColor];
    
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
    
    
    //问题列表
    _commonProblemsTablelView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - 50)];
    _commonProblemsTablelView.dataSource = self;
    _commonProblemsTablelView.delegate = self;
    _commonProblemsTablelView.showsVerticalScrollIndicator = NO;
    _commonProblemsTablelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commonProblemsTablelView registerClass:[CommonProblemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_commonProblemsTablelView];
    _commonProblemsTablelView.tableHeaderView = headerView;

   _commonProblemsTablelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownRefresh)];
    _commonProblemsTablelView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullOnLoading:)];
    [self.commonProblemsTablelView.mj_header beginRefreshing];
    
    
    UIButton *onLineButton = [[UIButton alloc] initWithFrame:RECT(0,  SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [onLineButton setBackgroundColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN] forState:UIControlStateNormal];
    [onLineButton setTitle:@"在线咨询" forState:UIControlStateNormal];
    [onLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onLineButton addTarget:self action:@selector(processOnLineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onLineButton];

}

//下拉刷新
- (void)dropDownRefresh
{
    currenPage = 1;
    [self networkingWithQuestionType:0 page:currenPage keyword:nil];
    
}
//上拉加载
- (void)pullOnLoading:(NSInteger)page
{
    currenPage ++;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_questionAndAnswerArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonProblemTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellInfo:_questionAndAnswerArr[indexPath.row]];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self cellHeightForRowAtIndexPath:_questionAndAnswerArr[indexPath.row]];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

//计算并返回cell高度
- (CGFloat)cellHeightForRowAtIndexPath:(ChangjianWentiModel *)dic
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:RECT(2, 5, SCREEN_HEIGHT/2, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
    label1.text = [NSString stringWithFormat:@"%@", dic.title];
    
    CGRect proframe = label1.frame;
    proframe.size.height = [label1.text boundingRectWithSize:CGSizeMake(proframe.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:label1.font,NSFontAttributeName, nil] context:nil].size.height;
    label1.frame = RECT(2, 5, SCREEN_WIDTH/2, proframe.size.height + 15);
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:RECT(2, 10, SCREEN_WIDTH - 60, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
    label2.text = [NSString stringWithFormat:@"%@",dic.content];
    CGRect txtFrame = label2.frame;
    txtFrame.size.height =[label2.text boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:label2.font,NSFontAttributeName, nil] context:nil].size.height;
    label2.frame = CGRectMake(10, 10 + label1.frame.size.height / 2, SCREEN_WIDTH - 40, txtFrame.size.height);
    
    CGFloat hhh = label1.frame.size.height + label2.frame.size.height + 37;
    return hhh;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if ([string isEqualToString:@"\n"]) {
        NSLog(@"shohfdsfdgdsh");
        [textField resignFirstResponder];
        [self networkingWithQuestionType:0 page:1 keyword:string];
    }
    return YES;
}


#pragma mark - process 
- (void)refreshWithQuestionType:(UIButton *)sender
{
    //改变
    currenPage = 0;
    switch (sender.tag) {
        case 11:
        {
            [self networkingWithQuestionType:QuestionType1 page:currenPage keyword:nil];
        }
            
            break;
        case 12:
        {
            [self networkingWithQuestionType:QuestionType1 page:currenPage keyword:nil];
        }
            
            break;
        case 13:
        {
            [self networkingWithQuestionType:QuestionType1 page:currenPage keyword:nil];
        }
            
            break;
        case 14:
        {
            [self networkingWithQuestionType:QuestionType1 page:currenPage keyword:nil];
        }
        break;
            
        default:
            break;
    }
}

- (void)networkingWithQuestionType:(NSInteger)tyoeid page:(NSInteger)page keyword:(NSString *)keywotd
{
//    [SVProgressHUD show];
    NSString *selfid = [NSString stringWithFormat:@"%@",self.info[@"id"]];
    ChangjianWentiViewModel *viewmodel = [[ChangjianWentiViewModel alloc] init];
    [viewmodel getChangjianWentiDataWithID:selfid type:@3 row:@10 page:@(page) keywords:keywotd show:@"wen" lei:@(tyoeid)];
    [viewmodel setBlockWithReturnBlock:^(id data) {
        [self.commonProblemsTablelView.mj_header endRefreshing];
        
        if ([data isEqual:DATAISNIL]) {
            [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            dispatch_async(dispatch_get_main_queue(), ^{
             });
        }else{
            _questionAndAnswerArr = [NSArray arrayWithArray:data];
            [_commonProblemsTablelView reloadData];
        }
       
    } WithErrorBlock:^(id errorCode) {
    } WithFailureBlock:^{
    }];

}

- (void)processOnLineBtn:(UIButton *)sender
{
    NSLog(@"Ω在线咨询");
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
