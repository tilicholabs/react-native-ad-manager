import com.google.android.gms.ads.admanager.AdManagerAdView;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import java.util.HashMap;
import java.util.Map;

@ReactModule(name = "CTKAdManagerBannerAdCache")
public class AdManagerBannerAdCache extends ReactContextBaseJavaModule {

    public static final String REACT_CLASS = "CTKAdManagerBannerAdCache";

    private static AdManagerBannerAdCache sharedInstance;
    private Map<String, AdManagerAdView> bannerAdCache;

    private AdManagerBannerAdCache() {
        bannerAdCache = new HashMap<>();
    }

    public static AdManagerBannerAdCache getSharedInstance() {
        if (sharedInstance == null) {
            synchronized (AdManagerBannerAdCache.class) {
                if (sharedInstance == null) {
                    sharedInstance = new AdManagerBannerAdCache();
                }
            }
        }
        return sharedInstance;
    }

    public void cacheBannerView(AdManagerAdView bannerView, String adUnitID, String selectedCategory, String adIndex) {
        if (bannerView != null && adUnitID != null && selectedCategory != null && adIndex != null) {
            String resultKey = cacheKeyForAdUnitID(adUnitID, selectedCategory, adIndex);
            bannerAdCache.put(resultKey, bannerView);
            Log.d("AdManagerBannerAdCache", "Stored bannerView: " + bannerView + " for adUnitID: " + adUnitID +
                    " of selectedCategory: " + selectedCategory + " adAtIndex: " + adIndex);
        }
    }

    public AdManagerAdView cachedBannerViewForAdUnitID(String adUnitID, String selectedCategory, String adIndex) {
        if (adUnitID != null && selectedCategory != null && adIndex != null) {
            String resultKey = cacheKeyForAdUnitID(adUnitID, selectedCategory, adIndex);
            AdManagerAdView cachedBannerView = bannerAdCache.get(resultKey);
            if (cachedBannerView != null) {
                Log.d("AdManagerBannerAdCache", "Successfully fetched cachedBannerView: " + cachedBannerView +
                        " for adUnitID: " + adUnitID + " of selectedCategory: " + selectedCategory +
                        " adAtIndex: " + adIndex);
                return cachedBannerView;
            }
        }
        return null;
    }

    private String cacheKeyForAdUnitID(String adUnitID, String selectedCategory, String adIndex) {
        return adUnitID + "_" + selectedCategory + "_" + adIndex;
    }

    @ReactMethod
    public void clearCache() {
        bannerAdCache.clear();
        Log.d("AdManagerBannerAdCache", "Cleared cache Ad data");
    }

    public void clearStoredCache() {
        getSharedInstance().clearCache();
    }
}

