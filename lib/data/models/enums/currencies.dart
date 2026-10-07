enum Currencies {
  ksh('Ksh'),
  usd('Usd'),
  euro('Euro'),
  pound('Pound');

  final String label;

  const Currencies(this.label);
}

getCurrencyFromString(String? currency) {
  Currencies? curr;
  if (currency == 'Ksh') {
    curr = Currencies.ksh;
  }
  if (currency == 'Usd') {
    curr = Currencies.usd;
  }
  if (currency == 'Euro') {
    curr = Currencies.euro;
  }
  if (currency == 'Pound') {
    curr = Currencies.pound;
  }

  return curr;
}
