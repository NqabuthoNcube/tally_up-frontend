/// core/flow/flow_controller.dart
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_flow_state.dart';

/// Controls application navigation flow.
class FlowController extends StateNotifier<AppFlowState> {
  FlowController() : super(AppFlowState.landing);

  void goTo(AppFlowState next) {
    if (state == next) return;
    state = next;
  }

  void resetToHome() => state = AppFlowState.home;
  void logout() => state = AppFlowState.landing;
  void startSendFlow() => state = AppFlowState.sendRecipient;
  void recipientSelected() => state = AppFlowState.sendAmount;
  void amountEntered() => state = AppFlowState.sendConfirm;
  void transferCompleted() => state = AppFlowState.sendSuccess;
  void openHistory() => state = AppFlowState.history;
  void openMyQr() => state = AppFlowState.qrMy;
  void openQrScanner() => state = AppFlowState.qrScan;
}

final flowProvider =
    StateNotifierProvider<FlowController, AppFlowState>(
  (ref) => FlowController(),
);