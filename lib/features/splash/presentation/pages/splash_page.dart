import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';
import 'package:edupluz_future/core/services/shorebird/shorebird_service.dart';
import 'package:edupluz_future/features/splash/presentation/wisgets/patch_dialog.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    if (await RemoteConfigService().isMaintenance()) {
      context.goNamed(Routes.maintenance.name);
    } else {
      ShorebirdUpdater? shorebirdUpdater =
          await ShorebirdService().checkForUpdates();
      if (shorebirdUpdater != null) {
        bool showPatchDialog = await RemoteConfigService().isShowPatchDialog();
        if (showPatchDialog) {
          await showDialog(
            context: context,
            builder: (context) =>
                PatchDialog(shorebirdUpdater: shorebirdUpdater),
          );
          Restart.restartApp();
        } else {
          shorebirdUpdater.update();
        }
      }
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.goNamed(Routes.signin.name);
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
