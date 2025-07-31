import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_login.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class AuthLoginController extends GetxController {
  final UserLogin userLogin;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  var isLoading = false.obs;
  var user = Rx<User?>(null);

  AuthLoginController(this.userLogin);

  @override
  void onInit() {
    emailController = TextEditingController(text: "");
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required.');
    } else {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user.value = userCredential.user;
        Get.snackbar(
          'Success',
          'Successfully logged in',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(RouteName.bottomBar);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Error',
            'No user found for that email.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Error',
            'Wrong password provided for that user.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (e.code == 'user-disabled') {
          Get.snackbar(
            'Error',
            'User disabled. Please contact support.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (e.code == 'too-many-requests') {
          Get.snackbar(
            'Error',
            'Too many requests. Try again later.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            e.message ?? 'Unknown error occurred.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> signInWithGoogle() async {
    EasyLoading.show(status: "Loading");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _saveUserDataToFirestore(user);
      }

      Get.snackbar(
        'Success',
        'Successfully logged in with Google.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(RouteName.bottomBar);
    } catch (e) {
      print('Error signing in with Google: $e');
      Get.snackbar(
        'Error',
        'Error signing in with Google: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    EasyLoading.dismiss();
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          await _saveUserDataToFirestore(user);
        }

        Get.offAllNamed(RouteName.bottomBar);
      } else {
        print('Facebook login failed');
        Get.snackbar('Error', 'Facebook login failed');
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      Get.snackbar('Error', 'Error signing in with Facebook: $e');
    }
  }

  Future<void> _saveUserDataToFirestore(User user) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    DocumentSnapshot userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      await userDocRef.set({
        'name': user.displayName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'photoURL': user.photoURL,
      });
      print('User data has been stored in Firestore.');
    } else {
      print('User data already exists in Firestore.');
    }
  }
}
