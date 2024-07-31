import 'dart:io';
import 'package:advanced_shop_app/app/app_prefs.dart';
import 'package:advanced_shop_app/app/di.dart';
import 'package:advanced_shop_app/data/mapper/mapper.dart';
import 'package:advanced_shop_app/presentation/common/state_renderer/state_renderer_impleneter.dart';
import 'package:advanced_shop_app/presentation/register/register_viewmodel.dart';
import 'package:advanced_shop_app/presentation/resources/color_manager.dart';
import 'package:advanced_shop_app/presentation/resources/routes_manager.dart';
import 'package:advanced_shop_app/presentation/resources/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewmodel _viewmodel = instance<RegisterViewmodel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  ImagePicker picker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewmodel.start();
    _usernameController.addListener(() {
      _viewmodel.setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      _viewmodel.setPassword(_passwordController.text);
    });
    _emailController.addListener(() {
      _viewmodel.setEmail(_emailController.text);
    });
    _mobileNumberController.addListener(() {
      _viewmodel.setmobileNumber(_mobileNumberController.text);
    });

    _viewmodel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLoggedIn) {
      // navigate to main screen
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _appPreferences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewmodel.outputState,
          builder: (context, snapshot) {
            return Center(
              child: snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewmodel.register();
                  }) ??
                  _getContentWidget(),
            );
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p30),
      // color: ColorManager.darkPrimary,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(
                image: AssetImage(ImageAssets.splashLogo),
                height: 250,
                width: 250,
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewmodel.outputErrorUsername,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppStrings.username.tr(),
                          labelText: AppStrings.username.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: AppPadding.p16,
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                      bottom: AppPadding.p16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onInit: (country) {
                            _viewmodel
                                .setCountryCode(country?.dialCode ?? EMPTY);
                          },
                          onChanged: (country) {
                            _viewmodel
                                .setCountryCode(country.dialCode ?? EMPTY);
                          },
                          dialogBackgroundColor: ColorManager.black,
                          initialSelection: "+98",
                          hideMainText: true,
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: true,
                          favorite: ["+98", "+966"],
                          flagWidth: 40,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: StreamBuilder<String?>(
                            stream: _viewmodel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                controller: _mobileNumberController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: AppStrings.mobileNumber.tr(),
                                  labelText: AppStrings.mobileNumber.tr(),
                                  errorText: snapshot.data,
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<String?>(
                    stream: _viewmodel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppStrings.emailHint.tr(),
                          labelText: AppStrings.emailHint.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p16,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                    bottom: AppPadding.p16),
                child: StreamBuilder<String?>(
                    stream: _viewmodel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: AppStrings.password.tr(),
                          labelText: AppStrings.password.tr(),
                          errorText: snapshot.data,
                        ),
                      );
                    }),
              ),
              // const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                    bottom: AppPadding.p16),
                child: Container(
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.lightGrey),
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSize.s12)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _getMediaWidget(),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s28),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: StreamBuilder<bool>(
                  stream: _viewmodel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewmodel.register();
                                }
                              : null,
                          child: const Text(AppStrings.register).tr()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: TextButton(
                  onPressed: () {
                    initForgotPasswordModule();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.haveAccount,
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.camera),
                title: Text(AppStrings.photoGallery).tr(),
                onTap: () {
                  _imageFromGallary();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.browse_gallery),
                title: Text(AppStrings.photoCamera).tr(),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallary() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewmodel.setProfilePicture(File(image?.path ?? EMPTY));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewmodel.setProfilePicture(File(image?.path ?? EMPTY));
  }

  Widget _getMediaWidget() {
    return Padding(
        padding: EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(AppStrings.profilePicture).tr()),
            Flexible(
              child: StreamBuilder<File?>(
                  stream: _viewmodel.outputProfilePicture,
                  builder: (context, snapshot) {
                    return _imagePickedByUser(snapshot.data);
                  }),
            ),
            Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
          ],
        ));
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }
}
