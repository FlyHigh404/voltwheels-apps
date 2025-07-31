import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:voltwheels_mobile/features/auth/presentation/auth_register/controllers/auth_register_controller.dart';
import 'package:voltwheels_mobile/routes/route.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPage();
}

class _AuthRegisterPage extends State<AuthRegisterPage> {
  double sheetPosition = 0.0;
  bool isRememberMeChecked = false;
  bool isPasswordObscured = true;


  @override
  void initState() {
    super.initState();
  }

  AuthRegisterController controller = Get.find<AuthRegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                Image.asset(
                  Assets.backgroundAuth,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Image.asset(Assets.arrowBack),
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Datang!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomDetails(),
        ],
      ),
    );
  }

  Widget bottomDetails() {
    return DraggableScrollableSheet(
      initialChildSize: 0.77,
      minChildSize: 0.77,
      maxChildSize: 0.96,
      builder: (BuildContext context, ScrollController scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              sheetPosition = notification.extent;
              sheetPosition = notification.extent;
            });
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  formRegister(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget formRegister() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Daftar',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Daftar untuk bisa masuk ke aplikasi',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          IntlPhoneField(
            controller: controller.phoneController,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            initialCountryCode: 'ID',
            onChanged: (phone) {
              print(phone.completeNumber);
              controller.countryCodeController.text = phone.countryCode;
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.passwordController,
            obscureText: isPasswordObscured,  // Bind the obscureText property to state variable
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordObscured = !isPasswordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.confirmPasswordController,
            obscureText: isPasswordObscured,  // Bind the obscureText property to state variable
            decoration: InputDecoration(
              labelText: 'Konfirmasi Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordObscured = !isPasswordObscured;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final result = await controller.registration(
                email: controller.emailController.text,
                password: controller.passwordController.text,
                name: controller.nameController.text,
                phone: controller.phoneController.text,
                confirmPassword: controller.confirmPasswordController.text,
                countryCode: controller.countryCodeController.text,
              );
              if (result == 'Success') {
                
                Get.snackbar(
                  'Success',
                  'Registration Successfully',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                
                Get.toNamed(RouteName.bottomBar);
              } else {
                Get.snackbar(
                  'Error',
                  result ?? 'Terjadi kesalahan',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text('Daftar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1FAA3E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Sudah punya akun? ',
                style: const TextStyle(color: Colors.black), // Regular text style
                children: <TextSpan>[
                  TextSpan(
                    text: 'Masuk',
                    style: const TextStyle(color: Colors.green), // Clickable text style
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouteName.login);
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
