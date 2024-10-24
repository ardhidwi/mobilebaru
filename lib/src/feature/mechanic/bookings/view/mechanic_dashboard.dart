import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/controller/bookings_controller.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/add_new_booking_widget.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/booking_card_widget.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/admin_login_screen.dart';
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
    final bookingController = ref.watch(bookingControllerProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Container(
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (bookingController is LoadingState)
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                if (bookingController is SuccessState &&
                    bookingController.data.isEmpty)
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No bookings found.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                if (bookingController is SuccessState)
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: bookingController.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BookingCardWidget(
                                  booking: bookingController.data[index]);
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
}
