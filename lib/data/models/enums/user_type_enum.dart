enum UserType {
  landlord('Property owner'),
  tenant('Tenant'),
  agent('Agent'),
  caretaker('Caretaker'),
  otherEmployee('Other');

  final String label;

  const UserType(this.label);
}
