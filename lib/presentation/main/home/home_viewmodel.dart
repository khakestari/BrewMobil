import 'dart:async';
import 'dart:ffi';
import 'package:advanced_shop_app/domain/model/model.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/baseviewmodel.dart';
import '../../../domain/usecase/home_usecase.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impleneter.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  StreamController _dataStreamController = BehaviorSubject<HomeViewObject>();

  // input
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            }, (homeObject) {
      // right -> success (data)
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.banners,
          homeObject.data.services, homeObject.data.stores));
    });
  }

  // output
  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // outputs

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<BannerAd> banners;
  List<Service> services;
  List<Store> stores;

  HomeViewObject(this.banners, this.services, this.stores);
}
