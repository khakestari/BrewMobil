import 'package:dartz/dartz.dart';

import '../../data/mapper/mapper.dart';
import '../../data/network/network_info.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../../domain/model.dart';
import '../../domain/repository.dart';

class RepositoryImplementer extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  RepositoryImplementer(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its safe to call the api
      final response = await _remoteDataSource.login(loginRequest);
      if (response.status == 0) // success
      {
        // return data
        return Right(response.toDomain());
      } else {
        // return biz logic error
        return Left(Failure(
            409, response.message ?? "We have biz error logic from api side!"));
      }
    } else {
      // return connection error
      return Left(Failure(501, "Please check your internet connection"));
    }
  }
}
