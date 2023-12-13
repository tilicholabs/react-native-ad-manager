// RNAdManagerBannerAdCache.m

#import "RNAdManagerBannerAdCache.h"

@implementation RNAdManagerBannerAdCache {
    NSMutableDictionary<NSString *, GADBannerView *> *_bannerAdCache;
}

RCT_EXPORT_MODULE(CTKAdManagerBannerAdCache)

+ (instancetype)sharedInstance {
    static RNAdManagerBannerAdCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _bannerAdCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)cacheBannerView:(GADBannerView *)bannerView
            forAdUnitID:(NSString *)adUnitID
       selectedCategory:(NSString *)selectedCategory
               adAtIndex:(NSString *)adIndex {
    if (bannerView && adUnitID && selectedCategory && adIndex) {
        NSString *resultKey = [self cacheKeyForAdUnitID:adUnitID selectedCategory:selectedCategory adAtIndex:adIndex];
        _bannerAdCache[resultKey] = bannerView;
        NSLog(@"Stored bannerView: %@ for adUnitID: %@ of selectedCategory: %@  adAtIndex: %@", bannerView, adUnitID, selectedCategory, adIndex);
    }
}

- (GADBannerView *)cachedBannerViewForAdUnitID:(NSString *)adUnitID
                                      selectedCategory:(NSString *)selectedCategory
                                              adAtIndex:(NSString *)adIndex {
    if (adUnitID && selectedCategory && adIndex) {
        NSString *resultKey = [self cacheKeyForAdUnitID:adUnitID selectedCategory:selectedCategory adAtIndex:adIndex];
        GADBannerView *cachedBannerView = _bannerAdCache[resultKey];
        if (cachedBannerView) {
            NSLog(@"Successfully fetched cachedBannerView: %@ for adUnitID: %@ of selectedCategory: %@  adAtIndex: %@", cachedBannerView, adUnitID, selectedCategory, adIndex);
            return cachedBannerView;
        }
    }
    return NULL;
}

- (NSString *)cacheKeyForAdUnitID:(NSString *)adUnitID
                selectedCategory:(NSString *)selectedCategory
                        adAtIndex:(NSString *)adIndex {
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%@_%@", adUnitID, selectedCategory, adIndex];
    return cacheKey;
}

- (void)clearCache {
    _bannerAdCache = [NSMutableDictionary dictionary];
    NSLog(@"Cleared cache Ad data");
}

RCT_EXPORT_METHOD(clearStoredCache) {
    [[RNAdManagerBannerAdCache sharedInstance] clearCache];
}


@end
