// import 'dart:developer';

// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:logger/logger.dart';

Future<String> fetchAccessToken() async {
  // try {
  //   final result = await Amplify.Auth.fetchAuthSession();
  //   Logger().d('$result');
  //   final cognitoAuthSession = result as CognitoAuthSession;
  //   final accessToken =
  //       cognitoAuthSession.userPoolTokensResult.value.accessToken.raw;
  //   log('Start: $accessToken : End');
  //   return accessToken;
  // } on AuthException catch (e) {
  //   Logger().e(e.message);
  //   throw Exception(e.message);
  // }
  return "testtoken";
}
