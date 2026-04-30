String formatPrice(double price) {
  return price.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
}
