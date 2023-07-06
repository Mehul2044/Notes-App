import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/providers/theme_provider.dart';
import '/providers/sign_in_provider.dart';

import '/config/firebase_options.dart';

import '/utils/app_theme.dart';

import '/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final isDarkTheme = await ThemeProvider.getTheme();
  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatelessWidget {
  final bool isDarkTheme;

  const MyApp({super.key, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, provider, child) {
            final materialApp = MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: (provider.isDark ?? isDarkTheme)
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,
              home: child,
            );
            if (provider.isDark == null) {
              provider.setTheme(isDarkTheme);
            }
            return materialApp;
          },
          child: const Home()),
    );
  }
}
