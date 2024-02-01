//================================================================================================================================

// Define a model class for search response
class SearchModel {
  // Boolean status indicating success or failure
  bool? status;
  // Search data model containing search results
  SearchData? data;

  // Constructor to parse JSON data into SearchModel
  SearchModel.fromJson(Map<String, dynamic> json){
    // Parse the 'status' field from JSON
    status = json['status'];
    // Parse the 'data' field from JSON using SearchDataModel
    data = SearchData.formJson(json['data']);
  }
}

//================================================================================================================================

// Define a data model class for search data
class SearchData {
  // List of product data returned from the search
  List<ProductData> products = [];

  // Constructor to parse JSON data into SearchData
  SearchData.formJson(Map<String, dynamic> json) {
    // Iterate through the 'data' array in JSON and parse each element into ProductData
    json['data'].forEach((element) {
      products.add(ProductData.fromJson(element));
    });
  }
}

//================================================================================================================================

// Define a model class for individual product data in search results
class ProductData {
  // Product ID
  int? id;
  // Price of the product
  dynamic price;
  // Image URL for the product
  String? image;
  // Name of the product
  String? name;
  // Boolean indicating whether the product is in favorites
  bool? inFavorites;
  // Boolean indicating whether the product is in cart
  bool? inCart;

  // Constructor to parse JSON data into ProductData
  ProductData.fromJson(Map<String, dynamic> json) {
    // Parse fields from JSON
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['inFavorites'];
    inCart = json['inCart'];
  }
}

//================================================================================================================================
