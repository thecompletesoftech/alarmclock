import 'dart:developer';

import 'package:clockalarm/Config/Import.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final signUpemail = TextEditingController();
  final signuppassword = TextEditingController();
  final signupconfirmpass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      print(email);
      print(password);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      log("user ==>>>" + user.toString());
    } on FirebaseAuthException catch (e) {
      print('object' + e.toString());
      if (e.code == "user-not-found") {
        print('No user  found  for that email');
      }
    }
    return user;
  }

  signUp() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: signUpemail.text,
        password: signupconfirmpass.text,
      );
      // User signed up successfully
      // You can navigate to the next screen or perform other actions here
    } catch (e) {
      // Handle sign-up errors
      print("Error during sign up: $e");
    }
  }
}
