import 'package:vector_graphics/vector_graphics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/sign_in_provider.dart';

import '/utils/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<SignInProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture(AssetBytesLoader(Constants.appLogo), height: 100),
                  Text("Notes",
                      style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
              SizedBox(height: height * 0.3),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  onPressed: () => provider.signIn(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture(AssetBytesLoader(Constants.googleLogo)),
                      const SizedBox(width: 15),
                      const Text("Sign in with Google")
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
