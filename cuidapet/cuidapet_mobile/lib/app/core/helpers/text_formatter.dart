import 'package:intl/intl.dart';

class TextFormatter {
  static final _formatRealPattern = NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');
  
  TextFormatter._();

  static String formatReal(double value) => _formatRealPattern.format(value);
}
