// to convert the response into non nullable object (model)
import '../../app/extensions.dart';

import '../../domain/model/model.dart';
import '../responses/responses.dart';

// mapper use to convert responses to domain models
const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoreResponseMapper on StoreResponse {
  Store toDomain() {
    return Store(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(this?.id?.orZero() ?? ZERO, this?.link?.orEmpty() ?? EMPTY,
        this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Service>()
            .toList();
    List<Banner> mappedBanners =
        (this?.data?.banners?.map((banners) => banners.toDomain()) ??
                Iterable.empty())
            .cast<Banner>()
            .toList();

    List<Store> mappedStores =
        (this?.data?.stores?.map((stores) => stores.toDomain()) ??
                Iterable.empty())
            .cast<Store>()
            .toList();

    var data = HomeData(mappedServices, mappedBanners, mappedStores);
    return HomeObject(data);
  }
}
