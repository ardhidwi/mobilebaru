import 'package:car_workshop_flutter/src/core/base_state.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/controller/bookings_controller.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/controller/mechanics_controller.dart';
import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:car_workshop_flutter/src/utils/custom_button.dart';
import 'package:car_workshop_flutter/src/utils/custom_dropdown.dart';
import 'package:car_workshop_flutter/src/utils/custom_textfield.dart';
import 'package:car_workshop_flutter/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddNewBookingWidget extends ConsumerWidget {
  AddNewBookingWidget({super.key});
  static const routePath = "/addBooking";

  final _formKey = GlobalKey<FormState>();

  final _titleCont = TextEditingController();
  final _makeCont = TextEditingController();
  final _modelCont = TextEditingController();
  final _yearCont = TextEditingController();
  final _registrationCont = TextEditingController();
  final _nameCont = TextEditingController();
  final _emailCont = TextEditingController();
  final _phoneCont = TextEditingController();
  late UserModel selectedUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final dateRange = ref.watch(newBookingdateRangeProvider);
    final mechanicsController = ref.watch(mechanicsControllerProvider);
    final bookingController = ref.watch(bookingControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: mechanicsController is LoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : mechanicsController is SuccessState
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add New Booking',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextfield(
                            hintText: 'Enter booking title',
                            isPassword: false,
                            icon: Icons.title_rounded,
                            controller: _titleCont,
                            validator: (value) {
                              return Validators.validateName(_titleCont.text);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Vehicle Information',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Make',
                                  isPassword: false,
                                  icon: Icons.emoji_transportation_rounded,
                                  controller: _makeCont,
                                  validator: (value) {
                                    return Validators.validateName(
                                        _makeCont.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Model',
                                  isPassword: false,
                                  icon: Icons.emoji_transportation_rounded,
                                  controller: _modelCont,
                                  validator: (value) {
                                    return Validators.validateName(
                                        _modelCont.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Year',
                                  isPassword: false,
                                  icon: Icons.emoji_transportation_rounded,
                                  controller: _yearCont,
                                  validator: (value) {
                                    return Validators.validateName(
                                        _yearCont.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Registration',
                                  isPassword: false,
                                  icon: Icons.emoji_transportation_rounded,
                                  controller: _registrationCont,
                                  validator: (value) {
                                    return Validators.validateName(
                                        _registrationCont.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Customer Information',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          CustomTextfield(
                            hintText: 'Name',
                            isPassword: false,
                            icon: Icons.person_2_rounded,
                            controller: _nameCont,
                            validator: (value) {
                              return Validators.validateName(_nameCont.text);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Email',
                                  isPassword: false,
                                  icon: Icons.email,
                                  controller: _emailCont,
                                  validator: (value) {
                                    return Validators.validateEmail(
                                        _emailCont.text);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: CustomTextfield(
                                  hintText: 'Phone number',
                                  isPassword: false,
                                  icon: Icons.phone,
                                  controller: _phoneCont,
                                  validator: (value) {
                                    return Validators.validateName(
                                        _phoneCont.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Service Duration',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
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
                                  borderRadius: BorderRadius.circular(10)),
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
                            height: 10,
                          ),
                          const Text(
                            'Select Mechanic',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDropdownFormField(
                            options: mechanicsController.data,
                            onChanged: (user) {
                              selectedUser = user!;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            onPressed: () {
                              _onAddButtonPressed(context, ref);
                            },
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            child: bookingController is LoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Add Booking',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text('Something Went Wrong!'),
      ),
    );
  }

  _onDateTap(BuildContext ctx, WidgetRef ref) async {
    final dateRange = await showDateRangePicker(
      context: ctx,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (dateRange != null) {
      ref.read(newBookingdateRangeProvider.notifier).update((state) {
        return [dateRange.start, dateRange.end];
      });
    }
  }

  _onAddButtonPressed(BuildContext ctx, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      final dates = ref.read(newBookingdateRangeProvider);
      final start = dates[0];
      final end = dates[1];
      ref.read(bookingControllerProvider.notifier).createNewBooking(
          context: ctx,
          title: _titleCont.text,
          make: _makeCont.text,
          model: _modelCont.text,
          year: _yearCont.text,
          registration: _registrationCont.text,
          name: _nameCont.text,
          email: _emailCont.text,
          phone: _phoneCont.text,
          start: start,
          end: end,
          mechanic: selectedUser);
    }
  }
}
