import 'dart:ffi';

import 'package:advanced_shop_app/domain/model/model.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecase/store_details_usecase.dart';
import '../base/baseviewmodel.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impleneter.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  void start() {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await storeDetailsUseCase.execute(Void)).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
      },
      (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetails> get outputStoreDetails;
}
