
class CurrencyFormatter {
  static const String currencyName = "Tally";
  static const String currencySymbol = "Ⓣ"; // optional symbol

  static String format(double amount) {
    return "$currencyName ${amount.toStringAsFixed(2)}";
  }

  static String formatCompact(double amount) {
    return "${amount.toStringAsFixed(2)} $currencyName";
  }
}