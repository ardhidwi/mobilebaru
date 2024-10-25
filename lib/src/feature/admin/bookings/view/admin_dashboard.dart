import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/controller/bookings_controller.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/add_new_booking_widget.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/booking_card_widget.dart';
import 'package:car_workshop_flutter/src/feature/authentication/controller/authentication_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  static const routePath = "/adminDashboard";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;

    final dateRange = ref.watch(dateRangeProvider);
    final bookingController = ref.watch(bookingControllerProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _onLogoutButtonPressed(context, ref);
                },
                icon: const Icon(Icons.logout, color: Colors.white))
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _onAddNewBookingButtonPressed(context);
          },
          backgroundColor: Colors.red.shade200,
          child: const Icon(
            Icons.add_circle_outline,
            size: 30,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    _onDateTap(context, ref);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat.yMMMMd().format(
                            dateRange[0],
                          )} - ${DateFormat.yMMMMd().format(
                            dateRange[1],
                          )}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        _onSelectToday(context, ref);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(16)),
                        child: const Text(
                          'Today',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _onSelectLastWeek(context, ref);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(16)),
                        child: const Text(
                          'Last Week',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _onSelectLastMonth(context, ref);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(16)),
                        child: const Text(
                          'Last Month',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                          'No bookings found for the given date range.',
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
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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

  _onDateTap(BuildContext ctx, WidgetRef ref) async {
    final dateRange = await showDateRangePicker(
      context: ctx,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (dateRange != null) {
      ref.read(dateRangeProvider.notifier).update((state) {
        return [dateRange.start, dateRange.end];
      });
      ref.read(bookingControllerProvider.notifier).getBookingsByDateRange(
          context: ctx, start: dateRange.start, end: dateRange.end);
    }
  }

  _onSelectToday(BuildContext ctx, WidgetRef ref) async {
    ref.read(dateRangeProvider.notifier).update((state) {
      return [DateTime.now(), DateTime.now()];
    });
    ref.read(bookingControllerProvider.notifier).getBookingsByDateRange(
        context: ctx, start: DateTime.now(), end: DateTime.now());
  }

  _onSelectLastWeek(BuildContext ctx, WidgetRef ref) async {
    ref.read(dateRangeProvider.notifier).update((state) {
      return [DateTime.now().subtract(const Duration(days: 7)), DateTime.now()];
    });
    ref.read(bookingControllerProvider.notifier).getBookingsByDateRange(
        context: ctx,
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now());
  }

  _onSelectLastMonth(BuildContext ctx, WidgetRef ref) async {
    ref.read(dateRangeProvider.notifier).update((state) {
      return [
        DateTime.now().subtract(const Duration(days: 30)),
        DateTime.now()
      ];
    });
    ref.read(bookingControllerProvider.notifier).getBookingsByDateRange(
        context: ctx,
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now());
  }

  _onAddNewBookingButtonPressed(BuildContext ctx) {
    ctx.push(AddNewBookingWidget.routePath);
  }

  _onLogoutButtonPressed(BuildContext context, WidgetRef ref) {
    ref
        .read(authenticationControllerProvider.notifier)
        .logout(context: context);
  }
}
