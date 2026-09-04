String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter password';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }

  return null;
}
