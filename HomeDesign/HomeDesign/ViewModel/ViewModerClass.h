//
//  ViewModerClass.h
//  HomeDesign
//
//  Created by 杨晓芬 on 15/12/11.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModerClass : NSObject

@property (strong, nonatomic) SuccessBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;
@property (strong, nonatomic) FailBlock failureBlock;

//获取网络的链接状态
-(void) netWorkStateWithNetConnectBlock:(NetWorkBlock) netConnectBlock WithURlStr: (NSString *) strURl;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (SuccessBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailBlock) failureBlock;



@end
