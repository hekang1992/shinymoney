//
//  LGWebViewController.m
//  LoanGuru
//
//  Created by Apple on 2023/3/1.
//

#import "SMWebVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "SMWebHandler.h"
#import "Masonry/Masonry.h"
#import "ShinyMoney-Swift.h"
#import "Hue-Swift.h"
#import "MBProgressHUD.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SMWebVC ()<WKUIDelegate,WKNavigationDelegate>
{
    NSString *_url;
}
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) SMWebHandler *handler;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIBarButtonItem *backItem;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *currentURLStr;
@property (nonatomic, strong) NSString *isScree;
@end

@implementation SMWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
            
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:[self baseConfig]];
    self.webView.backgroundColor = UIColor.whiteColor;
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    self.handler.webView = self.webView;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    [self buildNavView];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [[UIColor alloc] initWithHex:@"FFC100"];
    self.progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:self.progressView];
    
    NSString *notch = SM_ShareFunction.hasNotch == false ? @"0" : @"1";
    if([_url containsString:@"?"]){
        _url = [NSString stringWithFormat:@"%@&%@&notch=%@",_url,[SM_ShareFunction getAPIParamWord],notch];
    }else{
        _url = [NSString stringWithFormat:@"%@?%@&notch=%@",_url,[SM_ShareFunction getAPIParamWord],notch];
    }
    NSLog(@"******%@",_url);
    _url = [_url stringByReplacingOccurrencesOfString:@" " withString:@""];
    _url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    self.request = request;
    [self.webView loadRequest:self.request];
    
    [RACObserve(self.webView,estimatedProgress)subscribeNext:^(id  _Nullable x) {
        NSNumber *num = (NSNumber *)x;
        if(num.floatValue >= 1.0){
            [self.progressView setProgress:0];
            [SMCustomActivityIndicatorView dismissActivityViewWithDelayTime:0];
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if(![self.currentURLStr containsString:appdelegate.smAppdelegate.currentNetworkUrl]) {
                [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.mas_offset(0);
                    make.top.mas_offset(88);
                }];
            }else{
                if([self.isScree isEqualToString:@"1"]){
                    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.right.bottom.mas_offset(0);
                    }];
                }else{
                    [self.webView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.bottom.mas_offset(0);
                        make.top.mas_offset(88);
                    }];
                }
            }
        }else{
            [self.progressView setProgress:num.floatValue animated:YES];
        }
    }];
    
    [RACObserve(self.webView, title) subscribeNext:^(id  _Nullable x) {
        self.titleLabel.text = (NSString *)x;
        self.title = (NSString *)x;
    }];
    
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 0.3);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [SMCustomActivityIndicatorView showActivityInWindowWithMessageStr:@"Loading"];
    });
}


-(void)buildNavView{
        self.navView = [[UIView alloc] init];
        self.navView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.navView];
        [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.top.mas_offset(0);
            if([SM_ShareFunction hasNotch] == 0){
                make.height.mas_equalTo(68);
            }else{
                make.height.mas_equalTo(88);
            }
        }];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [self.backBtn setImage:[UIImage imageNamed:@"H5Back"] forState:UIControlStateNormal];
        [self.navView addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(24);
            make.bottom.mas_offset(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.navView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.backBtn);
            make.centerX.mas_equalTo(self.navView);
        }];
}

-(void)setH5IsScree:(NSString *)isScree{
    self.isScree = isScree;
}

-(void)setH5ColorStyleWithTxtColor:(NSString *)txtColor bgColor:(NSString *)bgColor{
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = [[UIColor alloc] initWithHex:bgColor];
        appearance.shadowImage = [[UIImage alloc] init];
        NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: [[UIColor alloc] initWithHex:txtColor]};
        appearance.titleTextAttributes = titleTextAttributes;
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithHex:bgColor];
        NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [[UIColor alloc] initWithHex:txtColor]};
        self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
        [self.navigationController.navigationBar setBackgroundImage:[self generateImageWithColor:[[UIColor alloc] initWithHex:bgColor]] forBarMetrics:UIBarMetricsDefault];

    }
}

- (UIImage *)generateImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)backAction{
   [SMCustomActivityIndicatorView dismissActivityViewWithDelayTime:0];
   if(self.webView.canGoBack){
        [self.webView goBack];
    }else{
        if(_ifFromBank == YES){
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (instancetype)initWithURL:(NSString *)URL{
    if (self = [super init]) {
        _url = URL;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
  }
}
-(void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
  };
}

- (WKWebViewConfiguration *)baseConfig{
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = [WKUserContentController new];
    [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    config.processPool  = [LendEasy_WKProcessPool singleWkProcessPool];
    
    self.handler = [[SMWebHandler alloc] init];
    for (NSString *key in self.handler.handlers.allKeys) {
        [config.userContentController addScriptMessageHandler:self.handler name:key];
    }
    
     if (@available(iOS 10.0, *)) {
         config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
     } else {
         config.mediaTypesRequiringUserActionForPlayback = NO;
         config.allowsAirPlayForMediaPlayback = YES;
         config.mediaTypesRequiringUserActionForPlayback = NO;
     }
     config.allowsInlineMediaPlayback = YES;
     
     
    return config;
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    NSLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    if ([URL.scheme isEqualToString:@"http"]||
        [URL.scheme isEqualToString:@"https"]||
        [URL.scheme isEqualToString:@"file"]) {
        self.currentURLStr = URL.absoluteString;
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        if ([[UIApplication sharedApplication]canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL options:[NSDictionary new] completionHandler:nil];
        }else{
            if([URL.scheme isEqualToString:@"whatsapp"]){
                [SMCustomActivityIndicatorView showErrorProcessViewWithErrorStr:@"You have not installed WhatsApp yet."];
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SMCustomActivityIndicatorView showActivityInWindowWithMessageStr:@"Loading"];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SMCustomActivityIndicatorView dismissActivityViewWithDelayTime:0];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SMCustomActivityIndicatorView dismissActivityViewWithDelayTime:0];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SMCustomActivityIndicatorView dismissActivityViewWithDelayTime:0];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
           if ([challenge previousFailureCount] == 0) {
               NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
               completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
           } else {
               completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
           }
       } else {
           completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
       }
}
@end

@implementation LendEasy_WKProcessPool

+ (LendEasy_WKProcessPool*)singleWkProcessPool{
     static LendEasy_WKProcessPool * sharedPool;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          sharedPool = [[LendEasy_WKProcessPool alloc]  init];
     });
     return sharedPool;
}
@end
