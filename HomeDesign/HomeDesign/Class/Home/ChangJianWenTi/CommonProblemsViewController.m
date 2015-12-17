//
//  CommonProblemsViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/4.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "CommonProblemsViewController.h"
#import "CommonProblemTableViewCell.h"

static NSString *cellIdentifier = @"commonProblemcell";

@interface CommonProblemsViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *commonProblemsTablelView;
@property (nonatomic, strong) UIImageView *commonProblemsImage;//图片

@property (nonatomic, strong) NSArray *questionAndAnswerArr;
@property (nonatomic, strong) NSMutableDictionary *offscreenCells;


@end

@implementation CommonProblemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"常见问题";
    
    _questionAndAnswerArr = @[@{@"question" : @"家庭么装修厨房", @"answer" : @"风格vfdsgdhbzdfgsegdsfbsrbvrijgn的感觉 快乐考试分开放松多了 快乐贷款你看电视看了你你困了呢克里见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就斯蒂娜了空间上电脑看来是的那看来是你考上了呢可是你快递方式的可能开始的女快乐"},
                              @{@"question" : @"家庭装修如何做好混搭风格", @"answer" : @"公司的公开是干嘛看没看顾客V大；SMG法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具上课DV卡是你的可能看那看金利科技 就离开金利科技刻录机###"},
                               @{@"question" : @"真么选择比较好装公司", @"answer" : @"更好地发挥不放心的百度国防生的的GSDV刹的V大分高德vfdvbgfn放大的的"},
  @{@"question" : @"家庭装修时要怎么装修厨房", @"answer" : @"湖北大学不放过输入法打个DVD看见你困了呢看到老师您考虑将独生女快乐上电脑将考虑你说的就考虑到你刷卡记录呢开具的理念vnklvnk"},
                               @{@"question" : @"家庭装修时要你困了呢么装修厨房", @"answer" : @"个梵蒂冈和对不上电视公司的不得放不放不舍得vsvsdvc"},
                               @{@"question" : @"家庭装修时要法打个DVD看见你困了呢怎么装修厨房", @"answer" : @"跟对方会改变的奶粉的电视广播的非常舒服不V刹股份部分地方不不大方便地方"}];
    
    UIView *headerView = [[UIView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, 200)];;
    headerView.backgroundColor = [UIColor whiteColor];
    
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
    
    _commonProblemsTablelView = [[UITableView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT - 50)];
    _commonProblemsTablelView.dataSource = self;
    _commonProblemsTablelView.delegate = self;
    _commonProblemsTablelView.showsVerticalScrollIndicator = NO;
    _commonProblemsTablelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_commonProblemsTablelView registerClass:[CommonProblemTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:_commonProblemsTablelView];
    _commonProblemsTablelView.tableHeaderView = headerView;
    
    
    UIButton *onLineButton = [[UIButton alloc] initWithFrame:RECT(0,  SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    [onLineButton setBackgroundColor:[RGBColor colorWithHexString:MAINCOLOR_GREEN] forState:UIControlStateNormal];
    [onLineButton setTitle:@"在线咨询" forState:UIControlStateNormal];
    [onLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onLineButton addTarget:self action:@selector(processOnLineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onLineButton];

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
- (CGFloat)cellHeightForRowAtIndexPath:(NSDictionary *)dic
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:RECT(2, 5, SCREEN_HEIGHT/2, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
    label1.text = [NSString stringWithFormat:@"%@", dic[@"question"]];
    
    CGRect proframe = label1.frame;
    proframe.size.height = [label1.text boundingRectWithSize:CGSizeMake(proframe.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:[NSDictionary dictionaryWithObjectsAndKeys:label1.font,NSFontAttributeName, nil] context:nil].size.height;
    label1.frame = RECT(2, 5, SCREEN_WIDTH/2, proframe.size.height + 15);
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:RECT(2, 10, SCREEN_WIDTH - 60, 30) textAlignment:NSTextAlignmentCenter font:FONT(12) textColor:[UIColor blackColor]];
    label2.text = [NSString stringWithFormat:@"%@",dic[@"answer"]];
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
    }
    return YES;
}


#pragma mark - process 
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
