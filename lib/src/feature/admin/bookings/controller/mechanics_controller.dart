import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/repository/bookings_repository.dart';
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

final mechanicsControllerProvider =
    StateNotifierProvider<MechanicsController, BaseState>((ref) {
  final repo = ref.watch(bookingRepoProvider);
  final controller = MechanicsController(ref, repo: repo);
  controller.getMechanics();
  return controller;
});

class MechanicsController extends StateNotifier<BaseState> {
  final BookingRepo _repo;
  final Ref ref;
  MechanicsController(this.ref, {required BookingRepo repo})
      : _repo = repo,
        super(const InitialState());

  Future<List<UserModel>?> getMechanics({BuildContext? context}) async {
    state = const LoadingState();

    final result = await _repo.getMechanics();
    return result.fold(
      (failure) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: failure.message);
        }
        state = ErrorState(failure.message);
        return null;
      },
      (mechanics) {
        if (AppConfig.devMode && context != null) {
          SnackBarService.showSnackBar(
              context: context, message: SuccessMessage.mechanicSuccess);
        }

        state = SuccessState(data: mechanics);
        return mechanics;
      },
    );
  }
}
