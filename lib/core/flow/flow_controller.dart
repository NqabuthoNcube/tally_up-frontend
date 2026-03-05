import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_flow_state.dart';

class FlowController extends StateNotifier<AppFlowState> {
  FlowController() : super(AppFlowState.authOtp);

  void goTo(AppFlowState state) {
    this.state = state;
  }

  void resetToHome() {
    state = AppFlowState.home;
  }
}

final flowProvider =
    StateNotifierProvider<FlowController, AppFlowState>((ref) {
  return FlowController();
});