import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/repository/bookings_repository.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/admin_dashboard.dart';
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

final bookingControllerProvider =
    StateNotifierProvider<BookingController, BaseState>((ref) {
  final repo = ref.watch(bookingRepoProvider);
  final controller = BookingController(ref, repo: repo);
  controller.getBookingsByDateRange(start: DateTime.now(), end: DateTime.now());
  return controller;
});

final dateRangeProvider = StateProvider<List<DateTime>>((ref) {
  return [DateTime.now(), DateTime.now()];
});

final newBookingdateRangeProvider = StateProvider<List<DateTime>>((ref) {
  return [DateTime.now(), DateTime.now()];
});

class BookingController extends StateNotifier<BaseState> {
  final BookingRepo _repo;
  final Ref ref;
  BookingController(this.ref, {required BookingRepo repo})
      : _repo = repo,
        super(const InitialState());

  Future<List<BookingModel>?> getBookingsByDateRange(
      {BuildContext? context, DateTime? start, DateTime? end}) async {
    state = const LoadingState();
    final requestBody = {
      'start': DateFormat('yyyy-MM-dd').format(start!).toString(),
      'end': DateFormat('yyyy-MM-dd').format(end!).toString(),
    };
    final result = await _repo.getBookingsByDateRange(requestBody);
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

  Future<BookingModel?> createNewBooking(
      {BuildContext? context,
      String? title,
      make,
      model,
      year,
      registration,
      name,
      email,
      phone,
      UserModel? mechanic,
      DateTime? start,
      DateTime? end}) async {
    state = const LoadingState();
    final requestBody = {
      "title": title,
      "car_make": make,
      "car_model": model,
      "car_year": year,
      "car_registration": registration,
      "customer_name": name,
      "customer_email": email,
      "customer_phone": phone,
      "mechanic_id": mechanic!.id,
      'start': DateFormat('yyyy-MM-dd').format(start!).toString(),
      'end': DateFormat('yyyy-MM-dd').format(end!).toString(),
    };
    final result = await _repo.addNewBooking(requestBody);
    return result.fold(
      (failure) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: failure.message);
        }
        state = ErrorState(failure.message);
        return null;
      },
      (booking) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: SuccessMessage.bookingCreateSuccess);
        }

        state = SuccessState(data: booking);
        ref.read(bookingControllerProvider.notifier).getBookingsByDateRange(
            context: context, start: DateTime.now(), end: DateTime.now());
        context!.go(AdminDashboardScreen.routePath);
        return booking;
      },
    );
  }
}
