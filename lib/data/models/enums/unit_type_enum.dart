enum UnitType {
  bedsitter('Bedsitter'),
  singleRoom('Single room'),
  double('Double'),
  airBnB('Air BnB'),
  oneBedroom('1 Bedroom'),
  twoBedroom('2 Bedroom'),
  threeBedroom('3 Bedroom'),
  fourBedroom('4 Bedroom'),
  mansionette('Mansionette'),
  mansion('Mansion'),
  townHouse('Townhouse'),
  agent('Agent'),
  caretaker('Caretaker'),
  otherEmployee('Other');

  final String label;

  const UnitType(this.label);
}
