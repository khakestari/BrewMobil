import 'package:advanced_shop_app/data/network/error_handler.dart';

import '../responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CATCH_HOME_INTERVAL = 60 * 1000; // one min in milis

const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCach();

  void removeFromCatch(String key);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse detailResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CatchedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() async {
    CatchedItem? catchedItem = cacheMap[CACHE_HOME_KEY];
    print(catchedItem?.data ?? "null shode");
    print("baaaaaaa");
    if (catchedItem != null && catchedItem.isValid(CATCH_HOME_INTERVAL)) {
      print(catchedItem.data);
      print("here we return");
      return catchedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CatchedItem(homeResponse);
  }

  @override
  void clearCach() {
    cacheMap.clear();
  }

  @override
  void removeFromCatch(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CatchedItem? catchedItem = cacheMap[CACHE_STORE_DETAILS_KEY];
    if (catchedItem != null &&
        catchedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return catchedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(
      StoreDetailsResponse detailResponse) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CatchedItem(detailResponse);
  }
}

class CatchedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CatchedItem(this.data);
}

extension CatchedItemExtension on CatchedItem {
  bool isValid(int expirationTime) {
    int currentTimeinMillis = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = (currentTimeinMillis - expirationTime) < cacheTime;
    return isCacheValid;
  }
}
