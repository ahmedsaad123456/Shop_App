//================================================================================================================================

// Define a model class for login response
class LoginModel {
  // Boolean status indicating success or failure
  bool? status;
  // Message returned after login attempt
  String? message;
  // User data model containing user information
  UserDataModel? data;

  // Constructor to create a LoginModel object
  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  // Named constructor to parse JSON data into LoginModel
  LoginModel.fromjson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json["status"];
    // Parse the 'message' field from JSON
    message = json["message"];
    // Parse the 'data' field from JSON using UserDataModel if it exists, otherwise set it to null
    data = json["data"] != null ? UserDataModel.fromjson(json["data"]) : null;
  }
}

//================================================================================================================================

// Define a model class for user data
class UserDataModel {
  // User ID
  int? id;
  // User name
  String? name;
  // User email
  String? email;
  // User phone number
  String? phone;
  // URL of the user's profile image
  String? image;
  // User points
  int? points;
  // User credit
  int? credit;
  // Authentication token for the user session
  String? token;

  // Constructor to parse JSON data into UserDataModel
  UserDataModel.fromjson(Map<String, dynamic> json) {
    // Parse fields from JSON
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}

//================================================================================================================================
