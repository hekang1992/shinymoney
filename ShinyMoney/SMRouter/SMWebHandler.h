//
//  WeakScriptMessageHandler.h
//  youonBikePlanA
//
//  Created by karry on 2020/8/3.
//  Copyright © 2020 audi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef void(^WebViewGetMessageBlock)(WKScriptMessage * _Nullable message,NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface SMWebHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic,strong) NSMutableDictionary *handlers;

@property (nonatomic, weak) WKWebView *webView;

- (void)addName:(NSString *)name receiveMessage:(WebViewGetMessageBlock)block;


@end

NS_ASSUME_NONNULL_END
