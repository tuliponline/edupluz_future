import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToSignIn();
  }

  Future<void> _navigateToSignIn() async {
    if (await RemoteConfigService().isMaintenance()) {
      context.go('/maintenance');
    } else {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go('/signin');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo or splash screen content here
            const FlutterLogo(size: 100),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
