import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/features/auth/domain/usecases/user_register.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class AuthRegisterController extends GetxController {
  final UserRegister userRegister;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController countryCodeController;

  AuthRegisterController(this.userRegister);

  @override
  void onInit() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    countryCodeController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }

  Future<String?> registration({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String confirmPassword,
    required String countryCode,
  }) async {
    try {
      if (password != confirmPassword) {
        return 'Password and Confirm Password must be the same';
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          return 'The account already exists for that email.';
        } else {
          return e.message;
        }
      }

      User? user = FirebaseAuth.instance.currentUser;

      phone = countryCode + phone;
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'phoneNumber': phone,
        'photoUrl': null
      };

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(userData);

      await FirebaseAuth.instance.signOut();

      // Redirect to login screen
      Get.offAllNamed(RouteName.login);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
