//
//  LGWebViewController.h
//  LoanGuru
//
//  Created by Apple on 2023/3/1.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^webBlock)(WKScriptMessage * _Nullable message,NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface SMWebVC : UIViewController

@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic)BOOL ifFromBank;

@property (nonatomic) BOOL ifZDYNav;

- (instancetype)initWithURL:(NSString *)URL;

-(void)setH5IsScree:(NSString *)isScree;

-(void)setH5ColorStyleWithTxtColor:(NSString *)txtColor bgColor:(NSString *)bgColor;
@end


@interface LendEasy_WKProcessPool : WKProcessPool

+ (LendEasy_WKProcessPool*)singleWkProcessPool;

@end
NS_ASSUME_NONNULL_END
