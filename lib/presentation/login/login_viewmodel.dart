import 'dart:async';

import '../base/baseviewmodel.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  
  var loginObject = LoginObject("","");
  
  // inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
  }

  // outputs
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUserNameValid(String username) {
    return username.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  // three fuctions
  setUserName(String userName);
  setPassword(String password);
  login();
  // two sinks
  // Sink get inputUserName => _streamController.sink;
  // Sink get inputPassword => _streamController.sink;
}

abstract class LoginViewModelOutputs {
  // two streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
