//
//  ProjectMacroDefinition.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#ifndef ProjectMacroDefinition_h
#define ProjectMacroDefinition_h

//button点击事件
typedef void (^BlockBtnClick)(NSInteger tag);


//高德定位APIkey
const static NSString *GaodeAPIKey = @"070011907645813cb2b27168fba524e9";

#define BASE_URL        @"http://shj.chinapeas.com/interface.php?"
#define ADVIMAGE_URL    @"http://shj.chinapeas.com"
//#define URL_TEST        @"http://test.myi120.com"

#define MAINCOLOR_GREEN @"#52b615"
#define MAINCOLOR_GRAY  @"#3c3c3c"


//data   NSNotificationCenter
#define NOTIFICATION_CITY @"CompletePositioningAndToRefreshUserInterface"
#define NOTIFICATION_RELOCATION @"reLocation"
#define NOTIFICATION_CHOOSEPRODUCT @"productListReturnProductName"

//NSUserDefault
#define NEWS          @"news"
#define VERSIONS      @"currentVersions"
#define CITY_LIST     @"city_list"


//请求结果状态
#define DATAISNIL     @"null"
#define SUCCESS       @"Success"
#define FAILD         @""

//URL -------------request
//获取城市列表：
#define CITY_URL @"http://shj.chinapeas.com/interface.php?type=1"


//URL--------------HTML
//主页静态
#define H_YZZP                       @"/shj_html_con/index_top_btn/yzzp.html"
#define H_ZXQM                       @"/shj_html_con/index_top_btn/zxqm.html"
#define H_YQPF                       @"/shj_html_con/index_top_btn/yqpf.html"
#define H_HBCN                       @"/shj_html_con/index_top_btn/hbcr.html"

#define HOME_GLOBAL                 @"/shj_html_con/sp_con/quanqiugou.html"

//#define LINBAOZHUANG_HTML            @"/shenghuojiahtml/linbaozhuang.html"
//#define LINBAOZHUNAG_PLUS_HTML       @"/index.php?s=/Home/Article/lists/category/plus.html"
//#define ZUNXIANGJIA_HTML             @"/shenghuojiahtml/zunxiangjia.html"
//#define SANDITIYAN_HTML              @"/shenghuojiahtml/3d.html"
//#define DEBIAOGONGYI_HTML            @"/shenghuojiahtml/debiao.html"
//#define HAIKUANDETAIL_HTML           @"/shenghuojiahtml/haikuan.html"
//#define ZAIJIANGONGCHENG_DETAIL_MHTL @"/shj_content/jzgd_con.html"
//#define ZAIXIANYUYUE_HTML            @"http://www17.53kf.com/webCompany.php?arg=9006234&style=2"

//拎包装PLUS
#define LINBAOZHUNAG_PLUS_HTML       @"/index.php?s=/Home/Article/lists/category/plus.html"

#define LINBAOZHUANG_PLUS_A          @"/shj_html_con/plus_btn/plus_btna.html"
#define LINBAOZHUANG_PLUS_B          @"/shj_html_con/plus_btn/plus_btnb.html"
#define LINBAOZHUANG_PLUS_C          @"/shj_html_con/plus_btn/plus_btnc.html"
#define LINBAOZHUANG_PLUS_D          @"/shj_html_con/plus_btn/plus_btnd.html"

//关于我们
#define GUANYUWOMEN_GSJJ_HTML        @"/shj_html_con/us_con/abus.html"
#define GUANYUWOMEN_QYRY_HTML        @"/shj_html_con/us_con/qiyerongyu.html"
#define GUANYUWOMEN_QYWH_HTML        @"/shj_html_con/us_con/gongsiwenhua.html"
#define GUANYUWOMEN_FZLC_HTML        @"/shj_html_con/us_con/fazhanlicheng.html"
#define GUANYUWOMEN_JYTD_HTML        @"/shj_html_con/us_con/ourteam.html"
#define GUANYUWOMEN_LXWM_HTML        @"/shj_html_con/us_con/conus.html"


#endif /* ProjectMacroDefinition_h */

