import 'package:car_workshop_flutter/src/feature/authentication/view/admin_login_screen.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/login_screen.dart';
import 'package:car_workshop_flutter/src/utils/asset_urls.dart';
import 'package:car_workshop_flutter/src/utils/custom_button.dart';
import 'package:car_workshop_flutter/src/utils/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RegisterMechanicScreen extends ConsumerWidget {
  const RegisterMechanicScreen({super.key});

  static const routePath = "/registerMechanic";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetURL.appLogo),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Register Mechanic',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Name',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const CustomTextfield(
                hintText: 'Enter name',
                isPassword: false,
                icon: Icons.email,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Email',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const CustomTextfield(
                hintText: 'Enter your email',
                isPassword: false,
                icon: Icons.email,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const CustomTextfield(
                hintText: 'Password',
                isPassword: true,
                icon: Icons.password,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Confirm Password',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const CustomTextfield(
                hintText: 'Confirm Password',
                isPassword: true,
                icon: Icons.password,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {},
                backgroundColor: Colors.red,
                textColor: Colors.white,
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    context.go(LoginScreen.routePath);
                  },
                  child: const Text(
                    'Login as mechanic',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
