import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/phase1/system_awakening_screen.dart';
import 'screens/phase1/mission1_screen.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';
import 'services/local_storage_service.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local storage
  await LocalStorageService().init();
  
  runApp(const CodeQuestApp());
}

class CodeQuestApp extends StatelessWidget {
  const CodeQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.neonBlue,
        scaffoldBackgroundColor: AppTheme.darkBackground,
        textTheme: GoogleFonts.robotoMonoTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.dark(
          primary: AppTheme.neonBlue,
          secondary: AppTheme.neonPurple,
          surface: AppTheme.deepSpace,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      // Named routes for navigation
      routes: {
        '/story/python/phase1/opening': (context) => const SystemAwakeningScreen(),
        '/story/python/mission': (context) => const Mission1Screen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
