//================================================================================================================================

// Define a model class for favorites
class FavoritesModel {
  // Boolean status indicating success or failure
  bool? status;
  // Data model containing favorite data
  Data? data;
  
  // Constructor to parse JSON data into FavoritesModel
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json['status'];
    // Parse the 'data' field from JSON using Data model
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

//================================================================================================================================

// Define a data model class for favorite data
class Data {
  // Current page number
  int? currentPage;
  // List of favorite data
  List<FavoritesData>? data = [];
  // URL for the first page of favorites
  String? firstPageUrl;
  // Index of the first item on the page
  int? from;
  // Index of the last page
  int? lastPage;
  // URL for the last page of favorites
  String? lastPageUrl;
  // Path of the current page
  String? path;
  // Number of items per page
  int? perPage;
  // Index of the last item on the page
  int? to;
  // Total number of favorite items
  int? total;

  // Constructor to parse JSON data into Data model
  Data.fromJson(Map<String, dynamic> json) {
    // Parse the 'current_page' field from JSON
    currentPage = json['current_page'];
    // Parse the 'data' field from JSON into a list of FavoritesData objects
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(FavoritesData.fromJson(v));
      });
    }
    // Parse other pagination-related fields from JSON
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

//================================================================================================================================

// Define a model class for individual favorite data
class FavoritesData {
  // Favorite item ID
  int? id;
  // Product associated with the favorite item
  Product? product;

  // Constructor to parse JSON data into FavoritesData
  FavoritesData.fromJson(Map<String, dynamic> json) {
    // Parse the 'id' field from JSON
    id = json['id'];
    // Parse the 'product' field from JSON using Product model
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

//================================================================================================================================

// Define a model class for individual product data
class Product {
  // Product ID
  int? id;
  // Price of the product
  dynamic price;
  // Old price of the product (if any)
  dynamic oldPrice;
  // Discount percentage (if any)
  int? discount;
  // Image URL for the product
  String? image;
  // Name of the product
  String? name;
  // Description of the product
  String? description;

  // Constructor to create a Product object
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  // Constructor to parse JSON data into Product
  Product.fromJson(Map<String, dynamic> json) {
    // Parse fields from JSON
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  // Method to convert Product object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // Populate fields in JSON
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}

//================================================================================================================================
