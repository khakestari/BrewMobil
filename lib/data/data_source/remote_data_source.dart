import '../responses/responses.dart';
import '../request/request.dart';
import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password, "", ""
        // loginRequest.imei,
        // loginRequest.deviceType,
        );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.countryMobileCode,
        registerRequest.username,
        registerRequest.email,
        registerRequest.password,
        registerRequest.mobileNumber,
        ""
        // registerRequest.profilePicture,
        );
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServiceClient.getHome();
  }
}
