import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:edupluz_future/core/models/user/get_user_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/services/user/get_user_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/features/profile/data/update_profile.dart';
import 'package:edupluz_future/features/profile/presentation/widget/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  File? imageFile;
  String? base64Image;
  String? imageUrl;

  bool isBack = false;

  _initUserDate() async {
    EasyLoading.show();
    await getUserService(ref);
    name.text = ref.read(userProvider)?.data.firstName ?? "";
    lastName.text = ref.read(userProvider)?.data.lastName ?? "";
    imageUrl = ref.read(userProvider)?.data.avatar == ""
        ? null
        : ref.read(userProvider)?.data.avatar;

    setState(() {});
    EasyLoading.dismiss();
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      EasyLoading.show();
      imageFile = File(pickedFile.path);
      base64Image = base64Encode(imageFile!.readAsBytesSync());

      Logger().d(base64Image);
      log("Start: $base64Image : End'");
      EasyLoading.dismiss();
      setState(() {});
    }
  }

  @override
  void initState() {
    _initUserDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetUser200Response? meData = ref.watch(userProvider);

    Logger().d("imageUrl: $imageUrl");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
                prefix: InkWell(
                    onTap: () {
                      isBack = true;
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      LucideIcons.arrow_left,
                      color: AppColors.textPrimary,
                    )),
                title: "ตั้งค่าโปรไฟล์"),
            if (meData != null)
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            kToolbarHeight -
                            48, // Account for padding
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ProfileAvatar(
                                  imageFile: imageFile,
                                  imageUrl: meData.data.avatar == ""
                                      ? null
                                      : meData.data.avatar,
                                  editEnable: true,
                                  onTap: () => _getFromGallery(),
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ชื่อ",
                                        style: AppTextStyles.bodyMedium),
                                    const SizedBox(height: 8),
                                    AppTextField(
                                      controller: name,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("นามสกุล",
                                        style: AppTextStyles.bodyMedium),
                                    const SizedBox(height: 8),
                                    AppTextField(controller: lastName),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                            SizedBox(
                              height: 56,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  EasyLoading.show();
                                  bool result = await updateProfile(
                                      picture: base64Image ?? "",
                                      name: name.text,
                                      lastName: lastName.text,
                                      ref: ref);
                                  EasyLoading.dismiss();
                                  if (result) {
                                    // fetchUserMe(ref);

                                    Logger().d(
                                        "Update Profile: ${meData.data.firstName} ${meData.data.lastName} ${meData.data.firstName}");

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            margin: const EdgeInsets.only(
                                                bottom: 24,
                                                left: 24,
                                                right: 24),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                AppColors.cardBackground,
                                            content: Text(
                                              'บันทึกข้อมูลสําเร็จ',
                                              style: AppTextStyles.bodyMedium,
                                            ),
                                          ),
                                        )
                                        .closed
                                        .then((value) async {
                                      if (!isBack) {
                                        Navigator.pop(context);
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        margin: const EdgeInsets.only(
                                            bottom: 24, left: 24, right: 24),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            AppColors.cardBackground,
                                        content: Text('บันทึกข้อมูลไม่สําเร็จ',
                                            style: AppTextStyles.bodyMedium),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "บันทึก",
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Column _textField(
      {required String fieldName, required TextEditingController contoller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 8),
        TextFormField(
          controller: contoller,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: fieldName,
            hintStyle: AppTextStyles.bodyMedium,
            errorStyle: const TextStyle(height: 0),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'โปรดกรอก$fieldName';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class EdupluzVaccount {}
