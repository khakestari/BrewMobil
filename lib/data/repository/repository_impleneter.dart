import 'package:dartz/dartz.dart';

import '../../data/network/error_handler.dart';
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
      try {
        // its safe to call the api
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data
          return Right(response.toDomain());
        } else {
          // return biz logic error
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
