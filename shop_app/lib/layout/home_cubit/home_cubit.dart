import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/home_states.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/poducts_screen.dart';
import 'package:shop_app/modules/settings/settigns_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

//================================================================================================================================


class HomeCubit extends Cubit<ShopLayoutStates> {
  HomeCubit() : super(ShopLayoutinitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

//================================================================================================================================

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeScreen(index) {
    currentIndex = index;
    emit(ChangeBottomnavBarState());
  }

//================================================================================================================================


  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(HomeLoadingDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products) {
        favorites.addAll({element.id: element.inFavorites});
      }
      emit(HomeSuccessDataState());
    }).catchError((error) {
      emit(HomeErrorDataState());
    });
  }

//================================================================================================================================


  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessDataState());
    }).catchError((error) {
      emit(CategoriesErrorDataState());
    });
  }

//================================================================================================================================


  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavoritesData(int? productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

//================================================================================================================================


  FavoritesModel? favoritesModel;

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

  LoginModel? userModel;

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

  void updateProfile(
      {required String name, required String email, required String phone}) {
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
      // getProfile();
      emit(ShopSuccessUpdateProfileState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateProfileState());
    });
  }

//================================================================================================================================


  SearchModel? searchModel;

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

