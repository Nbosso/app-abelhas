class DateTimeHelper {
  static DateTime? parseDate(String input) {
    final parts = input.split('/');
    if (parts.length != 3) throw FormatException('Formato inválido');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}
