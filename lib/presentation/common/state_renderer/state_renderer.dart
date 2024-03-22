// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'package:advanced_shop_app/presentation/resources/color_manager.dart';
import 'package:advanced_shop_app/presentation/resources/font_manager.dart';
import 'package:advanced_shop_app/presentation/resources/styles_manager.dart';
import 'package:advanced_shop_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../../../data/network/failure.dart';
import '../../../data/mapper/mapper.dart';
import '../../../presentation/resources/strings_manager.dart';

enum StateRendererType {
// POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
// FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE, // EMPTY VIEW WHEN WE RECIEVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function? retryActionFunction;
  StateRenderer({
    Key? key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        break;
      case StateRendererType.POPUP_ERROR_STATE:
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimatedImage(),
          _getMessage(failure.message),
          _getRetryButton(AppStrings.retry_again, context),
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
      case StateRendererType.EMPTY_SCREEN_STATE:
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      // child:
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunction
                      ?.call(); // to call the api function again to retry
                } else {
                  Navigator.of(context)
                      .pop(); // popup state error so we need to dismiss the dialog
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
