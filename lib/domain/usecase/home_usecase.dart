import 'package:advanced_shop_app/data/network/failure.dart';
import 'package:advanced_shop_app/domain/model/model.dart';
import 'package:advanced_shop_app/domain/repository/repository.dart';
import 'package:advanced_shop_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
