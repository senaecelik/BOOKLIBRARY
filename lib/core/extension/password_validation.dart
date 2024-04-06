extension PasswordValidationExtension on String {
  bool get isValidPassword {
    // * should contain at least one upper case
    // * should contain at least one lower case
    // * should contain at least one digit
    // * should contain at least one speacial character
    // * Must be at least 8 characters in length
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{};:"\\|,.<>/?]).{6,}$');
    return passwordRegExp.hasMatch(this);
  }
}
