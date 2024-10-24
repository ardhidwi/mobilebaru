import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/feature/authentication/repository/authentication_repository.dart';
import 'package:car_workshop_flutter/src/feature/authentication/res/messages.dart';
import 'package:car_workshop_flutter/src/models/product.dart';
import 'package:car_workshop_flutter/src/utils/config.dart';
import 'package:car_workshop_flutter/src/utils/snackbar_service.dart';

final authenticationControllerProvider =
    StateNotifierProvider<AuthenticationController, bool>((ref) {
  final repo = ref.watch(authenticationRepoProvider);
  return AuthenticationController(repo: repo);
});

class AuthenticationController extends StateNotifier<bool> {
  final AuthenticationRepo _repo;
  AuthenticationController({required AuthenticationRepo repo})
      : _repo = repo,
        super(false);

  Future<UserModel?> login(
      {BuildContext? context, String? email, String? password}) async {
    state = true;
    final requestBody = {
      'email': email,
      'password': password,
    };
    final result = await _repo.login(requestBody);
    return result.fold(
      (failure) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: failure.message);
        }
        state = false;
        return null;
      },
      (user) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: SuccessMessage.loginSuccess);
        }
        state = false;
        return user;
      },
    );
  }
}
