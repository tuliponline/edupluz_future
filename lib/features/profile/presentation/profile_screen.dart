import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/models/user/get_user_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/features/profile/domain/orders_model.dart';
import 'package:edupluz_future/features/profile/presentation/setting_page.dart';
import 'package:edupluz_future/features/profile/presentation/widget/card_profile_mission.dart';
import 'package:edupluz_future/features/profile/presentation/widget/profile_avatar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  CoursesModel? coursesFavorites;
  OrdersModel? ordersData;

  _initData() async {
    // coursesFavorites =
    //     await fetchCoursesFavorites(page: 1, limit: 300, ref: ref);
    // ordersData = await fetchOrders(page: 1, limit: 300, sort: SortTypr.desc);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetUser200Response? meData = ref.watch(userProvider);
    return SafeArea(
      child: Column(
        children: [
          AppBarWidget(
            title: "โปรไฟล์",
            suffix: IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()));
              },
              icon: const Icon(
                LucideIcons.settings,
                color: AppColors.iconPrimary,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          if (meData != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileAvatar(
                      imageUrl: meData.data.picture == ""
                          ? null
                          : meData.data.picture,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text("${meData.data.firstName} ${meData.data.lastName}",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                    Text(meData.data.email,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium),
                    const SizedBox(
                      height: 24,
                    ),
                    // (ordersData == null || ordersData!.data.items.isEmpty)
                    //     ? Skeletonizer(
                    //         child: CardProfilePlan(
                    //             title: "ไม่มีแพ็คเกจ",
                    //             subtitle: "2022-01-01"))
                    //     : (isafterNow(ordersData!
                    //             .data.items.first.createdAt
                    //             .toString()))
                    //         ? CardProfilePlan(
                    //             title: "ไม่มีแพ็คเกจ", subtitle: "")
                    //         : CardProfilePlan(
                    //             title: ordersData!
                    //                 .data.items.first.items.first.name,
                    //             subtitle: dateFormat(ordersData!
                    //                 .data.items.first.createdAt
                    //                 .toString()),
                    //           ),
                    // const SizedBox(
                    //   height: 72,
                    // ),
                    const Stack(
                      children: [
                        Column(
                          children: [
                            CardProfileMission(),
                            SizedBox(
                              height: 8,
                            ),
                            CardProfileMission(),
                            SizedBox(
                              height: 8,
                            ),
                            CardProfileMission(),
                          ],
                        ),
                        Positioned.fill(
                          child: BlurryContainer.expand(
                            child: Center(
                              child: Text(
                                'Coming Soon',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          else
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
