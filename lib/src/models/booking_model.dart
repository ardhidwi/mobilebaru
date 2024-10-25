import 'package:car_workshop_flutter/src/models/user_model.dart';

class BookingModel {
  String? title;
  int? id;
  String? carMake;
  String? carModel;
  String? carYear;
  String? carRegistration;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? start;
  String? end;
  String? status;
  UserModel? mechanic;

  BookingModel(
      {this.title,
      this.id,
      this.carMake,
      this.carModel,
      this.carYear,
      this.carRegistration,
      this.customerName,
      this.customerEmail,
      this.customerPhone,
      this.start,
      this.end,
      this.mechanic,
      this.status});

  BookingModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    carMake = json['car_make'];
    carModel = json['car_model'];
    carYear = json['car_year'];
    carRegistration = json['car_registration'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    customerPhone = json['customer_phone'];
    start = json['start'];
    end = json['end'];
    status = json['status'];
    mechanic =
        json['mechanic'] != null ? UserModel.fromJson(json['mechanic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['id'] = id;
    data['car_make'] = carMake;
    data['car_model'] = carModel;
    data['car_year'] = carYear;
    data['car_registration'] = carRegistration;
    data['customer_name'] = customerName;
    data['customer_email'] = customerEmail;
    data['customer_phone'] = customerPhone;
    data['start'] = start;
    data['end'] = end;
    data['status'] = status;
    if (mechanic != null) {
      data['mechanic'] = mechanic!.toJson();
    }
    return data;
  }
}
