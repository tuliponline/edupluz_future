import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/app/version_service.dart';
import 'package:edupluz_future/core/services/auth/authsService_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/dialogs/confirm_dialog.dart';
import 'package:edupluz_future/features/profile/data/fetch_contacts.dart';
import 'package:edupluz_future/features/profile/data/fetch_image_contacts.dart';
import 'package:edupluz_future/features/profile/domain/contacts_model.dart';
import 'package:edupluz_future/features/profile/presentation/language_page.dart';
import 'package:edupluz_future/features/profile/presentation/orders_page.dart';
import 'package:edupluz_future/features/profile/presentation/profile_edit_page.dart';
import 'package:edupluz_future/features/profile/presentation/widget/seting_menu.dart';
import 'package:edupluz_future/routes/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  VersionStatus? versionStatus;

  _compareVersion() async {
    versionStatus = await VersionService().compareVersions(ref: ref);
    setState(() {});
  }

  @override
  void initState() {
    _compareVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 47),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                      height: double.infinity,
                      "assets/images/setting/bg1.png",
                      fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                      height: double.infinity,
                      "assets/images/setting/bg2.png",
                      fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.x,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('การตั้งค่า', style: AppTextStyles.h4),
                  ],
                ),
                const SizedBox(height: 66),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (versionStatus != null &&
                            versionStatus != VersionStatus.higher)
                          SettingMenu(
                            icon: LucideIcons.user_cog,
                            title: 'ตั้งค่าโปรไฟล์',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileEditPage()));
                            },
                          ),
                        // const SizedBox(height: 12),
                        // SettingMenu(
                        //   icon: LucideIcons.globe,
                        //   title: 'เปลี่ยนภาษา',
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const LanguagePage()));
                        //   },
                        // ),
                        if (versionStatus != null &&
                            versionStatus != VersionStatus.higher)
                          const SizedBox(height: 12),
                        if (versionStatus != null &&
                            versionStatus != VersionStatus.higher)
                          SettingMenu(
                            icon: LucideIcons.shopping_bag,
                            title: 'ประวัติการสั่งซื้อ',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrdersPage()));
                            },
                          ),
                        if (versionStatus != null &&
                            versionStatus != VersionStatus.higher)
                          const SizedBox(height: 12),
                        SettingMenu(
                          icon: LucideIcons.headphones,
                          title: 'ติดต่อเรา',
                          onTap: () async {
                            EasyLoading.show();
                            ContactsModel contactsModel = await fetchContacts();
                            EasyLoading.dismiss();
                            if (mounted) {
                              contactsMenu(context, contactsModel);
                            }
                          },
                        ),
                      ],
                    ),
                    ((versionStatus != null &&
                            versionStatus != VersionStatus.higher))
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  bool isConfirm = await confirmDialog(
                                    context,
                                    title: "ออกจากระบบ",
                                    conFirmText: "ตกลง",
                                    conFirmColor: AppColors.error,
                                    cacelText: "ยกเลิก",
                                    warning: false,
                                    content: "คุณต้องการออกจากระบบ",
                                  );
                                  // confirm dialog
                                  if (isConfirm && isConfirm) {
                                    EasyLoading.show();
                                    await AuthsService().logout(ref);
                                    EasyLoading.dismiss();
                                    context.pushReplacementNamed(
                                        Routes.signin.name);
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      LucideIcons.log_out,
                                      color: AppColors.textPrimary,
                                    ),
                                    const SizedBox(width: 12),
                                    Text('Logout',
                                        style: AppTextStyles.bodyLarge),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row()
                  ],
                ))
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future<dynamic> contactsMenu(
      BuildContext context, ContactsModel contacts) async {
    return showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: AppColors.background,
        height: 388,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 36,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.40,
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: AppColors.iconSecondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: contacts.data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await _launchUrl(contacts.data[index].url);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.textDisabled,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: fetchImageContacts(contacts.data[index].icon),
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data ?? "",
                                  width: 30,
                                  height: 30,
                                  placeholder: (context, url) => Skeletonizer(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  contacts.data[index].name,
                                  style: AppTextStyles.bodyMedium
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            );
                          },
                        ),
                        const Icon(LucideIcons.chevron_right,
                            color: AppColors.textPrimary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
