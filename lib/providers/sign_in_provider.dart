import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider with ChangeNotifier {
  bool isLoading = false;

  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();
    final user = await GoogleSignIn().signIn();
    if (user == null) {
      isLoading = false;
      notifyListeners();
      return;
    }
    final googleAuthInfo = await user.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthInfo.accessToken,
        idToken: googleAuthInfo.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    isLoading = true;
    notifyListeners();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    isLoading = false;
    notifyListeners();
  }
}
