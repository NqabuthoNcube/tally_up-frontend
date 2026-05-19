/// core/utils/phone_utils.dart
library;

class PhoneUtils {
  /// Normalize Zimbabwe phone numbers to E.164 format.
  ///
  /// Example:
  /// 0771234567 -> +263771234567
  /// 263771234567 -> +263771234567
  /// +263771234567 -> +263771234567
  static String? normalizeZimbabwePhone(String input) {
    if (input.isEmpty) return null;

    String phone = input.replaceAll(RegExp(r'\s+'), '');

    if (phone.startsWith('+263')) {
      return phone;
    }

    if (phone.startsWith('263')) {
      return '+$phone';
    }

    if (phone.startsWith('0') && phone.length == 10) {
      return '+263${phone.substring(1)}';
    }

    return null;
  }

  /// Validate Zimbabwe mobile number
  static bool isValidZimbabwePhone(String input) {
    final normalized = normalizeZimbabwePhone(input);

    if (normalized == null) return false;

    final regex = RegExp(r'^\+2637\d{8}$');

    return regex.hasMatch(normalized);
  }

  /// Mask phone for display
  ///
  /// Example:
  /// +263771234567 -> +26377****567
  static String maskPhone(String phone) {
    if (phone.length < 7) return phone;

    final start = phone.substring(0, 6);
    final end = phone.substring(phone.length - 3);

    return "$start****$end";
  }
}