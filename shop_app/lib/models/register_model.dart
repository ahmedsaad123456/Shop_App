//================================================================================================================================


class RegisterModel {
  bool? status;
  String? message;
  RegisterData? data;

  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  RegisterModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] !=null? RegisterData.fromjson(json["data"]) : null;
  }
}

//================================================================================================================================


class RegisterData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  String? token;

  RegisterData.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    token = json["token"];
  }
}

//================================================================================================================================

