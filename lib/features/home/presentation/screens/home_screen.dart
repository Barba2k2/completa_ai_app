import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/app_dependencies.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../routing/app_routes.dart';
import '../../../../shared/services/firebase_service.dart';
import '../../controllers/home_controller.dart';
import '../widgets/progress_card.dart';
import '../widgets/sections_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = getIt<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: user?.photoURL != null
                ? CircleAvatar(
                    radius: 14.r,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  )
                : const Icon(
                    Icons.person_outline_rounded,
                  ),
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return RefreshIndicator(
            onRefresh: _controller.loadData,
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                ProgressCard(
                  collected: _controller.collection.totalOwned,
                  total: AppConstants.totalStickers,
                  repeated: _controller.collection.totalRepeated,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Seções',
                  style: AppTextStyles.h4,
                ),
                SizedBox(height: 12.h),
                SectionsList(controller: _controller),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.scanner),
        icon: const Icon(Icons.qr_code_scanner_rounded),
        label: const Text('Scanner'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
