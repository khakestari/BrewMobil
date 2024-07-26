import 'package:advanced_shop_app/app/di.dart';
import 'package:advanced_shop_app/presentation/common/state_renderer/state_renderer_impleneter.dart';
import 'package:advanced_shop_app/presentation/register/register_viewmodel.dart';
import 'package:advanced_shop_app/presentation/resources/color_manager.dart';
import 'package:advanced_shop_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewmodel _viewmodel = instance<RegisterViewmodel>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameTextEditingController =
      TextEditingController();
  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewmodel.start();
    _usernameTextEditingController.addListener(() {
      _viewmodel.setUsername(_usernameTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewmodel.setPassword(_passwordTextEditingController.text);
    });
    _emailTextEditingController.addListener(() {
      _viewmodel.setEmail(_emailTextEditingController.text);
    });
    _mobileNumberTextEditingController.addListener(() {
      _viewmodel.setmobileNumber(_mobileNumberTextEditingController.text);
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
    return Center();
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }
}
