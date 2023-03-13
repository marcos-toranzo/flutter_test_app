class Currency {
  final double amount;
  final String code;

  const Currency({required this.amount, required this.code});

  const Currency.none()
      : amount = 0,
        code = '';
}
