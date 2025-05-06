import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String? _version;

  Future<void> _getVersion() async {
    _version = await RemoteConfigService().romoteVersion();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 24),
            Text(
              'กำลังดำเนินการปรับปรุงระบบ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'กำลังดำเนินการปรับปรุงระบบ\nกรุณาตรวจสอบอีกครั้ง',
              textAlign: TextAlign.center,
            ),
            if (_version != null)
              Text(
                'Version $_version',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}
