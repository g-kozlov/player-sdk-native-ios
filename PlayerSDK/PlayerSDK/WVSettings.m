//
//  WVSettings.m
//  Kaltura
//
//  Created by Eliza Sapir on 6/3/13.
//
//

#import "WVSettings.h"
#import "WViPhoneAPI.h"

@implementation WVSettings

@synthesize drmServer, portalId;

-(BOOL) isNativeAdapting{
    return nativeAdapting;
}

-(NSDictionary*) initializeDictionary:(NSString *)flavorId andKS: (NSString*) ks{
    NSString* hostName = @"http://www.kaltura.com";
//    NSString* portalId, *drmServer;
    self.portalId = @"kaltura";

    //EMM
    self.drmServer = [[NSString alloc] initWithFormat: @"%@/api_v3/index.php?service=widevine_widevinedrm&action=getLicense&format=widevine&flavorAssetId=%@&ks=%@" , hostName, flavorId, ks];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    nativeAdapting = [defaults boolForKey:@"native_adapting"];

    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.drmServer, WVDRMServerKey,
                                self.portalId, WVPortalKey,
//                                ((nativeAdapting == YES)?@"1":@"0"), WVPlayerDrivenAdaptationKey,
                                NULL];
    
    return dictionary;
}

@end
