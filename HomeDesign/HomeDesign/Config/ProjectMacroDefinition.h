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
#define URL_TEST        @"http://test.myi120.com"

#define MAINCOLOR_GREEN @"#52b615"
#define MAINCOLOR_GRAY  @"#3c3c3c"


//data   NSNotificationCenter
#define NOTIFICATION_CITY @"CompletePositioningAndToRefreshUserInterface"
#define NOTIFICATION_RELOCATION @"reLocation"
#define NOTIFICATION_CHOOSEPRODUCT @"productListReturnProductName"


//请求结果状态
#define DATAISNIL     @"null"
#define SUCCESS       @"Success"
#define FAILD         @""

//URL -------------request
//获取城市列表：
#define CITY_URL @"http://shj.chinapeas.com/interface.php?type=1"


//URL--------------HTML
#define LINBAOZHUANG_HTML            @"/shenghuojiahtml/linbaozhuang.html"
#define LINBAOZHUNAG_PLUS_HTML       @"/index.php?s=/Home/Article/lists/category/plus.html"
#define ZUNXIANGJIA_HTML             @"/shenghuojiahtml/zunxiangjia.html"
#define SANDITIYAN_HTML              @"/shenghuojiahtml/3d.html"
#define DEBIAOGONGYI_HTML            @"/shenghuojiahtml/debiao.html"
#define HAIKUANDETAIL_HTML           @"/shenghuojiahtml/haikuan.html"
#define ZAIJIANGONGCHENG_DETAIL_MHTL @"/shj_content/jzgd_con.html"
#define ZAIXIANYUYUE_HTML            @"http://www17.53kf.com/webCompany.php?arg=9006234&style=2"

#define GUANYUWOMEN_GSJJ_HTML        @"/shj_content/abus.html"
#define GUANYUWOMEN_QYRY_HTML        @"/shj_content/qiyerongyu.html"
#define GUANYUWOMEN_QYWH_HTML        @"/shj_content/gongsiwenhua.html"
#define GUANYUWOMEN_FZLC_HTML        @"/shj_content/fazhanlicheng.html"
#define GUANYUWOMEN_JYTD_HTML        @"/shj_content/ourteam.html"
#define GUANYUWOMEN_LXWM_HTML        @"/shj_content/conus.html"


#endif /* ProjectMacroDefinition_h */

