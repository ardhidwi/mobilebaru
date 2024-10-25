import 'dart:convert';
import 'dart:developer';
import 'package:car_workshop_flutter/src/models/booking_model.dart';
import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/core/core.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/res/endpoints.dart';
import 'package:car_workshop_flutter/src/models/product.dart';
import 'package:car_workshop_flutter/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final bookingRepoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return BookingRepo(api: api);
});

class BookingRepo {
  final NetworkRepo _api;
  final _name = "BOOKING_CONTROLLER";
  BookingRepo({required NetworkRepo api}) : _api = api;

  FutureEither<List<BookingModel>> getBookingsByDateRange(
      Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.bookingsByDateRange, requireAuth: false, body: body);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          List<BookingModel> bookings = [];
          (data as List).forEach((booking) {
            bookings.add(BookingModel.fromJson(booking));
          });
          return Right(bookings);
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

  FutureEither<List<UserModel>> getMechanics() async {
    final result = await _api.getRequest(
      url: EndPoints.users,
      requireAuth: false,
    );
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          List<UserModel> mechanics = [];
          (data as List).forEach((booking) {
            mechanics.add(UserModel.fromJson(booking));
          });
          return Right(mechanics);
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

  FutureEither<BookingModel> addNewBooking(Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.bookings, requireAuth: false, body: body);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final booking = BookingModel.fromJson(data);
          return Right(booking);
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
