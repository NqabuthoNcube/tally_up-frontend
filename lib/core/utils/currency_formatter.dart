/// core/utils/currency_formatter.dart

class CurrencyFormatter {
  /// Internal currency name used by the ledger system
  static const String currencyName = "Tally";

  /// Optional UI symbol
  static const String currencySymbol = "Ⓣ";

  /// Standard display format
  ///
  /// Example:
  /// Tally 120.50
  static String format(num amount) {
    final value = amount.toDouble();

    return "$currencyName ${value.toStringAsFixed(2)}";
  }

  /// Compact format
  ///
  /// Example:
  /// 120.50 Tally
  static String formatCompact(num amount) {
    final value = amount.toDouble();

    return "${value.toStringAsFixed(2)} $currencyName";
  }

  /// Format for ledger transaction lines
  ///
  /// Example:
  /// +12.00
  /// -5.50
  static String formatSigned(num amount) {
    final value = amount.toDouble();

    final sign = value >= 0 ? "+" : "-";

    return "$sign${value.abs().toStringAsFixed(2)}";
  }
}