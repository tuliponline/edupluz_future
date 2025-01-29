import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';
import 'package:edupluz_future/core/services/shorebird/shorebird_service.dart';
import 'package:edupluz_future/core/services/storages/storage_services.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/features/splash/presentation/wisgets/patch_dialog.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
    _initApp();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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

      await Future.delayed(const Duration(seconds: 5));
      if (mounted) {
        bool isOpenAppFirstTime = await StorageServices.isOpenFirstTime();
        if (isOpenAppFirstTime) {
          context.goNamed(Routes.onboarding.name);
        } else {
          context.goNamed(Routes.signin.name);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gif(
              image: AssetImage(
                'assets/splash/splash.gif',
              ),
              controller: controller,
              autostart: Autostart.no,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              onFetchCompleted: () {
                controller.reset();
                controller.forward();
                Logger().d('GIF animation finished');
              },
            ),
          ],
        ),
      ),
    );
  }
}
