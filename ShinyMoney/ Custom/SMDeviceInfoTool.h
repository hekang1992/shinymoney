//
//  CADeviceInfoTool.h
//  cashACEProject
//
//  Created by Apple on 2023/6/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SMDeviceInfoTool : NSObject
-(long long)SM_getTotalMemorySize;
-(long long)SM_getAvailableMemorySize;
-(long long)SM_getTotalDiskSize;
-(long long)SM_getAvailableDiskSize;
-(float)SM_getRealSize;
-(NSString *)SM_ifSimulator;
-(NSString *)SM_isJailBreak;
- (NSString *)SM_isOpenTheProxy;
- (NSString *)SM_isVPNOn;
-(NSString *)SM_getcarrierName;
- (NSString *)SM_getNetconnType;
-(NSString *)SM_getIPAddress;
- (NSDictionary *)SM_fetchSSIDInfo;
-(NSString *)SM_getCurrentDeviceInch;
@end

NS_ASSUME_NONNULL_END
