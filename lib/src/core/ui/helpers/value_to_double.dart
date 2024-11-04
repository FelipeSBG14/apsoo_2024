double parseCurrencyToDouble(String formattedValue) {
  String pureValue = formattedValue.replaceAll(RegExp(r'[R$\s]'), '');

  // Troca a vírgula por ponto para conversão correta
  pureValue = pureValue.replaceAll(',', '.');

  // Converte para double
  return double.tryParse(pureValue) ?? 0.0;
}
