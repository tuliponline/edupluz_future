enum Routes {
  splash,
  maintenance,
  signin,
  signup,
  forgotpassword,
  onboarding;

  String get name {
    return toString().split('.').last;
  }
}
