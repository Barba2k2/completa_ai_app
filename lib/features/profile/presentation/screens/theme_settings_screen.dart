import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../controllers/theme_controller.dart';
import '../../domain/enums/app_theme_mode.dart';
import '../widgets/theme_option_tile.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = getIt<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema'),
      ),
      body: ListenableBuilder(
        listenable: themeController,
        builder: (context, _) {
          final currentTheme = themeController.themeMode;

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              ThemeOptionTile(
                title: 'Automático',
                subtitle: 'Segue as configurações do sistema',
                value: AppThemeMode.system,
                currentTheme: currentTheme,
                onSelected: themeController.setTheme,
              ),
              ThemeOptionTile(
                title: 'Claro',
                subtitle: 'Sempre usar tema claro',
                value: AppThemeMode.light,
                currentTheme: currentTheme,
                onSelected: themeController.setTheme,
              ),
              ThemeOptionTile(
                title: 'Escuro',
                subtitle: 'Sempre usar tema escuro',
                value: AppThemeMode.dark,
                currentTheme: currentTheme,
                onSelected: themeController.setTheme,
              ),
            ],
          );
        },
      ),
    );
  }
}
