import 'package:car_workshop_flutter/src/feature/authentication/controller/authentication_controller.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/admin_login_screen.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/register_mechanic_screen.dart';
import 'package:car_workshop_flutter/src/utils/asset_urls.dart';
import 'package:car_workshop_flutter/src/utils/custom_button.dart';
import 'package:car_workshop_flutter/src/utils/custom_textfield.dart';
import 'package:car_workshop_flutter/src/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  static const routePath = "/login";
  final _formkey = GlobalKey<FormState>();
  final _emailCont = TextEditingController();
  final _passCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;

    final isloading = ref.watch(authenticationControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: height,
          child: Form(
            key: _formkey,
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
                    'Welcome back!',
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
                  'Email',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                CustomTextfield(
                  hintText: 'Enter your email',
                  isPassword: false,
                  icon: Icons.email,
                  controller: _emailCont,
                  validator: (value) {
                    return Validators.validateEmail(_emailCont.text);
                  },
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
                CustomTextfield(
                  hintText: 'Password',
                  isPassword: true,
                  icon: Icons.password,
                  controller: _passCont,
                  validator: (value) {
                    return Validators.validatePassword(_passCont.text);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {
                    _onLoginButtonPressed(context, ref);
                  },
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Login',
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
                      context.go(AdminLoginScreen.routePath);
                    },
                    child: const Text(
                      'Login as administrator',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      context.go(RegisterMechanicScreen.routePath);
                    },
                    child: const Text(
                      'Register as a mechanic',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onLoginButtonPressed(BuildContext ctx, WidgetRef ref) async {
    if (_formkey.currentState!.validate()) {
      ref.read(authenticationControllerProvider.notifier).login(
          context: ctx, email: _emailCont.text, password: _passCont.text);
    }
  }
}
