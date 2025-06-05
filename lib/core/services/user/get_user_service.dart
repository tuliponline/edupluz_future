import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/user/get_user_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<GetUser200Response> getUserService(
  WidgetRef ref,
  BuildContext context,
) async {
  var response = await PrivateApiService().get(
    path: ApiPath.userMe,
    ref: ref,
    context: context,
  );

  GetUser200Response user = getUser200ResponseFromJson(response);
  ref.read(userProvider.notifier).state = user;
  return user;
}
