//================================================================================================================================

// Define a model class for home data
class HomeModel {
  // Boolean status indicating success or failure
  bool? status;
  // Data model containing home data
  HomeDataModel? data;

  // Constructor to parse JSON data into HomeModel
  HomeModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'status' field from JSON
    status = json['status'];
    // Parse the 'data' field from JSON using HomeDataModel
    data = HomeDataModel.fromJson(json['data']);
  }
}

//================================================================================================================================

// Define a data model class for home data
class HomeDataModel {
  // List of banner models
  List<BannerModel> banners = [];
  // List of product models
  List<ProductModel> products = [];

  // Constructor to parse JSON data into HomeDataModel
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    // Iterate through the 'banners' array in JSON and parse each element into BannerModel
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    // Iterate through the 'products' array in JSON and parse each element into ProductModel
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

//================================================================================================================================

// Define a model class for individual banner data
class BannerModel {
  // Banner ID
  int? id;
  // Image URL for the banner
  String? image;

  // Constructor to parse JSON data into BannerModel
  BannerModel.fromJson(Map<String, dynamic> json) {
    // Parse the 'id' field from JSON
    id = json['id'];
    // Parse the 'image' field from JSON
    image = json['image'];
  }
}

//================================================================================================================================

// Define a model class for individual product data
class ProductModel {
  // Product ID
  int? id;
  // Price of the product
  dynamic price;
  // Old price of the product (if any)
  dynamic oldPrice;
  // Discount percentage (if any)
  dynamic discount;
  // Image URL for the product
  String? image;
  // Name of the product
  String? name;
  // Boolean indicating whether the product is in favorites
  bool? inFavorites;
  // Boolean indicating whether the product is in cart
  bool? inCart;

  // Constructor to parse JSON data into ProductModel
  ProductModel.fromJson(Map<String, dynamic> json) {
    // Parse fields from JSON
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

//================================================================================================================================
