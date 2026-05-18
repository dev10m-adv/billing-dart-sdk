/// Card brand detected from the IIN / BIN prefix.
enum CardBrand {
  visa,
  mastercard,
  amex,
  discover,
  jcb,
  dinersClub,
  unionPay,
  other,
}

/// Result of [CardValidator.validateCardNumber].
class CardNumberResult {
  const CardNumberResult({
    required this.isValid,
    required this.brand,
    this.last4,
    this.error,
  });

  final bool isValid;
  final CardBrand brand;

  /// Last four digits of the card number. Non-null only when [isValid] is true.
  final String? last4;

  /// Human-readable error description. Non-null only when [isValid] is false.
  final String? error;
}

/// Result of [CardValidator.validateExpiry].
class ExpiryResult {
  const ExpiryResult({required this.isValid, this.error});

  final bool isValid;

  /// Human-readable error description. Non-null only when [isValid] is false.
  final String? error;
}

/// Pure-Dart card validation utilities. No Flutter dependencies.
///
/// Handles:
/// - Real-time card number formatting (4-4-4-4 or Amex 4-6-5)
/// - Brand detection from IIN/BIN prefix
/// - Luhn (mod-10) algorithm
/// - Expiry date range and past-expiry check
/// - CVV length check by brand
///
/// Usage:
/// ```dart
/// final result = CardValidator.validateCardNumber('4242 4242 4242 4242');
/// if (result.isValid) print('${CardValidator.brandName(result.brand)} *${result.last4}');
/// ```
class CardValidator {
  CardValidator._();

  // ── Formatting ─────────────────────────────────────────────────────────────

  /// Formats a raw digit string into display groups for the given [brand].
  ///
  /// - Amex: 4-6-5 (15 digits max)
  /// - All others: 4-4-4-4 (16 digits max)
  ///
  /// Strips non-digit characters before grouping. Safe to call on partial input.
  static String formatCardNumber(String raw, {CardBrand? brand}) {
    final digits = _digitsOnly(raw);
    final b = brand ?? detectBrand(digits);
    return b == CardBrand.amex
        ? _group(digits, const [4, 6, 5])
        : _group(digits, const [4, 4, 4, 4]);
  }

  static String _group(String digits, List<int> groups) {
    final max = groups.fold(0, (a, b) => a + b);
    final src = digits.length > max ? digits.substring(0, max) : digits;
    final buf = StringBuffer();
    var pos = 0;
    for (final len in groups) {
      if (pos >= src.length) break;
      if (pos > 0) buf.write(' ');
      final end = (pos + len).clamp(0, src.length);
      buf.write(src.substring(pos, end));
      pos += len;
    }
    return buf.toString();
  }

  // ── Brand detection ────────────────────────────────────────────────────────

  /// Detects [CardBrand] from the leading digits (IIN/BIN prefix).
  ///
  /// Safe on partial input — returns [CardBrand.other] when not enough digits
  /// are available yet to make a determination.
  static CardBrand detectBrand(String raw) {
    final d = _digitsOnly(raw);
    if (d.isEmpty) return CardBrand.other;

    // Visa: starts with 4
    if (d.startsWith('4')) return CardBrand.visa;

    // Mastercard: 51–55 or 2221–2720
    if (d.length >= 2) {
      final two = int.tryParse(d.substring(0, 2));
      if (two != null && two >= 51 && two <= 55) return CardBrand.mastercard;
    }
    if (d.length >= 4) {
      final four = int.tryParse(d.substring(0, 4));
      if (four != null && four >= 2221 && four <= 2720) return CardBrand.mastercard;
    }

    // Amex: 34, 37
    if (d.length >= 2 && (d.startsWith('34') || d.startsWith('37'))) {
      return CardBrand.amex;
    }

    // Discover: 6011, 622126–622925, 644–649, 65
    if (d.startsWith('6011') || d.startsWith('65')) return CardBrand.discover;
    if (d.length >= 6) {
      final six = int.tryParse(d.substring(0, 6));
      if (six != null && six >= 622126 && six <= 622925) return CardBrand.discover;
    }
    if (d.length >= 3) {
      final three = int.tryParse(d.substring(0, 3));
      if (three != null && three >= 644 && three <= 649) return CardBrand.discover;
    }

    // JCB: 3528–3589
    if (d.length >= 4) {
      final four = int.tryParse(d.substring(0, 4));
      if (four != null && four >= 3528 && four <= 3589) return CardBrand.jcb;
    }

    // Diners Club: 300–305, 36, 38
    if (d.length >= 3) {
      final three = int.tryParse(d.substring(0, 3));
      if (three != null && three >= 300 && three <= 305) return CardBrand.dinersClub;
    }
    if (d.length >= 2 && (d.startsWith('36') || d.startsWith('38'))) {
      return CardBrand.dinersClub;
    }

    // UnionPay: 62
    if (d.startsWith('62')) return CardBrand.unionPay;

    return CardBrand.other;
  }

  // ── Luhn algorithm ─────────────────────────────────────────────────────────

  /// Returns `true` if [digits] passes the Luhn (mod-10) check.
  ///
  /// [digits] must contain only ASCII digit characters ('0'–'9').
  static bool validateLuhn(String digits) {
    if (digits.isEmpty) return false;
    var sum = 0;
    var alternate = false;
    for (var i = digits.length - 1; i >= 0; i--) {
      var d = int.parse(digits[i]);
      if (alternate) {
        d *= 2;
        if (d > 9) d -= 9;
      }
      sum += d;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  // ── Card number validation ─────────────────────────────────────────────────

  /// Validates [input] (spaces allowed) as a complete card number.
  ///
  /// Checks:
  /// 1. Non-empty
  /// 2. Length matches the detected brand (15 for Amex, 14 for Diners, 16 otherwise)
  /// 3. Luhn algorithm
  static CardNumberResult validateCardNumber(String input) {
    final digits = _digitsOnly(input);

    if (digits.isEmpty) {
      return const CardNumberResult(
        isValid: false,
        brand: CardBrand.other,
        error: 'Card number is required.',
      );
    }

    final brand = detectBrand(digits);
    final expected = _expectedLength(brand);

    if (digits.length != expected) {
      return CardNumberResult(
        isValid: false,
        brand: brand,
        error: 'Enter the full $expected-digit card number.',
      );
    }

    if (!validateLuhn(digits)) {
      return CardNumberResult(
        isValid: false,
        brand: brand,
        error: 'Card number is invalid. Please check and try again.',
      );
    }

    return CardNumberResult(
      isValid: true,
      brand: brand,
      last4: digits.substring(digits.length - 4),
    );
  }

  // ── Expiry validation ──────────────────────────────────────────────────────

  /// Validates a card expiry. Accepts both 2-digit and 4-digit [year].
  ///
  /// - [month]: numeric string "1"–"12" or "01"–"12"
  /// - [year]: "YY" (normalized to 20YY) or "YYYY"
  ///
  /// Returns an error if the month is out of range or the card has expired
  /// (expiry month/year is strictly before the current month).
  static ExpiryResult validateExpiry(String month, String year) {
    final m = int.tryParse(month.trim());
    if (m == null || m < 1 || m > 12) {
      return const ExpiryResult(isValid: false, error: 'Enter a valid month (01–12).');
    }

    var y = int.tryParse(year.trim());
    if (y == null) {
      return const ExpiryResult(isValid: false, error: 'Enter a valid year.');
    }
    // Normalize 2-digit year to 4-digit (00–99 → 2000–2099)
    if (y >= 0 && y < 100) y += 2000;

    final now = DateTime.now();

    if (y < now.year || (y == now.year && m < now.month)) {
      return const ExpiryResult(isValid: false, error: 'This card has expired.');
    }
    if (y > now.year + 20) {
      return const ExpiryResult(isValid: false, error: 'Enter a valid year.');
    }

    return const ExpiryResult(isValid: true);
  }

  // ── CVV validation ─────────────────────────────────────────────────────────

  /// Returns `true` if [cvv] has the correct digit count for [brand].
  ///
  /// Amex requires 4 digits; all other networks require 3.
  static bool validateCvv(String cvv, CardBrand brand) =>
      _digitsOnly(cvv).length == cvvLength(brand);

  /// Expected CVV length: 4 for [CardBrand.amex], 3 for all others.
  static int cvvLength(CardBrand brand) => brand == CardBrand.amex ? 4 : 3;

  // ── Utilities ──────────────────────────────────────────────────────────────

  /// Extracts the last four digits from [cardNumber], or `null` if fewer than
  /// four digits are present.
  static String? extractLast4(String cardNumber) {
    final digits = _digitsOnly(cardNumber);
    return digits.length >= 4 ? digits.substring(digits.length - 4) : null;
  }

  /// Human-readable display name for [brand].
  static String brandName(CardBrand brand) => switch (brand) {
        CardBrand.visa => 'Visa',
        CardBrand.mastercard => 'Mastercard',
        CardBrand.amex => 'Amex',
        CardBrand.discover => 'Discover',
        CardBrand.jcb => 'JCB',
        CardBrand.dinersClub => 'Diners Club',
        CardBrand.unionPay => 'UnionPay',
        CardBrand.other => 'Card',
      };

  // ── Private helpers ────────────────────────────────────────────────────────

  static int _expectedLength(CardBrand brand) => switch (brand) {
        CardBrand.amex => 15,
        CardBrand.dinersClub => 14,
        _ => 16,
      };

  static String _digitsOnly(String s) => s.replaceAll(RegExp(r'\D'), '');
}
