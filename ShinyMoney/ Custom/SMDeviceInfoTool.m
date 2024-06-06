//
//  CADeviceInfoTool.m
//  cashACEProject
//
//  Created by Apple on 2023/6/30.
//

#import "SMDeviceInfoTool.h"
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <mach/mach.h>
#include <sys/mount.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <sys/sockio.h>
#include <sys/ioctl.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
@implementation SMDeviceInfoTool
-(long long)SM_getTotalMemorySize{
   return [NSProcessInfo processInfo].physicalMemory;
}

-(long long)SM_getAvailableMemorySize{
  vm_statistics_data_t vmStats;
  mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
  kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
  if (kernReturn != KERN_SUCCESS){
    return 0;
  }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

-(long long)SM_getTotalDiskSize{
  struct statfs buf;
  unsigned long long freeSpace = -1;
  if (statfs("/var", &buf) >= 0){
    freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
  }
   return freeSpace;
}

-(long long)SM_getAvailableDiskSize{
  struct statfs buf;
  unsigned long long freeSpace = -1;
  if (statfs("/var", &buf) >= 0){
     freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
  }
     return freeSpace;
}

-(float)SM_getRealSize{
    return 0;
}

-(NSString *)SM_ifSimulator{
    if(TARGET_IPHONE_SIMULATOR){
        return @"1";
    }else{
        return @"0";
    }
}

-(NSString *)SM_isJailBreak{
    NSArray *jailbreak_tool_paths = @[
          @"/Applications/Cydia.app",
          @"/Library/MobileSubstrate/MobileSubstrate.dylib",
          @"/bin/bash",
          @"/usr/sbin/sshd",
          @"/etc/apt"
      ];
      for (int i=0; i<jailbreak_tool_paths.count; i++) {
          if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
              return @"1";
          }
      }
      return @"0";
}

- (NSString *)SM_isOpenTheProxy{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]) {
        return @"0";
    } else {
        return @"1";
    }
}

- (NSString *)SM_isVPNOn{
   NSString *flag = @"0";
   NSString *version = [UIDevice currentDevice].systemVersion;
   if (version.doubleValue >= 9.0){
       NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
       NSArray *keys = [dict[@"__SCOPED__"] allKeys];
       for (NSString *key in keys) {
           if ([key rangeOfString:@"tap"].location != NSNotFound ||
               [key rangeOfString:@"tun"].location != NSNotFound ||
               [key rangeOfString:@"ipsec"].location != NSNotFound ||
               [key rangeOfString:@"ppp"].location != NSNotFound){
               flag = @"1";
               break;
           }
       }
   }
   else
   {
       struct ifaddrs *interfaces = NULL;
       struct ifaddrs *temp_addr = NULL;
       int success = 0;
        success = getifaddrs(&interfaces);
       if (success == 0){
           temp_addr = interfaces;
           while (temp_addr != NULL)
           {
               NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
               if ([string rangeOfString:@"tap"].location != NSNotFound ||
                   [string rangeOfString:@"tun"].location != NSNotFound ||
                   [string rangeOfString:@"ipsec"].location != NSNotFound ||
                   [string rangeOfString:@"ppp"].location != NSNotFound)
               {
                   flag = @"1";
                   break;
               }
               temp_addr = temp_addr->ifa_next;
           }
       }
        freeifaddrs(interfaces);
   }
   return flag;
}

-(NSString *)SM_getcarrierName{
   CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *mobile;
    if (!carrier.isoCountryCode) {
       mobile = @"";
    }else{
       mobile = [carrier carrierName];
    }
   return mobile?mobile:@"";
}

- (NSString *)SM_getNetconnType{
    NSString *netconnType = @"";
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
        {
            netconnType = @"Unknown Network";
        }
            break;
        case ReachableViaWiFi:
        {
            netconnType = @"WIFI";
        }
            break;
            
        case ReachableViaWWAN:
        {
            netconnType = @"4G";
        }
            break;
            
        default:
            netconnType = @"";
            break;
    }
    
    return netconnType;
}

-(NSString *)SM_getIPAddress {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0) {
    for (ptr = buffer; ptr < buffer + ifc.ifc_len; ) {
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0)continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i = 0; i < ips.count; i++) {
        if(ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@", ips.lastObject];
        }
    }
    return deviceIP;
}

- (NSDictionary *)SM_fetchSSIDInfo{
    NSString *currentSSID = @"";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil){
        NSDictionary* myDict = (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict!=nil){
            currentSSID=[myDict valueForKey:@"SSID"];
        } else {
            currentSSID=@"<<NONE>>";
        }
    } else {
        currentSSID=@"<<NONE>>";
    }
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    NSLog(@"%s: Supported interfaces: %@", __func__, ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((CFStringRef)CFBridgingRetain(ifnam));
        if (info && [info count]) {
            break;
        }
    }
    NSLog(@"wifi info %@",info);
    return info;
}

 -(NSString *)SM_getCurrentDeviceInch{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if([phoneType  isEqualToString:@"iPhone3,1"])  return @"3.5";
    if([phoneType  isEqualToString:@"iPhone3,2"])  return @"3.5";
    if([phoneType  isEqualToString:@"iPhone3,3"])  return @"3.5";
    if([phoneType  isEqualToString:@"iPhone4,1"])  return @"3.5";
    if([phoneType  isEqualToString:@"iPhone5,1"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone5,2"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone5,3"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone5,4"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone6,1"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone6,2"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone7,1"])  return @"5.5";
    if([phoneType  isEqualToString:@"iPhone7,2"])  return @"4.7";
    if([phoneType  isEqualToString:@"iPhone8,1"])  return @"4.7";
    if([phoneType  isEqualToString:@"iPhone8,2"])  return @"5.5";
    if([phoneType  isEqualToString:@"iPhone8,4"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone9,1"])  return @"4";
    if([phoneType  isEqualToString:@"iPhone9,2"])  return @"5.5";
    if([phoneType  isEqualToString:@"iPhone9,4"])  return @"5.5";
    if([phoneType  isEqualToString:@"iPhone10,1"]) return @"4.7";
    if([phoneType  isEqualToString:@"iPhone10,4"]) return @"4.7";
    if([phoneType  isEqualToString:@"iPhone10,2"]) return @"5.5";
    if([phoneType  isEqualToString:@"iPhone10,5"]) return @"5.5";
    if([phoneType  isEqualToString:@"iPhone10,3"]) return @"5.8";
    if([phoneType  isEqualToString:@"iPhone10,6"]) return @"5.8";
    if([phoneType  isEqualToString:@"iPhone11,8"]) return @"6.1";
    if([phoneType  isEqualToString:@"iPhone11,2"]) return @"5.8";
    if([phoneType  isEqualToString:@"iPhone11,4"]) return @"6.5";
    if([phoneType  isEqualToString:@"iPhone11,6"]) return @"6.5";
    if([phoneType  isEqualToString:@"iPhone12,1"])  return @"5.8";
    if ([phoneType isEqualToString:@"iPhone12,3"])  return @"5.8";
    if ([phoneType isEqualToString:@"iPhone12,5"])   return @"6.5";
    if ([phoneType isEqualToString:@"iPhone12,8"])   return @"4";
    if ([phoneType isEqualToString:@"iPhone13,1"])    return @"5.4";
    if ([phoneType isEqualToString:@"iPhone13,2"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone13,3"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone13,4"])    return @"6.7";
    if ([phoneType isEqualToString:@"iPhone14,4"])    return @"5.4";
    if ([phoneType isEqualToString:@"iPhone14,5"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone14,2"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone14,3"])    return @"6.7";
    if ([phoneType isEqualToString:@"iPhone14,6"])    return @"5.4";
    if ([phoneType isEqualToString:@"iPhone14,7"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone14,8"])    return @"6.7";
    if ([phoneType isEqualToString:@"iPhone15,2"])    return @"6.1";
    if ([phoneType isEqualToString:@"iPhone15,3"])    return @"6.7";
    
    return @"3.5";
}
@end
