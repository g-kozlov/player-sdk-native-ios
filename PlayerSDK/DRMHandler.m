//
//  DRMHandler.m
//  KALTURAPlayerSDK
//
//  Created by Nissim Pardo on 3/19/15.
//  Copyright (c) 2015 Kaltura. All rights reserved.
//

#if !(TARGET_IPHONE_SIMULATOR)
#import "DRMHandler.h"
//#import "WViPhoneAPI.h"
#import "KPLog.h"

static NSString *kPortalKey = @"kaltura";

@implementation DRMHandler
+ (void)DRMSource:(NSString *)src key:(NSString *)key completion:(void (^)(NSString *))completion {
    WV_Initialize(WVCallback, @{KPWVDRMServerKey: key, KPWVPortalKey: kPortalKey});
    [self performSelector:@selector(fetchDRMParams:) withObject:@[src, completion] afterDelay:0.1];
}

+ (void)fetchDRMParams:(NSArray *)params {
    NSMutableString *responseUrl = [NSMutableString string];
    KPWViOsApiStatus status = WV_Play(params[0], responseUrl, 0);
    KPLogDebug(@"widevine response url: %@", responseUrl);
    if ( status != KPWViOsApiStatus_OK ) {
        KPLogError(@"ERROR: %u",status);
        return;
    }
    ((void(^)(NSString *))params[1])(responseUrl);
}

+ (void)fetchDRMSource:(NSString *)src key:(NSString *)key completion:(void(^)(NSString *))completion {
    
}

KPWViOsApiStatus WVCallback( KPWViOsApiEvent event, NSDictionary *attributes ) {
    KPLogTrace(@"Enter");
    KPLogInfo( @"callback %d %@\n", event, NSStringFromWViOsApiEvent( event ) );
    
    KPLogTrace(@"Exit");
    return KPWViOsApiStatus_OK;
}

@end
#endif
