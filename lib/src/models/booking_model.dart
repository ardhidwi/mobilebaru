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
    mechanic = json['mechanic'] != null
        ? new UserModel.fromJson(json['mechanic'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['car_year'] = this.carYear;
    data['car_registration'] = this.carRegistration;
    data['customer_name'] = this.customerName;
    data['customer_email'] = this.customerEmail;
    data['customer_phone'] = this.customerPhone;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
    return data;
  }
}
