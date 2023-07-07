import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/theme_provider.dart';
import '/providers_helpers/sign_in_provider.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "change theme",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(themeProvider.isDark! ? Icons.light_mode : Icons.dark_mode),
              Text(themeProvider.isDark! ? "Light Theme" : "Dark Theme"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "log out",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.exit_to_app),
              Text("Log Out"),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        if (value == "view profile") {
        } else if (value == "log out") {
          await Provider.of<SignInProvider>(context, listen: false).signOut();
        } else if (value == "change theme") {
          if (themeProvider.isDark!) {
            themeProvider.setLightTheme();
          } else {
            themeProvider.setDarkTheme();
          }
        }
      },
    );
  }
}
