import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

//================================================================================================================================


abstract class ShopLayoutStates {}

class ShopLayoutinitialState extends ShopLayoutStates {}

//================================================================================================================================


class ChangeBottomnavBarState extends ShopLayoutStates {}

//================================================================================================================================


class HomeLoadingDataState extends ShopLayoutStates {}

class HomeSuccessDataState extends ShopLayoutStates {}

class HomeErrorDataState extends ShopLayoutStates {}

//================================================================================================================================


class CategoriesSuccessDataState extends ShopLayoutStates {}

class CategoriesErrorDataState extends ShopLayoutStates {}

class ShopChangeFavoritesState extends ShopLayoutStates {}

//================================================================================================================================


class ShopSuccessChangeFavoritesState extends ShopLayoutStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopLayoutStates {}

//================================================================================================================================


class ShopLoadingGetFavoritesState extends ShopLayoutStates {}

class ShopSuccessGetFavoritesState extends ShopLayoutStates {}

class ShopErrorGetFavoritesState extends ShopLayoutStates {}

//================================================================================================================================


class ShopLoadingGetProfileState extends ShopLayoutStates {}

class ShopSuccessGetProfileState extends ShopLayoutStates {}

class ShopErrorGetProfileState extends ShopLayoutStates {}

//================================================================================================================================


class ShopLoadingUpdateProfileState extends ShopLayoutStates {}

class ShopSuccessUpdateProfileState extends ShopLayoutStates {
  final LoginModel? model;

  ShopSuccessUpdateProfileState(this.model);
}

class ShopErrorUpdateProfileState extends ShopLayoutStates {}

//================================================================================================================================



class ShopLoadingSearchState extends ShopLayoutStates {}

class ShopSuccessSearchState extends ShopLayoutStates {}

class ShopErrorSearchState extends ShopLayoutStates {}

//================================================================================================================================

