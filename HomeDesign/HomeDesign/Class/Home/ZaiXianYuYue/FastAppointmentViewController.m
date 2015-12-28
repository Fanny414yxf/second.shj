//
//  FastAppointmentViewController.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/17.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "FastAppointmentViewController.h"
#import "FastAppointmentViewModel.h"

@interface FastAppointmentViewController ()<UITextFieldDelegate>
{
    UITextField *nametxf;
    UITextField *phonetxf;
    UITextField *loupantxf;
    UITextField *mianjitxf;
}


@end

@implementation FastAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"快速预约";
    
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT)];
    contentView.showsVerticalScrollIndicator = NO;
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH, 540);
    [self.view addSubview:contentView];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuaisuyuyue_bg.jpg"]];
    bg.frame = RECT(0, FUSONNAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - FUSONNAVIGATIONBAR_HEIGHT);
    bg.userInteractionEnabled = YES;
    bg.backgroundColor = [UIColor cyanColor];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:bg];
    
    //注意
    if (!isSizeOf_3_5) {
        [contentView removeFromSuperview];
        [self.view addSubview:bg];
    }
    if (isSizeOf_3_5) {
        bg.frame = RECT(0, 0, SCREEN_WIDTH, contentView.contentSize.height);
    }

    
    UIImageView *fontImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuaisuyuyue_font"]];
    fontImage.frame = RECT(30, SCREEN_SCALE_HEIGHT(40), SCREEN_WIDTH - 60, SCREEN_HEIGHT * 0.56);
    fontImage.userInteractionEnabled = YES;
    fontImage.contentMode = UIViewContentModeScaleAspectFit;
    [bg addSubview:fontImage];
    
    NSArray *placeHeader = @[@"您的姓名", @"联系电话", @"楼盘名称", @"房屋面积"];
    for (NSInteger i = 0; i < 4; i ++) {
        
        UIImageView *textbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuaisuyuyue_txfbg"]];
        textbg.frame = RECT(SCREEN_SCALE_WIDTH(30), SCREEN_SCALE_HEIGHT(30) + i * SCREEN_SCALE_HEIGHT(65), SIZE_W(fontImage) - SCREEN_SCALE_WIDTH(60), SCREEN_SCALE_HEIGHT(38));
        textbg.contentMode = UIViewContentModeScaleToFill;
        textbg.userInteractionEnabled = YES;
        [fontImage addSubview:textbg];
        
        UITextField *text = [[UITextField alloc] initWithFrame:RECT(20, 0, SIZE_W(textbg) - 20, SIZE_H(textbg))];
        text.layer.cornerRadius = 5;
        text.font = FONT(12);
        text.tag = 70 + i;
        text.delegate = self;
        text.placeholder = placeHeader[i];
        [textbg addSubview:text];
        
        switch (i) {
            case 0:
                nametxf = [textbg viewWithTag:70];
                break;
            case 1:
                text.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                phonetxf = [textbg viewWithTag:71];
                break;
            case 2:
                loupantxf = [textbg viewWithTag:72];
                break;
            case 3:
            {
                text.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                UILabel *right = [[UILabel alloc] initWithFrame:RECT(SIZE_W(textbg) - 20, 0, 20, 30) textAlignment:NSTextAlignmentCenter font:FONT(10) textColor:[UIColor blackColor]];
                right.text = @"㎡";
                [textbg addSubview:right];
                
                mianjitxf = [textbg viewWithTag:73];
            }
                break;
            default:
                break;
        }
        
     }
    
    
    UIImageView *orderbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuaisuyuyue_btngn"]];
    orderbg.frame = RECT(SCREEN_SCALE_WIDTH(30), SCREEN_SCALE_HEIGHT(40) + 4 * SCREEN_SCALE_HEIGHT(65), SIZE_W(fontImage) - SCREEN_SCALE_WIDTH(60), SCREEN_SCALE_HEIGHT(38));
    orderbg.contentMode = UIViewContentModeScaleToFill;
    orderbg.userInteractionEnabled = YES;
    [fontImage addSubview:orderbg];
    
    UIButton *orderBtn = [[UIButton alloc] initWithFrame:RECT(0, 0, SIZE_W(orderbg), SIZE_H(orderbg))];
    orderBtn.layer.cornerRadius = 5;
    orderBtn.titleLabel.font = FONT(12);
    [orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(handleOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [orderbg addSubview:orderBtn];
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X(fontImage), ORIGIN_Y_ADD_SIZE_H(fontImage) + 100, SIZE_W(fontImage), 20) textAlignment:NSTextAlignmentLeft font:FONT(12) textColor:[UIColor blackColor]];
    titlelabel.text = @"温馨提示：";
    [self.view addSubview:titlelabel];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:RECT(ORIGIN_X(fontImage), ORIGIN_Y_ADD_SIZE_H(titlelabel) + 5, SIZE_W(fontImage), 100) textAlignment:NSTextAlignmentCenter font:FONT(SCREEN_SCALE_WIDTH(12)) textColor:[UIColor whiteColor]];
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"感谢您填写订单信息，我们会及时与您取得联系，请填写详细，同时您还可以致电客服专线：4008-122-100，我们将有专人为你您解答！"];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [attributedString length])];
    tipLabel.attributedText = attributedString;
    tipLabel.numberOfLines = 0;
    [tipLabel sizeToFit];
    [self.view addSubview:tipLabel];
    
    if (isSizeOf_3_5) {
        fontImage.frame = RECT(30, 40, SCREEN_WIDTH - 60, 580 * 0.56);
        [bg addSubview:titlelabel];
        [bg addSubview:tipLabel];
    }
}

#pragma mark - process
- (void)handleOrderBtn:(UIButton *)sender
{
    NSLog(@"立即预约");
    if ([nametxf.text isEqualToString:@""]) {
        [SVProgressHUD svprogressHUDWithString:@"请输入姓名"];
    }else if ([phonetxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请输入联系电话"];
    }else if ([loupantxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请输入楼盘名称"];
    }else if ([mianjitxf.text isEqualToString:@""]){
        [SVProgressHUD svprogressHUDWithString:@"请输入面积"];
    }else{
        BOOL phoneValidate = [RegularExpressionsValidation validateMobile:phonetxf.text];
        if (phoneValidate) {
            [SVProgressHUD show];
            FastAppointmentViewModel *viewmodel = [[FastAppointmentViewModel alloc] init];
            [viewmodel fasetAppointmentWithTid:1 loupan:loupantxf.text city:[UserInfo shareUserInfo].currentCityName phone:phonetxf.text mianji:[mianjitxf.text integerValue] name:nametxf.text];
            [viewmodel setBlockWithReturnBlock:^(id data) {
                [SVProgressHUD svprogressHUDWithString:data[@"msg"]];
                if ([data[@"flag"] isEqualToString:SUCCESS]) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } WithErrorBlock:^(id errorCode) {
                [SVProgressHUD dismiss];
            } WithFailureBlock:^{
                [SVProgressHUD dismiss];
            }];
        }else{
            [SVProgressHUD svprogressHUDWithString:@"请输入正确的号码"];
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
