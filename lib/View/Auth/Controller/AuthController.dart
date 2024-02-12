import 'dart:convert';
import 'dart:developer';
import 'package:clockalarm/Config/Api.dart';
import 'package:clockalarm/Config/Import.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final signUpemail = TextEditingController();
  final signuppassword = TextEditingController();
  final signupconfirmpass = TextEditingController();
  final oldpass = TextEditingController();
  final currentpass = TextEditingController();
  final confirmpass = TextEditingController();
  final resetpassemail = TextEditingController();
  var loginloader = false.obs;
  var signuploader = false.obs;
  var passwordloading = false.obs;
  var forgotpassloader = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  var box = GetStorage();

  Future<User?> loginUsingEmailPassword({required BuildContext context}) async {
    User? user;
    loginloader.value = true;
    return ApiHelper().Api().then((value) async {
      if (value) {
        try {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: (emailController.text.replaceAll(RegExp(r"\s+"), "")),
              password: passwordController.text);
          user = userCredential.user;
          if (user != null) {
            box.write('uid', user!.uid);
            box.write('email', user!.email);
            clearsignindata();
            log("userDetails ==>>>" + user.toString());
            loginloader.value = false;
          }
          return userCredential.user;
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
          }
          loginloader.value = false;
        }
      }
    });
  }

  signUp(cntx) async {
    signuploader.value = true;
    User? user;
    ApiHelper().Api().then((value) async {
      if (value) {
        try {
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
            email: signUpemail.text.replaceAll(RegExp(r"\s+"), ""),
            password: signupconfirmpass.text.replaceAll(RegExp(r"\s+"), ""),
          );
          user = userCredential.user;
          if (user != null) {
            Adduser(user, cntx);
            box.write(
                'email', (signUpemail.text.replaceAll(RegExp(r"\s+"), "")));
            clearsignupdata();
          }
          log("userDetails ==>>>" + user.toString());
          signuploader.value = false;
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
          signuploader.value = false;
          print("Error during sign up: $e");
        }
      }
    });
  }

  Adduser(user, cntx) {
    var userdata = {
      'id': "",
      'uid': user.uid,
      'name': nameController.text,
      'email': signUpemail.text,
      'image': '',
      'fcm': box.read('fcmtoken'),
    };
    log("UserDetail" + userdata.toString());
    try {
      FirebaseFirestore.instance
          .collection("users")
          .add(userdata)
          .then((value) {
        log("values" + value.id.toString());

        FirebaseFirestore.instance
            .collection("users")
            .doc(value.id)
            .update({"id": value.id.toString()});

        box.write('uid', user.uid);

        clearsignupdata();
        nextscreenwithoutback(cntx, NewBottomNavigator());
        signuploader.value = false;
      });
    } on Exception catch (e) {
      signuploader.value = false;
      log("add user Error ==>" + e.toString());
      Mysnack(retry, e, cntx);
    }
  }

  getuserdata(user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: user.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length < 1) {
        log('Userdatatata==>');
      }
    });
  }

  Changepassword(cntx) async {
    try {
      passwordloading.value = true;
      log("email" + box.read('email').toString());
      await auth.signInWithEmailAndPassword(
        email: box.read('email'),
        password: oldpass.text,
      );
      auth.currentUser!.updatePassword(confirmpass.text).then((_) {
        clearChangepassdata();
        Mysnack(successfull, passwordchanged, cntx);
        passwordloading.value = false;
        Navigator.pop(cntx);
      }).catchError((error) {
        passwordloading.value = false;
        Mysnack(retry, passwordnotchange, cntx);
        print(passwordnotchange + error.toString());
      });
    } on FirebaseAuthException catch (e) {
      passwordloading.value = false;
      log("Exception Code" + e.code.toString());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Mysnack(retry, somethingwrong, cntx);
      } else if (e.code == 'invalid-credential') {
        print('wrongpassword'.tr);
        Mysnack(retry, wrongpassword, cntx);
      }
    }
  }

  clearsignindata() {
    emailController.clear();
    passwordController.clear();
  }

  clearChangepassdata() {
    oldpass.clear();
    currentpass.clear();
    confirmpass.clear();
    emailController.clear();
    resetpassemail.clear();
  }

  clearsignupdata() {
    nameController.clear();
    signUpemail.clear();
    signuppassword.clear();
    signupconfirmpass.clear();
  }

  Future forgotpassword(context) async {
    try {
      forgotpassloader.value = true;
      await auth.sendPasswordResetEmail(email: resetpassemail.text.trim());
      bool isEmailRegistered = await checkuserfoundnotfound();
      if (!isEmailRegistered) {
        Mysnack(retry, notfoundemail, context);
      } else {
        resetpopup(context).then((value) {
          if (value == true) {
            log("data=====>>>" + value.toString());
            nextscreenwithoutback(context, SignIn());
          }
        });
      }
      forgotpassloader.value = false;
      clearChangepassdata();
    } catch (e) {
      if (e is FirebaseAuthException) {
        forgotpassloader.value = false;
        print("Error" + e.toString());
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Error: ${e.message}'),
        //   ),
        // );
      }
    }
    // try {
    //   forgotpassloader.value = true;
    //   await auth.sendPasswordResetEmail(email: resetpassemail.text.trim());
    //   checkuserfoundnotfound();
    //   resetpopup(context).then((value) {
    //     if (value == true) {
    //       log("data=====>>>" + value.toString());
    //       nextscreenwithoutback(context, SignIn());
    //     }
    //   });
    //   forgotpassloader.value = false;
    //   clearChangepassdata();
    //   // Mysnack(successfull, resetpass, context);
    //   // nextscreenwithoutback(context, SignIn());
    // } catch (e) {
    //   if (e is FirebaseAuthException) {
    //     log("message" + e.code);
    //     forgotpassloader.value = false;
    //     print("Error" + e.toString());
    //     // Mysnack(retry, somethingwrong, context);
    //     // Navigator.pop(context);
    //   }
    // }
  }

  checkuserfoundnotfound() async {
    var emailToCheck = resetpassemail.text.trim();
    bool emailFound = false;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailToCheck)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        emailFound = true;
      }
    } catch (error) {
      print('Failed to retrieve data: $error');
    }

    return emailFound;
    // var result = false;
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .get()
    //     .then((QuerySnapshot queryDocumentSnapshot) async {
    //   log("Email data ==>>>" + queryDocumentSnapshot.toString());

    //   for (var i = 0; i < queryDocumentSnapshot.docs.length; i++) {
    //     var data =
    //         await jsonDecode(queryDocumentSnapshot.docs[i].data().toString());
    //     log("email found===>>>>" + data!['email']);
    //   }
    // }).catchError((error) {
    //   log('Failed to retrieve data: $error');
    // });
  }

  Future resetpopup(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          // backgroundColor: isDark ? mycolor().darkbalck : mycolor().lightWhite,
          content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Send password reset link',
              textAlign: TextAlign.center,
              style: MyTextStyle.Dynamic(
                style: MyTextStyle.mw40018,
                // color:
                //     isDark ? mycolor().lightWhite : mycolor().darkgreen
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // backgroundColor:
                    //     isDark ? mycolor().darkbalck : mycolor().lightWhite,
                    ),
                onPressed: () {
                  Navigator.pop(context, true);
                  // nextscreenwithoutback(context, SignIn());
                  // nextscreenwithoutback(context, SignIn());
                },
                child: Text(
                  "Ok",
                  style: MyTextStyle.Dynamic(
                    style: MyTextStyle.mw40018,
                    // color: isDark
                    //     ? mycolor().lightWhite
                    //     : mycolor().darkgreen
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
