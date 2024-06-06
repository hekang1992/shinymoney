//
//  CodeInputView.h
//  JDZBorrower
//
//  Created by WangXueqi on 2018/4/20.
//  Copyright © 2018 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCodeBlock)(NSString *);
@interface CodeInputView : UIView
@property(nonatomic,copy)SelectCodeBlock CodeBlock;
@property(nonatomic,assign)NSInteger inputNum;
- (instancetype)initWithFrame:(CGRect)frame inputType:(NSInteger)inputNum selectCodeBlock:(SelectCodeBlock)CodeBlock;
@end
