import 'dart:developer';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final signUpemail = TextEditingController();
  final signuppassword = TextEditingController();
  final signupconfirmpass = TextEditingController();
  var loginloader = false.obs;
  var signuploader = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  loginUsingEmailPassword({required BuildContext context}) async {
    User? user;
    loginloader.value = true;
    return ApiHelper().Api().then((value) async {
      if (value) {
        try {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: (emailController.text.replaceAll(RegExp(r"\s+"), "")),
              password: passwordController.text);
          return userCredential.user;
          // loginloader.value = false;
        } catch (e) {
          if (e is FirebaseAuthException) {
            print('Login Catch===> ' + e.code.toString());
            print('FirebaseAuthException - ${e.code}: ${e.message}');

            switch (e.code) {
              case 'invalid-email':
                Mysnack(retry, invalidemail, context);
                break;
              case 'user-disabled':
                Mysnack(retry, deactive, context);
                break;
              case 'invalid-credential':
                Mysnack(retry, invalidcredential, context);
                break;
              case 'wrong-password':
                Mysnack(retry, wrongpassword, context);
                break;
              case 'too-many-requests':
                Mysnack(retry, tomanytry, context);
                break;
              default:
                Mysnack(retry, somethingwrong, context);
            }
            loginloader.value = false;
          }
        }
      }
    });
    // loginloader.value = false;

    // return user;
  }

  signUp(cntx) async {
    User? user;
    signuploader.value = true;
    ApiHelper().Api().then((value) async {
      if (value) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: signUpemail.text.replaceAll(RegExp(r"\s+"), ""),
            password: signupconfirmpass.text.replaceAll(RegExp(r"\s+"), ""),
          );
          user = userCredential.user;
          log("userDetails ==>>>" + user.toString());
        } catch (e) {
          print('Error during user registration: $e');
          if (e is FirebaseAuthException) {
            print('FirebaseAuthException - ${e.code}: ${e.message}');
            switch (e.code) {
              case 'email-already-in-use':
                Mysnack(retry, emailalreadyinuse, cntx);
                break;
              case 'invalid-email':
                Mysnack(retry, invalidemail, cntx);
                break;
              default:
                Mysnack(retry, somethingwrong, cntx);
            }
          }
          print("Error during sign up: $e");
        }
      }
    });
    signuploader.value = false;
  }

  Adduser() {}
}
