/// core/flow/flow_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_flow_state.dart';

/// Controls application navigation flow.
///
/// The UI router listens to this provider and renders
/// the correct screen when the state changes.
class FlowController extends StateNotifier<AppFlowState> {
  FlowController() : super(AppFlowState.authLogin);

  /// Navigate to a specific state
  void goTo(AppFlowState next) {
    if (state == next) return;
    state = next;
  }

  /// Reset navigation to home
  void resetToHome() {
    state = AppFlowState.home;
  }

  /// Logout flow
  void logout() {
    state = AppFlowState.authLogin;
  }

  /// Send flow helpers

  void startSendFlow() {
    state = AppFlowState.sendRecipient;
  }

  void recipientSelected() {
    state = AppFlowState.sendAmount;
  }

  void amountEntered() {
    state = AppFlowState.sendConfirm;
  }

  void transferCompleted() {
    state = AppFlowState.sendSuccess;
  }

  void openHistory() {
    state = AppFlowState.history;
  }

  void openMyQr() {
    state = AppFlowState.qrMy;
  }

  void openQrScanner() {
    state = AppFlowState.qrScan;
  }
}

/// Riverpod provider
final flowProvider =
    StateNotifierProvider<FlowController, AppFlowState>(
  (ref) => FlowController(),
);