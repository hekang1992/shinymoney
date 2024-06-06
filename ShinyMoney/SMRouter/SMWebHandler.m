//
//  WeakScriptMessageHandler.m
//  youonBikePlanA
//
//  Created by karry on 2020/8/3.
//  Copyright © 2020 audi. All rights reserved.
//

#import "SMWebHandler.h"
#import "SMWebVC.h"
#import <StoreKit/StoreKit.h>
#import "ShinyMoney-Swift.h"
#import "NNModule_swift/NNModule_swift-Swift.h"
@interface SMWebHandler()

@end

@implementation SMWebHandler

- (instancetype)init{
    if (self = [super init]) {
        _handlers = [NSMutableDictionary dictionary];
        [self setupJsHandle];
    }
    return self;
}

- (void)addName:(NSString *)name receiveMessage:(WebViewGetMessageBlock)block{
    if (!name || name.length == 0) {
        NSError *error = [NSError errorWithDomain:@"name can not be empty" code:111 userInfo:nil];
        block(nil,error);
        return;
    }
    _handlers[name] = block;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *key = message.name;
    if (!key) {
        NSLog(@"js error");
        return;
    }
    WebViewGetMessageBlock block = _handlers[key];
    !block?:block(message,nil);
}

- (void)setupJsHandle{
    [self addName:@"whistlingHowto" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSLog(@"%@",message.body);
        @try {
            NSArray *arr = message.body;
            NSString *productIdStr = [NSString stringWithFormat:@"%@",arr[0]];
            NSString *startTimeStr = [NSString stringWithFormat:@"%@",arr[1]];
            NSString *endTimeStr = [SM_ShareFunction getCurrentDeviceTime];
            AppDelegate *appdelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
            [appdelegate addH5PointWithProductId:productIdStr startTime:startTimeStr endTime:endTimeStr];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }];
    
    [self addName:@"afterHeard" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSLog(@"%@",message.body);
        @try {
            NSArray *arr = message.body;
            NSString *openUrl = [NSString stringWithFormat:@"%@",arr[0]];
            AppDelegate *appdelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
            [appdelegate openRouteUrlWithUrl:openUrl];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }];
    
    [self addName:@"greatCrouched" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        [[UIViewController getCurrentViewController].navigationController popViewControllerAnimated:YES];
    }];
    
    [self addName:@"laughterPassed" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        [[UIViewController getCurrentViewController].navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [self addName:@"heardTherefore" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSArray *arr = message.body;
        NSString *isScree = [NSString stringWithFormat:@"%@",arr[0]];
        
        UIViewController *topVC = [UIViewController getCurrentViewController];
        if([topVC isKindOfClass:[SMWebVC class]]){
            SMWebVC *webvc = (SMWebVC *)topVC;
            webvc.ifZDYNav = true;
            [webvc setH5IsScree:isScree];
        }
    }];
    
    [self addName:@"interestedUpthe" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSArray *arr = message.body;
        NSString *txtColor = [NSString stringWithFormat:@"%@",arr[0]];
        NSString *navColor = [NSString stringWithFormat:@"%@",arr[1]];

        UIViewController *topVC = [UIViewController getCurrentViewController];
        if([topVC isKindOfClass:[SMWebVC class]]){
            SMWebVC *webvc = (SMWebVC *)topVC;
            webvc.ifZDYNav = true;
            [webvc setH5ColorStyleWithTxtColor:txtColor bgColor:navColor];
        }
    }];
    
    [self addName:@"comfortablyAfter" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        @try {
            NSArray *arr = message.body;
            NSString *phoneNumber = [NSString stringWithFormat:@"%@",arr[0]];
            
            NSString* phoneString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            NSURL* phoneUrl = [NSURL URLWithString:phoneString];
            [[UIApplication sharedApplication] openURL:phoneUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }];
    
    [self addName:@"bitsite" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSArray *arr = message.body;
        NSString *email = [NSString stringWithFormat:@"%@",arr[0]];
        NSString *title = [NSString stringWithFormat:@"%@",arr[1]];
        NSString *order_id = [NSString stringWithFormat:@"%@",arr[2]];
        NSString *sessionId = [SMUserModel getSessionId];
        SMUserModel * userModel = [SMUserModel getUser];
        NSString *mailUrl = @"";
        if(sessionId.length > 0 ){
            if(order_id.length > 0){
                mailUrl = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=account:%@,orderId:%@",email,title,userModel.theminto,order_id];
            }else{
                mailUrl = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=account:%@",email,title,userModel.theminto];
            }
        }else{
            if(order_id.length > 0){
                mailUrl = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=orderId:%@",email,title,order_id];
            }else{
                mailUrl = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",email,title,@""];
            }
        }
        mailUrl = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        mailUrl = [mailUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mailUrl]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailUrl] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }else{
            NSLog(@"Can't open email client");
            [SMCustomActivityIndicatorView showErrorProcessViewWithErrorStr:@"You haven't installed the Mail app yet"];
        }
    }];
    
    [self addName:@"otherKnows" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        if (@available(iOS 10.3, *)) {
           [SKStoreReviewController requestReview];
        }
    }];
}

@end
