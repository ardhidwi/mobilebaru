class UserModel {
  String? email;
  int? id;
  String? name;
  String? role;

  UserModel({this.email, this.id, this.name, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    return data;
  }
}
