import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/favorites/favorites_screen.dart';
import 'package:shop/modules/products/poducts_screen.dart';
import 'package:shop/modules/settings/settigns_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
//================================================================================================================================

// A Cubit responsible for managing the state of the home screen
class HomeCubit extends Cubit<ShopLayoutStates> {
  HomeCubit() : super(ShopLayoutinitialState());

  // Static method to get the HomeCubit instance from the context
  static HomeCubit get(context) => BlocProvider.of(context);

  // Index of the currently selected bottom navigation bar item
  int currentIndex = 0;

//================================================================================================================================

  // List of widgets representing the screens accessible from the bottom navigation bar
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  // Method to change the currently displayed screen
  void changeScreen(index) {
    currentIndex = index;
    emit(ChangeBottomnavBarState());
  }

//================================================================================================================================

  // Home data model containing information about products, banners, etc.
  HomeModel? homeModel;

  // Map to store the favorite status of each product
  Map<int?, bool?> favorites = {};

  // Method to fetch home data from the API
  void getHomeData() {
    emit(HomeLoadingDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // Initialize favorites map with product IDs and their corresponding favorite status
      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(HomeSuccessDataState());
    }).catchError((error) {
      emit(HomeErrorDataState());
    });
  }

//================================================================================================================================

  // Categories data model containing information about product categories
  CategoriesModel? categoriesModel;
  
  // Method to fetch categories data from the API
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessDataState());
    }).catchError((error) {
      emit(CategoriesErrorDataState());
    });
  }

//================================================================================================================================

  // Model for response after changing favorites
  ChangeFavoritesModel? changeFavoritesModel;

  // Method to toggle the favorite status of a product
  void changeFavoritesData(int? productId) {
    // Toggle the favorite status of the product
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());
    
    // Send a request to the API to update the favorite status
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      // If the request is unsuccessful, revert the favorite status back
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      // If an error occurs, revert the favorite status back
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

//================================================================================================================================

  // Model for favorites data
  FavoritesModel? favoritesModel;

  // Method to fetch user's favorite products from the API
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

//================================================================================================================================

  // Model for user profile data
  LoginModel? userModel;

  // Method to fetch user profile data from the API
  void getProfile() {
    emit(ShopLoadingGetProfileState());

    DioHelper.getData(url: GET_PROFILE, token: token).then((value) {
      userModel = LoginModel.fromjson(value.data);

      emit(ShopSuccessGetProfileState());
    }).catchError((error) {
      emit(ShopErrorGetProfileState());
    });
  }

//================================================================================================================================

  // Method to update user profile information
  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateProfileState());

    DioHelper.putData(
            url: UPDATE_PROFILE,
            data: {
              "name": name,
              "phone": phone,
              "email": email,
            },
            token: token)
        .then((value) {
      userModel = LoginModel.fromjson(value.data);
      emit(ShopSuccessUpdateProfileState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateProfileState());
    });
  }

//================================================================================================================================

  // Model for search results
  SearchModel? searchModel;

  // Method to search for products based on a given text
  void searchProducts({required String? text}) {
    emit(ShopLoadingSearchState());
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error) {
      emit(ShopErrorSearchState());
    });
  }

//================================================================================================================================

}

//================================================================================================================================
