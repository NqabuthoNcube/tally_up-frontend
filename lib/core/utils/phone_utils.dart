class PhoneUtils {
  static String normalizeZimbabwePhone(String input) {
    String phone = input.replaceAll(RegExp(r'\s+'), '');

    if (phone.startsWith('+263')) {
      return phone;
    }

    if (phone.startsWith('263')) {
      return '+$phone';
    }

    if (phone.startsWith('0')) {
      return '+263${phone.substring(1)}';
    }

    throw Exception('Invalid Zimbabwe phone number');
  }

  static bool isValidZimbabwePhone(String input) {
    final normalized = normalizeZimbabwePhone(input);

    final regex = RegExp(r'^\+2637[0-9]{8}$');
    return regex.hasMatch(normalized);
  }
}