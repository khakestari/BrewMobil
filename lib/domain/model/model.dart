class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(this.title, this.subtitle, this.image);
}

class Customer {
  String id;
  String name;
  int numOfNotification;

  Customer(this.id, this.name, this.numOfNotification);
}

class Contacts {
  String email;
  String phone;
  String link;

  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class Store {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String link;
  String title;
  String image;

  BannerAd(this.id, this.link, this.title, this.image);
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}
