import 'dart:convert';
import 'dart:developer';
import 'package:car_workshop_flutter/src/models/booking_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/core/core.dart';
import 'package:car_workshop_flutter/src/feature/mechanic/bookings/res/endpoints.dart';

import 'package:car_workshop_flutter/src/res/strings.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final mechanicBookingRepoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return MechanicBookingRepo(api: api);
});

class MechanicBookingRepo {
  final NetworkRepo _api;
  final _name = "MECHANIC_BOOKING_CONTROLLER";
  MechanicBookingRepo({required NetworkRepo api}) : _api = api;

  FutureEither<List<BookingModel>> getBookings(
      Map<String, dynamic> body) async {
    final result = await _api.postRequest(
        url: EndPoints.bookingsByMechanic, requireAuth: false, body: body);
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
}
