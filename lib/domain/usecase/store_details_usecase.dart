import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import './base_usecase.dart';
import '../model/model.dart';
import '../repository/repository.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository _repository;
  StoreDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await _repository.getStoreDetails();
  }
}
