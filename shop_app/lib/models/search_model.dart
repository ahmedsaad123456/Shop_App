
//================================================================================================================================

class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = SearchData.formJson(json['data']);

  }
}


//================================================================================================================================


class SearchData {
  List<ProductData> products = [];

  SearchData.formJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      products.add(ProductData.fromJson(element));
    });
  }
}

//================================================================================================================================


class ProductData {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['inFavorites'];
    inCart = json['inCart'];
  }
}

//================================================================================================================================

