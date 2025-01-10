enum Routes {
  splash,
  maintenance,
  signin,
  signup,
  forgotpassword;

  String get name {
    return toString().split('.').last;
  }
}
