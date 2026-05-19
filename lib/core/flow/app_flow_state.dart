/// core/flow/app_flow_state.dart
///
/// Represents the navigation state machine for the app.
/// The FlowRouter renders UI based on this state.
library;

enum AppFlowState {
  /// Splash / landing page
  landing,

  /// Authentication
  authLogin,
  authOtp,

  /// Main application shell
  home,

  /// Send transaction flow
  sendRecipient,
  sendAmount,
  sendConfirm,
  sendSuccess,

  /// Wallet history
  history,

  /// QR features
  qrMy,
  qrScan,
}