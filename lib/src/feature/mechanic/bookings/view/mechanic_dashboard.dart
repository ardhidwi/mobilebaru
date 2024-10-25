import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/controller/bookings_controller.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/add_new_booking_widget.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/booking_card_widget.dart';
import 'package:car_workshop_flutter/src/feature/authentication/controller/authentication_controller.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/admin_login_screen.dart';
import 'package:car_workshop_flutter/src/feature/mechanic/bookings/controller/mechanic_bookings_controller.dart';
import 'package:car_workshop_flutter/src/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class MechanicDashboardScreen extends ConsumerWidget {
  const MechanicDashboardScreen({super.key});

  static const routePath = "/mechanicDashboard";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final dateRange = ref.watch(dateRangeProvider);
    final mechanicBookingController =
        ref.watch(mechanicBookingControllerProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Mechanic Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _onLogoutButtonPressed(context, ref);
                },
                icon: Icon(Icons.logout, color: Colors.white))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "My Bookings",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (mechanicBookingController is LoadingState)
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                if (mechanicBookingController is SuccessState &&
                    mechanicBookingController.data.isEmpty)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No bookings found.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (mechanicBookingController is SuccessState)
                  Expanded(
                    child: Column(
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: mechanicBookingController.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BookingCardWidget(
                                  booking:
                                      mechanicBookingController.data[index]);
                            }),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onLogoutButtonPressed(BuildContext context, WidgetRef ref) {
    ref
        .read(authenticationControllerProvider.notifier)
        .logout(context: context);
  }
}
