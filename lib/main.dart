import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anak_kita_app/theme.dart';
import 'package:anak_kita_app/providers/app_state.dart';
import 'package:anak_kita_app/screens/login_screen.dart';
import 'package:anak_kita_app/screens/dashboard_screen.dart';
import 'package:anak_kita_app/screens/app_limits_screen.dart';
import 'package:anak_kita_app/screens/time_out_screen.dart';
import 'package:anak_kita_app/screens/activity_log_screen.dart';
import 'package:anak_kita_app/screens/settings_screen.dart';
import 'package:anak_kita_app/screens/rewards_screen.dart';
import 'package:anak_kita_app/screens/study_config_screen.dart';
import 'package:anak_kita_app/screens/study_mode_active_screen.dart';
import 'package:anak_kita_app/screens/claim_reward_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..init(),
      child: MaterialApp(
        title: 'Anak Kita',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/limits': (context) => const AppLimitsScreen(),
          '/time-out': (context) => const TimeOutScreen(),
          '/activity': (context) => const ActivityLogScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/rewards': (context) => const RewardsScreen(),
          '/study-config': (context) => const StudyConfigScreen(),
          '/study-mode-active': (context) => const StudyModeActiveScreen(),
          '/claim-reward': (context) => const ClaimRewardScreen(),
        },
      ),
    );
  }
}
