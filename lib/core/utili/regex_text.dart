textLengthRegex(String string, int length) {
  if (string.length >= length) {
    return true;
  } else {
    return false;
  }
}

onlyNumberRegex(String number) {
  if (number.isEmpty) {
    return false;
  } else {
    String pattern = r'^[1-9][0-9]*$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(number);
  }
}

phoneRegex(String phone) {
  String pattern = r'^[0][0-9]\d{8}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(phone);
}

bool emailRegex(String email) {
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

bool strongPassword(String password) {
  String pattern =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*]).{8,}$";
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(password);
}
