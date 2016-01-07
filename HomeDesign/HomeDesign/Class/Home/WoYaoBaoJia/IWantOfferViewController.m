//
//  IWantOfferViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/3.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "IWantOfferViewController.h"
#import "CountResultView.h"
#import "ChooseProductViewController.h"
#import "IWantOrderViewModel.h"
#import "ProductListMModel.h"

typedef NS_ENUM(NSInteger, IWantOrderType) {
    IWantOrderTypeChooseShop = 80,
    IWantOrderTypeChooseRooms
};

@interface IWantOfferViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger chooseType;
    UIButton *currentbutton;
    UIImageView *fontbgiamge;
    NSArray *shoparr;
    NSArray *shiarr;
    NSArray *tingarr;
    NSArray *weiarr;
    NSArray *shiNumberArr;
    NSArray *tingNumberArr;
    NSArray *weiNumberArr;
    
    UITextField *nametxf;
    UITextField *phonetxf;
    UITextField *mianjitxf;
    UITextField *chanpintxf;
    UITextField *tingtxf;
    UITextField *weitxf;
    UITextField *shitxf;
    NSString *chanpinID;
    
    NSString *shiString;
    NSString *tingString;
    NSString *weiString;
    
}
@property (nonatomic, strong) UIPickerView *pickerView;


@end

@implementation IWantOfferViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_CHOOSEPRODUCT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:phonetxf];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我要报价";
    //接收产品列表返回的产品名字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetProductName:) name:NOTIFICATION_CHOOSEPRODUCT object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:phonetxf];
    
    shiarr = @[@"0室", @"1室", @"2室",@"3室",@"4室", @"5室", @"6室",@"7室",@"8室", @"9室", @"10室"];
    tingarr = @[@"0厅", @"1厅", @"2厅", @"3厅",@"4厅",@"5厅"];
    weiarr = @[@"0卫", @"1卫", @"2卫", @"3卫",@"4卫",@"5卫"];
    shiNumberArr = @[@"0", @"1", @"2", @"3",@"4", @"5", @"6",@"7", @"8", @"9",@"10"];
    tingNumberArr = @[@"0", @"1", @"2", @"3",@"4", @"5"];
    weiNumberArr = @[@"0", @"1", @"2", @"3",@"4", @"5"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(667) - FUSONNAVIGATIONBAR_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT);
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    if (isSizeOf_3_5) {
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(667));
    }
    
    //背景
    UIImageView *bgimage = [[UIImageView alloc] initWithFrame:RECT(0, 0, SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(667) - FUSONNAVIGATIONBAR_HEIGHT)];
    bgimage.image = [UIImage imageNamed:@"woyaobaojia_bg.jpg"];
    bgimage.userInteractionEnabled = YES;
    [scrollView addSubview:bgimage];
    
    //生活家logle
    UIImageView *imagelogle = [[UIImageView alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(90), SCREEN_SCALE_HEIGHT(20), SCREEN_WIDTH - SCREEN_SCALE_WIDTH(180), SCREEN_SCALE_HEIGHT(45))];
    imagelogle.image = [UIImage imageNamed:@"woyaobaojia_logo"];
    [bgimage addSubview:imagelogle];
    
    //白色背景
    fontbgiamge = [[UIImageView alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(35), ORIGIN_Y_ADD_SIZE_H(imagelogle) + SCREEN_SCALE_HEIGHT(20), SCREEN_WIDTH - SCREEN_SCALE_WIDTH(70), SIZE_H(bgimage) - ORIGIN_Y_ADD_SIZE_H(imagelogle) - 60)];
    fontbgiamge.image = [UIImage imageNamed:@"woyaobaojia_fontbg"];
    fontbgiamge.clipsToBounds = YES;
    fontbgiamge.contentMode = UIViewContentModeScaleAspectFit;
    fontbgiamge.userInteractionEnabled = YES;
    if (isSizeOf_3_5) {
        fontbgiamge.contentMode = UIViewContentModeScaleToFill;
    }
    [bgimage addSubview:fontbgiamge];
    
    //提示
    UILabel *discriptionlabel = [[UILabel alloc] initWithFrame:SCALERECT(0, SCREEN_SCALE_HEIGHT(20), fontbgiamge.frame.size.width, 30) textAlignment:NSTextAlignmentCenter font:FONT(SCREEN_SCALE_WIDTH(16)) textColor:[UIColor whiteColor]];
    discriptionlabel.center = CGPointMake(SIZE_W(fontbgiamge)/2, SCREEN_SCALE_HEIGHT(35));
    discriptionlabel.attributedText = [discriptionlabel attributedString:[NSString stringWithFormat:@"装修智能报价, %@解决预算烦恼",@"1分钟"] changedIndex:8 last:6];
    [fontbgiamge addSubview:discriptionlabel];
    
    //填入信息textfeilde
    NSArray *placeheader = @[@"请输入您的姓名", @"请输入您的电话", @"请输入您的套内面积", @"请选择产品"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImageView *textbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuaisuyuyue_txfbg"]];
        textbg.frame = RECT(SCREEN_SCALE_WIDTH(20), SCREEN_SCALE_HEIGHT(60) + i * SCREEN_SCALE_HEIGHT(61), fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(40), SCREEN_SCALE_HEIGHT(38));
        textbg.contentMode = UIViewContentModeScaleToFill;
        textbg.userInteractionEnabled = YES;
        [fontbgiamge addSubview:textbg];
        
        UITextField *text = [[UITextField alloc] initWithFrame:RECT(20, 0, SIZE_W(textbg) - 20, SIZE_H(textbg))];
        text.textColor = [UIColor blackColor];
        text.layer.cornerRadius = 5;
        text.font = FONT(12);
        text.tag = 70 + i;
        text.delegate = self;
        text.placeholder = placeheader[i];
        [textbg addSubview:text];
        
        switch (i) {
            case 0:
                nametxf = text;
                break;
            case 1:
                text.keyboardType = UIKeyboardTypeNumberPad;
                phonetxf = text;
                break;
            case 2:
            {
                UILabel *right = [[UILabel alloc] initWithFrame:RECT(SIZE_W(textbg) - 20, 0, 20, 30) textAlignment:NSTextAlignmentCenter font:FONT(10) textColor:[UIColor blackColor]];
                right.text = @"㎡";
                [textbg addSubview:right];
                text.keyboardType = UIKeyboardTypeNumberPad;
                mianjitxf = text;
            }
                break;
            case 3:
            {
                text.tag = 70;
                text.enabled = NO;
                UIImageView *triangleimage = [[UIImageView alloc]initWithFrame:RECT(text.frame.size.width - 10, 17, 5, 5)];
                triangleimage.image = [UIImage imageNamed:@"woyaobaojia_xiaosanjia"];
                [textbg addSubview:triangleimage];
                chanpintxf = text;
            }
                break;
            default:
                break;
        }
    }
    
    NSArray *shitingwei = @[@"室", @"厅", @"卫"];
    for (NSInteger i = 0 ; i < 3; i ++) {
        UITextField *text = [[UITextField alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(SCREEN_SCALE_WIDTH(20)) + i * (fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(30)) / 3, SCREEN_SCALE_HEIGHT(60) + 4 * SCREEN_SCALE_HEIGHT(61), (fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(60)) / 3 , SCREEN_SCALE_HEIGHT(38))];
        text.tag = 71 + i;
        text.backgroundColor = [UIColor whiteColor];
        text.textAlignment = NSTextAlignmentCenter;
        text.textColor = [UIColor blackColor];
        text.enabled = NO;
        text.placeholder = shitingwei[i];
        [text setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        text.font = FONT(SCREEN_SCALE_WIDTH(14));
        text.delegate = self;
        [fontbgiamge addSubview:text];
        
        UIImageView *triangleimage = [[UIImageView alloc]initWithFrame:RECT(text.frame.size.width - 10, 17, 5, 5)];
        triangleimage.image = [UIImage imageNamed:@"woyaobaojia_xiaosanjia"];
        [text addSubview:triangleimage];
        
        switch (i) {
            case 0:
                shitxf = text;
                break;
            case 1:
                tingtxf = text;
                break;
            case 2:
                weitxf = text;
                break;
                
            default:
                break;
        }
    }
    
    //选择产品按钮
    UIButton *buttonChooseShop = [[UIButton alloc] initWithFrame:RECT(0, SCREEN_SCALE_HEIGHT(60) + 3 * SCREEN_SCALE_HEIGHT(61), SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(30))];
    buttonChooseShop.tag = IWantOrderTypeChooseShop;
    [buttonChooseShop addTarget:self action:@selector(chooseProductBtn:) forControlEvents:UIControlEventTouchUpInside];
    [fontbgiamge addSubview:buttonChooseShop];
    
    //选择房间
    UIButton *buttonChooseRooms = [[UIButton alloc] initWithFrame:RECT(0, SCREEN_SCALE_HEIGHT(60) + 4 * SCREEN_SCALE_HEIGHT(61), SCREEN_WIDTH , SCREEN_SCALE_HEIGHT(30))];
    buttonChooseRooms.tag = IWantOrderTypeChooseRooms;
    [buttonChooseRooms addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [fontbgiamge addSubview:buttonChooseRooms];

    //估算报价按钮
    UIImageView *btnbg = [[UIImageView alloc] initWithFrame:RECT(0, 0, (SCREEN_WIDTH - SCREEN_SCALE_WIDTH(40))/3, SCREEN_SCALE_HEIGHT(38))];
    btnbg.userInteractionEnabled = YES;
    btnbg.image = [UIImage imageNamed:@"woyaobaojia_gusuanbaojia"];
    btnbg.center = CGPointMake(fontbgiamge.frame.size.width / 2, fontbgiamge.frame.size.height - SCREEN_SCALE_HEIGHT(90));
    if (isSizeOf_5_5) {
        btnbg.center = CGPointMake(fontbgiamge.frame.size.width / 2, fontbgiamge.frame.size.height - SCREEN_SCALE_HEIGHT(85));
    }else if (isSizeOf_4_7)
    {
        btnbg.center = CGPointMake(fontbgiamge.frame.size.width / 2, fontbgiamge.frame.size.height - SCREEN_SCALE_HEIGHT(80));
    }else if (isSizeOf_4_0)
    {
        btnbg.center = CGPointMake(fontbgiamge.frame.size.width / 2, fontbgiamge.frame.size.height - SCREEN_SCALE_HEIGHT(75));
    }else{
        btnbg.center = CGPointMake(fontbgiamge.frame.size.width / 2, fontbgiamge.frame.size.height - SCREEN_SCALE_HEIGHT(70));
    }
    [fontbgiamge addSubview:btnbg];
    
    UIButton *countButton = [[UIButton alloc] initWithFrame:btnbg.bounds];
    [countButton setTitle:@"估算报价" forState:UIControlStateNormal];
    [countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    countButton.titleLabel.font = FONT(15);
    [countButton addTarget:self action:@selector(handleCountButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnbg addSubview:countButton];

}

- (void)networking
{
    IWantOrderViewModel *orderViewModel = [[IWantOrderViewModel alloc] init];
    if ([nametxf.text isEqual:@""]) {
        [SVProgressHUD svprogressHUDWithString:@"请输入姓名"];
    }else if ([phonetxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请输入电话"];
    }else if ([mianjitxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请输入面积"];
    }else if ([chanpintxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请选择产品"];
    }else if ([shitxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请选择室"];
    }else if ([tingtxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请选择厅"];
    }else if ([weitxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请选择卫"];
    }else{
        BOOL phoneiSRight = [RegularExpressionsValidation VerificationWihtPhoneNumber:phonetxf.text];
        if (phoneiSRight) {
            [SVProgressHUD show];
            if ([NetWorking netWorkReachability]) {
                [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
                return;
            }

            [orderViewModel IWantOrderRequestWithTid:@"2" name:nametxf.text chanpingID:chanpinID phone:phonetxf.text mianji:mianjitxf.text ting:tingString wei:weiString shi:weiString];
            [orderViewModel setBlockWithReturnBlock:^(id data) {
                
                if ([data[@"flag"] isEqual:SUCCESS]) {
                    [SVProgressHUD dismiss];
                    CountResultView *countResultView = [[CountResultView alloc] initWithJieguo:data[@"data"][@"jieguo"]];
                    [self.view addSubview:countResultView];
                }else{
                   [SVProgressHUD svprogressHUDWithString:data[@"msg"]];
                }
                
            } WithErrorBlock:^(id errorCode) {
                [SVProgressHUD svprogressHUDWithString:[NSString stringWithFormat:@"%@",errorCode]];
            } WithFailureBlock:^{
                [SVProgressHUD svprogressHUDWithString:@"请检查网络连接"];
            }];
        }else{
            [SVProgressHUD svprogressHUDWithString:@"请输入争取的电话号码"];
        }
    }
}

- (void)svprogressHUDWithString:(NSString *)string
{
    [SVProgressHUD showWithStatus:string];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}


#pragma mark - notification
- (void)resetProductName:(NSNotification *)notification
{
    ProductListMModel *model = notification.object;
    chanpinID = model.idStr;
    chanpintxf.text = model.title;
}

#pragma  mark - process

- (void)chooseProductBtn:(UIButton *)sender
{
    NSString *selfid;
    [self.info isEqual:nil] ? (selfid = @"-1") : ( selfid = self.info[@"id"]);
    ChooseProductViewController *chooseProductVC = [[ChooseProductViewController alloc] init];
    chooseProductVC.selfid = selfid;
    [self.navigationController pushViewController:chooseProductVC animated:YES];
}

//显示picker选择器
- (void)showPickerView:(UIButton *)sender
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    UIView *pickerContentView = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT, SCREEN_WIDTH, 160)];
    pickerContentView.backgroundColor = [UIColor whiteColor];
    pickerContentView.tag = 100;
    [self.view addSubview:pickerContentView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH , 100)];
    pickerView.backgroundColor = [UIColor colorWithHex:0.5 alpha:0.5];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView selectRow:1 inComponent:0 animated:YES];
    [pickerContentView addSubview:pickerView];
    
    UIButton *surebtn = [[UIButton alloc] initWithFrame:RECT(pickerView.frame.size.width - 50, 0, 50, 40)];
    [surebtn setTitle:@"完成" forState:UIControlStateNormal];
    [surebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    surebtn.titleLabel.font = FONT(12);
    [surebtn addTarget:self action:@selector(removePickerView:) forControlEvents:UIControlEventTouchUpInside];
    [pickerContentView addSubview:surebtn];
    
    [UIView animateWithDuration:0 animations:^{
          pickerContentView.frame = RECT(0, SCREEN_HEIGHT - 160, SCREEN_WIDTH, 160);
    }];
    
    currentbutton = sender;
}

//移除picker选择器
- (void)removePickerView:(UIButton *)sender
{
    UIView * pickerview = [self.view viewWithTag:100];
    [pickerview removeFromSuperview];
}

//********************估算结果
- (void)handleCountButton:(UIButton *)sender
{
    [self networking];
}


#pragma mark - <UIPickerViewDataSource, UIPickerViewDelegate>
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
        return 3;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (component == 0) {
        return [shiarr count];
    }else if (component == 1)
    {
        return [tingarr count];
    }else{
        return [weiarr count];
    }
}
//行宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
{
    return 60;
}
//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
{
    return 30;
}
//每行内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    if (component == 0) {
        pickerLabel.text = [NSString stringWithFormat:@"%@", shiarr[row]];
    }else if (component == 1){
        pickerLabel.text = [NSString stringWithFormat:@"%@", tingarr[row]];
    }else{
        pickerLabel.text = [NSString stringWithFormat:@"%@", weiarr[row]];
    }
    return pickerLabel;
}
//选中某行某列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    if (component == 0) {
        shitxf.text = [NSString stringWithFormat:@"%@", shiarr[row]];
        shiString = shiNumberArr[row];
    }else if (component == 1){
        tingtxf.text = [NSString stringWithFormat:@"%@", tingarr[row]];
        tingString = tingNumberArr[row];
    }else{
        weitxf.text = [NSString stringWithFormat:@"%@", weiarr[row]];
        weiString = weiNumberArr[row];
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    UIView * pickerview = [self.view viewWithTag:100];
    [pickerview removeFromSuperview];
    return YES;
}


#pragma mark - notification  电话号码长度监听
#define kMaxLength 11
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }  
    }  
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
