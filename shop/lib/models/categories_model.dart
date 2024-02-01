//================================================================================================================================

// Define a model class for categories
class CategoriesModel {
  // Boolean status indicating success or failure
  bool? status;
  // Data model containing category data
  CategoriesDataModel? data;

  // Constructor to parse JSON data into CategoriesModel
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json['status'];
    // Parse the 'data' field from JSON using CategoriesDataModel
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

//================================================================================================================================

// Define a data model class for category data
class CategoriesDataModel {
  // Current page number
  int? currentPage;
  // List of category data
  List<DataModel>? data = [];

  // Constructor to parse JSON data into CategoriesDataModel
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'current_page' field from JSON
    currentPage = json['current_page'];
    // Iterate through the 'data' array in JSON and parse each element into DataModel
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    });
  }
}

//================================================================================================================================

// Define a model class for individual category data
class DataModel {
  // Category ID
  int? id;
  // Category name
  String? name;
  // Image URL for the category
  String? image;

  // Constructor to parse JSON data into DataModel
  DataModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'id' field from JSON
    id = json['id'];
    // Parse the 'name' field from JSON
    name = json['name'];
    // Parse the 'image' field from JSON
    image = json['image'];
  }
}

//================================================================================================================================
