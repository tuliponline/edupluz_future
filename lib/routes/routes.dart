enum Routes {
  splash,
  maintenance,
  signin,
  signup,
  forgotpassword,
  onboarding,
  question;

  String get name {
    return toString().split('.').last;
  }

  String get path {
    return '/$name';
  }
}
