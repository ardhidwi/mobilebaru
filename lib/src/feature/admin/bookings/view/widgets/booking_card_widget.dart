import 'package:car_workshop_flutter/src/models/booking_model.dart';
import 'package:flutter/material.dart';

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({super.key, required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: Icon(
                Icons.car_crash_outlined,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                    '${booking.carMake}  |  ${booking.carModel}  |  ${booking.carYear}'),
                Text('Mechanic: ${booking.mechanic!.name}'),
              ],
            ),
            Spacer(),
            Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: booking.status == 'active'
                      ? Colors.amber.shade900
                      : Colors.green.shade600,
                ),
                child: Text(booking.status!,
                    style: TextStyle(color: Colors.white))),
          ],
        ));
  }
}
