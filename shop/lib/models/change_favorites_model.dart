//================================================================================================================================

// Define a model class for changing favorites
class ChangeFavoritesModel {
  // Boolean status indicating success or failure
  bool? status;
  // Message returned after changing favorites
  String? message;

  // Constructor to parse JSON data into ChangeFavoritesModel
  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json["status"];
    // Parse the 'message' field from JSON
    message = json["message"];
  }
}

//================================================================================================================================
