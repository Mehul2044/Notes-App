import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/note_provider.dart';
import '/providers_helpers/theme_provider.dart';
import '/providers_helpers/sign_in_provider.dart';

import '/config/firebase_options.dart';
import 'config/home.dart';

import '/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
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
        ChangeNotifierProvider(create: (_) => NoteProvider()),
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
