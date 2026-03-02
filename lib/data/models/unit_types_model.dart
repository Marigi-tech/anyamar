enum UnitType {
  studio('Studio'),
  oneBedroom('1 Bedroom'),
  twoBedroom('2 Bedroom'),
  threeBedroom('3 Bedroom'),
  fourBedroom('4 Bedroom'),
  fiveBedroom('5 Bedroom'),
  maisonette('Maisonette'),
  mansion('Mansion'),
  airbnb('Airbnb');

  final String label;
  const UnitType(this.label);
}
