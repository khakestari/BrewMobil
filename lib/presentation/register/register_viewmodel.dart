// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:io';

import 'package:advanced_shop_app/domain/usecase/register_usecase.dart';
import '../../app/functions.dart';
import '../../presentation/common/state_renderer/state_renderer_impleneter.dart';
import '../base/baseviewmodel.dart';
import '../common/freezed_data_classes.dart';
import '../common/state_renderer/state_renderer.dart';

class RegisterViewmodel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  // StreamController isUserLoggedInSuccessfullyStreamController =
  //     StreamController<bool>();

  var registerViewObject = RegisterObject("", "", "", "", "", "");
  RegisterUseCase _registerUseCase;
  RegisterViewmodel(this._registerUseCase);

  /* #region Inputs */
  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();

    _isAllInputsValidStreamController.close();
    // isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.countryMobileCode,
            registerViewObject.username,
            registerViewObject.email,
            registerViewObject.password,
            registerViewObject.mobileNumber,
            registerViewObject.profilePicture)))
        .fold((failure) {
      // left -> failure
      inputState.add(
          ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
    }, (data) {
      // right -> success (data)
      inputState.add(ContentState());
      // navigate to main screen after the login
      // isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  Sink get inputemail => _emailStreamController.sink;

  @override
  Sink get inputmobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputpassword => _passwordStreamController.sink;

  @override
  Sink get inputprofilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputusername => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  /* #endregion */

  /* #region Outputs */
  @override
  Stream<bool> get outputIsUsernameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<String?> get outputErrorUsername => outputIsUsernameValid
      .map((isUsernameValid) => isUsernameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<File> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  /* #region Methods */
  bool _isUsernameValid(String username) {
    return username.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAllInputs() {
    return registerViewObject.countryMobileCode.isNotEmpty &&
        registerViewObject.username.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.profilePicture.isNotEmpty;
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(
          countryMobileCode: countryCode); // using data class like kotlin
    } else {
      registerViewObject = registerViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(
          password: password); // using data class like kotlin
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    if (profilePicture.path.isNotEmpty) {
      registerViewObject = registerViewObject.copyWith(
          profilePicture: profilePicture.path); // using data class like kotlin
    } else {
      registerViewObject = registerViewObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUsername(String username) {
    if (_isUsernameValid(username)) {
      // update register view object with username value
      registerViewObject = registerViewObject.copyWith(
          username: username); // using data class like kotlin
    } else {
      // reset username value in register view object
      registerViewObject = registerViewObject.copyWith(username: "");
    }
    _validate();
  }

  @override
  setmobileNumber(String mobileNumber) {
    if (_isMobileNumberValid(mobileNumber)) {
      registerViewObject =
          registerViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  /* #endregion */
}

abstract class RegisterViewModelInputs {
  // fuctions
  register();
  setUsername(String username);
  setEmail(String email);
  setPassword(String password);
  setCountryCode(String countryCode);
  setmobileNumber(String mobileNumber);
  setProfilePicture(File profilePicture);

  // sinks
  Sink get inputusername;
  Sink get inputemail;
  Sink get inputpassword;
  Sink get inputmobileNumber;
  Sink get inputprofilePicture;
  Sink get inputIsAllInputValid;
}

abstract class RegisterViewModelOutputs {
  // streams
  Stream<bool> get outputIsUsernameValid;
  Stream<String?> get outputErrorUsername;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<File> get outputIsProfilePictureValid;

  Stream<bool> get outputIsAllInputsValid;
}
