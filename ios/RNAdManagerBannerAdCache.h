// RNAdManagerBannerAdCache.h

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <React/RCTBridgeModule.h>

@interface RNAdManagerBannerAdCache : NSObject <RCTBridgeModule>

+ (instancetype)sharedInstance;

- (GADBannerView *)cachedBannerViewForAdUnitID:(NSString *)adUnitID
                                      selectedCategory:(NSString *)selectedCategory
                                              adAtIndex:(NSString *)adIndex;

- (void)cacheBannerView:(GADBannerView *)bannerView
            forAdUnitID:(NSString *)adUnitID
       selectedCategory:(NSString *)selectedCategory
               adAtIndex:(NSString *)adIndex;

- (void)clearCache;

@end
