import 'package:car_workshop_flutter/src/global/controller/shared_prefs_controller.dart';
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
  return AuthenticationController(ref, repo: repo);
});

class AuthenticationController extends StateNotifier<bool> {
  final AuthenticationRepo _repo;
  final Ref ref;
  AuthenticationController(this.ref, {required AuthenticationRepo repo})
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

        ref.read(sharedPrefsControllerPovider).setUser(user: user);
        state = false;
        return user;
      },
    );
  }

  Future<UserModel?> loginAdmin(
      {BuildContext? context, String? email, String? password}) async {
    state = true;
    final requestBody = {
      'email': email,
      'password': password,
    };
    final result = await _repo.loginAdmin(requestBody);
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
        ref.read(sharedPrefsControllerPovider).setUser(user: user);
        state = false;
        return user;
      },
    );
  }

  Future<UserModel?> register(
      {BuildContext? context,
      String? email,
      String? password,
      String? name}) async {
    state = true;
    final requestBody = {
      'email': email,
      'password': password,
      'name': name,
      'role': 'mechanic',
    };
    final result = await _repo.register(requestBody);
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
              context: context, message: SuccessMessage.registerSuccess);
        }
        state = false;
        return user;
      },
    );
  }
}
