enum UserType {
  landlord('Property owner'),
  agent('Agency'),
  caretaker('Care taker'),
  otherUser('Other');

  final String label;

  const UserType(this.label);
}
