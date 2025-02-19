import 'package:edupluz_future/features/classroom/provider/ip_address_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_ip_address/get_ip_address.dart';

getIpAddress(WidgetRef ref) async {
  String? ipAddress;
  if (ref.watch(ipAddressProvider.notifier).state != null) {
    ipAddress = ref.read(ipAddressProvider);
  } else {
    var getIpAddress = IpAddress(type: RequestType.json);
    await getIpAddress
        .getIpAddress()
        .then((value) => ipAddress = value.toString());
    ref.read(ipAddressProvider.notifier).state = ipAddress;
  }
  return ipAddress;
}
