//
//  LuckyPesoChooseDateView.h
//  LuckyPesoProject
//
//  Created by Apple on 2023/12/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LuckyPesoChooseDateView : UIView
@property (strong, nonatomic) IBOutlet UIView *pesoContentView;
@property (nonatomic, strong) NSString *dateStr;
@property (strong, nonatomic) IBOutlet UILabel *pesoChangeDateLabel;
@property (nonatomic, copy)void(^confirmBlock)(NSString *dateStr);
@property (nonatomic, copy)void(^cancelBlock)(void);
@end

NS_ASSUME_NONNULL_END
