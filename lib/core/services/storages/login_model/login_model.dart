import 'package:hive/hive.dart';

part 'login_model.g.dart';

@HiveType(typeId: 0)
class Login extends HiveObject {
  @HiveField(0)
  late String accessToken;
  @HiveField(1)
  late String refreshToken;
  @HiveField(2)
  late int expiresAt;
  // Add other user properties as needed

  Login(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresAt});
}
