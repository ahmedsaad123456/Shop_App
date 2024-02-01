//================================================================================================================================

// Define a model class for registration response
class RegisterModel {
  // Boolean status indicating success or failure
  bool? status;
  // Message returned after registration attempt
  String? message;
  // Registration data model containing user information
  RegisterData? data;

  // Constructor to create a RegisterModel object
  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  // Named constructor to parse JSON data into RegisterModel
  RegisterModel.fromjson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json["status"];
    // Parse the 'message' field from JSON
    message = json["message"];
    // Parse the 'data' field from JSON using RegisterDataModel if it exists, otherwise set it to null
    data = json["data"] != null ? RegisterData.fromjson(json["data"]) : null;
  }
}

//================================================================================================================================

// Define a model class for registration data
class RegisterData {
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
  // Authentication token for the user session
  String? token;

  // Constructor to parse JSON data into RegisterData
  RegisterData.fromjson(Map<String, dynamic> json) {
    // Parse fields from JSON
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    token = json["token"];
  }
}

//================================================================================================================================
