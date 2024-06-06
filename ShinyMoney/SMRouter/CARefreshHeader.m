//
//  YBRefreshHeader.m
//  youonBikePlanA
//
//  Created by karry on 2020/4/10.
//  Copyright © 2020 audi. All rights reserved.
//

#import "CARefreshHeader.h"

@implementation CARefreshHeader
+(instancetype)headerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock{
    CARefreshHeader *header =  [super headerWithRefreshingBlock:refreshingBlock];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.stateLabel.text = @"";
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    return header;
}

@end

@implementation CARefreshFooter

+(instancetype)footerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock{
    CARefreshFooter *footer =  [super footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.textColor = [UIColor whiteColor];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    return footer;
}

@end
