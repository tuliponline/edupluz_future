import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class PatchDialog extends StatefulWidget {
  final ShorebirdUpdater? shorebirdUpdater;
  const PatchDialog({super.key, this.shorebirdUpdater});

  @override
  State<PatchDialog> createState() => _MaintenancePlanDialogState();
}

class _MaintenancePlanDialogState extends State<PatchDialog> {
  bool isDownloading = true;
  @override
  void initState() {
    super.initState();
  }

  _update() async {
    try {
      widget.shorebirdUpdater?.update();
    } catch (e) {
      Logger().e(e);
    }
    await Future.delayed(const Duration(seconds: 5));
    isDownloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _update();
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "อัพเดทแพ็คเกจ",
            ),
            const SizedBox(height: 13.0),
            Column(
              children: [
                Text(
                  isDownloading ? "กําลังอัพเดท" : "อัพเดทเสร็จสิ้น",
                ),
                if (isDownloading)
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
              ],
            ),
            const SizedBox(height: 23.0),
            if (!isDownloading)
              SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton(
                  child: const Text(
                    "เริ่มทำงานใหม่",
                  ),
                  onPressed: () async {
                    if (!isDownloading) {
                      Restart.restartApp();
                      Logger().d("restart");
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
