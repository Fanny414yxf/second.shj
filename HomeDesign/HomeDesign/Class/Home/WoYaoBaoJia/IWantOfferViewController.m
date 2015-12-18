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
    NSArray *roomsarr;
}
@property (nonatomic, strong) UIPickerView *pickerView;


@end

@implementation IWantOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我要报价";
    
    shoparr = @[@"办公型",@"儿童房",@"6人大户型",@"办公型",@"3人小户型",@"6人大户型",@"儿童房",@"办公型",@"儿童房",@"6人大户型"];
    roomsarr = @[@"一室", @"二室", @"三室",@"四室"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(667) - FUSONNAVIGATIONBAR_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(667));
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
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
    discriptionlabel.attributedText = [discriptionlabel attributedString:[NSString stringWithFormat:@"装修智能报价, %@解决预算烦恼",@"1分钟"] changedIndex:8 last:6];
    [fontbgiamge addSubview:discriptionlabel];
    
    //填入信息textfeilde
    NSArray *placeheader = @[@"请输入您的姓名", @"请输入您的电话", @"请输入您的套内面积", @"请选择产品"];
    for (NSInteger i = 0; i < 4; i ++) {
        UIView *left = [[UIView alloc] initWithFrame:RECT(0, 0, 10, 30)];
        left.backgroundColor = [UIColor cyanColor];
        UITextField *text = [[UITextField alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(20), SCREEN_SCALE_HEIGHT(60) + i * SCREEN_SCALE_HEIGHT(61), fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(40), SCREEN_SCALE_HEIGHT(38))];
        [text.leftView addSubview:left];
        text.backgroundColor = [UIColor whiteColor];
        text.textColor = [UIColor blackColor];
        text.placeholder = [NSString stringWithFormat:@"%@",placeheader[i]];
        [text setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        text.font = FONT(SCREEN_SCALE_WIDTH(14));
        text.delegate = self;
        [fontbgiamge addSubview:text];
        if (i == 3) {
            text.tag = 70;
            text.enabled = NO;
            UIImageView *triangleimage = [[UIImageView alloc]initWithFrame:RECT(text.frame.size.width - 10, 17, 5, 5)];
            triangleimage.image = [UIImage imageNamed:@"woyaobaojia_xiaosanjia"];
            [text addSubview:triangleimage];
        }
    }
    
    for (NSInteger i = 0 ; i < 3; i ++) {
        UITextField *text = [[UITextField alloc] initWithFrame:RECT(SCREEN_SCALE_WIDTH(SCREEN_SCALE_WIDTH(20)) + i * (fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(30)) / 3, SCREEN_SCALE_HEIGHT(60) + 4 * SCREEN_SCALE_HEIGHT(61), (fontbgiamge.frame.size.width - SCREEN_SCALE_WIDTH(60)) / 3 , SCREEN_SCALE_HEIGHT(38))];
        text.tag = 71 + i;
        text.backgroundColor = [UIColor whiteColor];
        text.textAlignment = NSTextAlignmentLeft;
        text.textColor = [UIColor blackColor];
        text.enabled = NO;
        text.placeholder = [NSString stringWithFormat:@"%@",@"一室"];
        [text setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        text.font = FONT(SCREEN_SCALE_WIDTH(14));
        text.delegate = self;
        [fontbgiamge addSubview:text];
        
        UIImageView *triangleimage = [[UIImageView alloc]initWithFrame:RECT(text.frame.size.width - 10, 17, 5, 5)];
        triangleimage.image = [UIImage imageNamed:@"woyaobaojia_xiaosanjia"];
        [text addSubview:triangleimage];
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


#pragma  mark - process 

- (void)chooseProductBtn:(UIButton *)sender
{
    ChooseProductViewController *chooseProductVC = [[ChooseProductViewController alloc] init];
    [self.navigationController pushViewController:chooseProductVC animated:YES];
}

//显示picker选择器
- (void)showPickerView:(UIButton *)sender
{
//    if (sender == currentbutton) {
//        return;
//    }
//    chooseType = sender.tag;
    
    UIView *pickerContentView = [[UIView alloc] initWithFrame:RECT(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(130))];
    pickerContentView.backgroundColor = [UIColor whiteColor];
    pickerContentView.tag = 100;
    [self.view addSubview:pickerContentView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH , SCREEN_SCALE_HEIGHT(100))];
    pickerView.backgroundColor = [UIColor colorWithHex:0.5 alpha:0.5];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView selectRow:2 inComponent:0 animated:YES];
    [pickerContentView addSubview:pickerView];
    
    UIButton *surebtn = [[UIButton alloc] initWithFrame:RECT(pickerView.frame.size.width - 50, 0, 50, 30)];
    [surebtn setTitle:@"完成" forState:UIControlStateNormal];
    [surebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    surebtn.titleLabel.font = FONT(12);
    [surebtn addTarget:self action:@selector(removePickerView:) forControlEvents:UIControlEventTouchUpInside];
    [pickerContentView addSubview:surebtn];
    
    [UIView animateWithDuration:0 animations:^{
          pickerContentView.frame = RECT(0, SCREEN_HEIGHT - SCREEN_SCALE_HEIGHT(130), SCREEN_WIDTH, SCREEN_SCALE_HEIGHT(130));
    }];
    
    currentbutton = sender;
}
//移除picker选择器
- (void)removePickerView:(UIButton *)sender
{
    UIView * pickerview = [self.view viewWithTag:100];
    [pickerview removeFromSuperview];
}

//估算结果
- (void)handleCountButton:(UIButton *)sender
{
    CountResultView *countResultView = [[CountResultView alloc] init];
    [self.view addSubview:countResultView];
}

#pragma mark - <UITextFieldDelegate>

#pragma mark - <UIPickerViewDataSource, UIPickerViewDelegate>
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    NSLog(@"这是哪个批脸厚的 -----%ld", (long)pickerView.tag);
//    if (chooseType == IWantOrderTypeChooseRooms) {
        return 3;
//    }
//    return 1;
}
//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
//    if (chooseType == IWantOrderTypeChooseShop) {
//        return [shoparr count];
//    }else{
        return [roomsarr count];
//    }
}
//行宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
{
//    if (chooseType == IWantOrderTypeChooseShop) {
//        return SCREEN_WIDTH / 2;
//    }
    return 60;
}
//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
{
    return 20;
}
//每行内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
//    if (chooseType == IWantOrderTypeChooseShop) {
//        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        pickerLabel.text = [NSString stringWithFormat:@"%@", shoparr[row]];
//    }else{
        pickerLabel.text = [NSString stringWithFormat:@"%@", roomsarr[row]];
//    };
    return pickerLabel;
}
//选中某行某列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
//    if (chooseType == IWantOrderTypeChooseShop) {
//        ((UITextField *)[fontbgiamge viewWithTag:70]).text = [NSString stringWithFormat:@"%@", shoparr[row]];
//    }else{
        if (component == 0) {
            ((UITextField *)[fontbgiamge viewWithTag:71]).text = [NSString stringWithFormat:@"%@", roomsarr[row]];
        }else if (component == 1){
            ((UITextField *)[fontbgiamge viewWithTag:72]).text = [NSString stringWithFormat:@"%@", roomsarr[row]];
        }else{
            ((UITextField *)[fontbgiamge viewWithTag:73]).text = [NSString stringWithFormat:@"%@", roomsarr[row]];
        }
//    }
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
