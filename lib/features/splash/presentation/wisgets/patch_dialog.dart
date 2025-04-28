import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class PatchDialog extends StatefulWidget {
  final ShorebirdUpdater shorebirdUpdater;
  const PatchDialog({super.key, required this.shorebirdUpdater});

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
    await widget.shorebirdUpdater.update();
    setState(() {
      isDownloading = false;
    });
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
            Text(
              isDownloading ? "กําลังอัพเดต" : "อัพเดตเสร็จสิ้น",
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
