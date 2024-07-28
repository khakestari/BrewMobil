import 'package:advanced_shop_app/data/network/error_handler.dart';

import '../responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CATCH_HOME_INTERVAL = 60 * 1000; // one min in milis

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse HomeResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CatchedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() {
    CatchedItem? catchedItem = cacheMap[CACHE_HOME_KEY];
    if (catchedItem != null && catchedItem.isValid(CATCH_HOME_INTERVAL)) {
      return catchedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CatchedItem(homeResponse);
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
