import 'package:dartz/dartz.dart';

import './base_usecase.dart';
import '../../domain/model/model.dart';
import '../../domain/repository/repository.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.countryMobileCode,
      input.username,
      input.email,
      input.password,
      input.mobileNumber,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String username;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;
  RegisterUseCaseInput(this.countryMobileCode, this.username, this.email,
      this.password, this.mobileNumber, this.profilePicture);
}
