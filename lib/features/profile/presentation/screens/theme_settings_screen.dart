import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/enums/app_theme_mode.dart';
import '../../providers/theme_provider.dart';
import '../widgets/theme_option_tile.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          ThemeOptionTile(
            title: 'Automático',
            subtitle: 'Segue as configurações do sistema',
            value: AppThemeMode.system,
            currentTheme: currentTheme,
            onSelected: (value) =>
                ref.read(themeProvider.notifier).setTheme(value),
          ),
          ThemeOptionTile(
            title: 'Claro',
            subtitle: 'Sempre usar tema claro',
            value: AppThemeMode.light,
            currentTheme: currentTheme,
            onSelected: (value) =>
                ref.read(themeProvider.notifier).setTheme(value),
          ),
          ThemeOptionTile(
            title: 'Escuro',
            subtitle: 'Sempre usar tema escuro',
            value: AppThemeMode.dark,
            currentTheme: currentTheme,
            onSelected: (value) =>
                ref.read(themeProvider.notifier).setTheme(value),
          ),
        ],
      ),
    );
  }
}
