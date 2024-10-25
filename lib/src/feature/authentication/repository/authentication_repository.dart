import 'dart:convert';
import 'dart:developer';
import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/core/core.dart';
import 'package:car_workshop_flutter/src/feature/authentication/res/endpoints.dart';
import 'package:car_workshop_flutter/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final authenticationRepoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return AuthenticationRepo(api: api);
});

class AuthenticationRepo {
  final NetworkRepo _api;
  final _name = "AUTHENTICATION_CONTROLLER";
  AuthenticationRepo({required NetworkRepo api}) : _api = api;

  FutureEither<UserModel> login(Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.login, requireAuth: false, body: body);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final user = UserModel.fromJson(data);
          return Right(user);
        } catch (e, stktrc) {
          log(FailureMessage.jsonParsingFailed, name: _name);
          return Left(Failure(
            message: FailureMessage.jsonParsingFailed,
            stackTrace: stktrc,
          ));
        }
      },
    );
  }

  FutureEither<UserModel> loginAdmin(Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.loginAdmin, requireAuth: false, body: body);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final user = UserModel.fromJson(data);
          return Right(user);
        } catch (e, stktrc) {
          log(FailureMessage.jsonParsingFailed, name: _name);
          return Left(Failure(
            message: FailureMessage.jsonParsingFailed,
            stackTrace: stktrc,
          ));
        }
      },
    );
  }

  FutureEither<UserModel> register(Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.register, requireAuth: false, body: body);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final user = UserModel.fromJson(data);
          return Right(user);
        } catch (e, stktrc) {
          log(FailureMessage.jsonParsingFailed, name: _name);
          return Left(Failure(
            message: FailureMessage.jsonParsingFailed,
            stackTrace: stktrc,
          ));
        }
      },
    );
  }
}
