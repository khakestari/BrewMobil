import 'package:advanced_shop_app/data/mapper/mapper.dart';

import '../../../presentation/resources/strings_manager.dart';

import './state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getmessage();
}

// Loading State(POPUP, FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
  @override
  String getmessage() => message;
}

// Error State (POPUP, FULL LOADING)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  StateRendererType getStateRendererType() => stateRendererType;
  @override
  String getmessage() => message;
}

// Content State

class ContentState extends FlowState {
  ContentState();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
  @override
  String getmessage() => EMPTY;
}

// Empty State

class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
  @override
  String getmessage() => message;
}
