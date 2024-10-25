import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/repository/bookings_repository.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/admin_dashboard.dart';
import 'package:car_workshop_flutter/src/feature/mechanic/bookings/repository/mechanic_bookings_repository.dart';
import 'package:car_workshop_flutter/src/global/controller/shared_prefs_controller.dart';
import 'package:car_workshop_flutter/src/models/booking_model.dart';
import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/feature/authentication/repository/authentication_repository.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/res/messages.dart';
import 'package:car_workshop_flutter/src/models/product.dart';
import 'package:car_workshop_flutter/src/utils/config.dart';
import 'package:car_workshop_flutter/src/utils/snackbar_service.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

final mechanicBookingControllerProvider =
    StateNotifierProvider<MechanicBookingController, BaseState>((ref) {
  final repo = ref.watch(mechanicBookingRepoProvider);
  final controller = MechanicBookingController(ref, repo: repo);
  controller.getBookings(start: DateTime.now(), end: DateTime.now());
  return controller;
});

class MechanicBookingController extends StateNotifier<BaseState> {
  final MechanicBookingRepo _repo;
  final Ref ref;
  MechanicBookingController(this.ref, {required MechanicBookingRepo repo})
      : _repo = repo,
        super(const InitialState());

  Future<List<BookingModel>?> getBookings(
      {BuildContext? context, DateTime? start, DateTime? end}) async {
    state = const LoadingState();

    final user = await ref.read(sharedPrefsControllerPovider).getUser();
    final requestBody = user!.toJson();
    final result = await _repo.getBookings(requestBody);
    return result.fold(
      (failure) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: failure.message);
        }
        state = ErrorState(failure.message);
        return null;
      },
      (bookings) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: SuccessMessage.bookingSuccess);
        }

        state = SuccessState(data: bookings);
        return bookings;
      },
    );
  }
}
