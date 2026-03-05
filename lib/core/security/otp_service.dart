import 'dart:math';

class OtpService {

  static String generateOtp(String phone) {

    final seed = phone.hashCode;
    final random = Random(seed);

    final otp = random.nextInt(900000) + 100000;

    return otp.toString();
  }
}