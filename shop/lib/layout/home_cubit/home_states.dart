import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/login_model.dart';
//================================================================================================================================

// Abstract class representing the states of the ShopLayout
abstract class ShopLayoutStates {}

// Initial state of the ShopLayout
class ShopLayoutinitialState extends ShopLayoutStates {}

//================================================================================================================================

// State indicating a change in the bottom navigation bar
class ChangeBottomnavBarState extends ShopLayoutStates {}

//================================================================================================================================

// States related to home data loading
class HomeLoadingDataState extends ShopLayoutStates {}
class HomeSuccessDataState extends ShopLayoutStates {}
class HomeErrorDataState extends ShopLayoutStates {}

//================================================================================================================================

// States related to categories data loading
class CategoriesSuccessDataState extends ShopLayoutStates {}
class CategoriesErrorDataState extends ShopLayoutStates {}

// State indicating a change in favorites
class ShopChangeFavoritesState extends ShopLayoutStates {}

//================================================================================================================================

// States related to favorites data loading
class ShopSuccessChangeFavoritesState extends ShopLayoutStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopLayoutStates {}

//================================================================================================================================

// States related to fetching user favorites
class ShopLoadingGetFavoritesState extends ShopLayoutStates {}
class ShopSuccessGetFavoritesState extends ShopLayoutStates {}
class ShopErrorGetFavoritesState extends ShopLayoutStates {}

//================================================================================================================================

// States related to fetching user profile
class ShopLoadingGetProfileState extends ShopLayoutStates {}
class ShopSuccessGetProfileState extends ShopLayoutStates {}
class ShopErrorGetProfileState extends ShopLayoutStates {}

//================================================================================================================================

// States related to updating user profile
class ShopLoadingUpdateProfileState extends ShopLayoutStates {}
class ShopSuccessUpdateProfileState extends ShopLayoutStates {
  final LoginModel? model;

  ShopSuccessUpdateProfileState(this.model);
}
class ShopErrorUpdateProfileState extends ShopLayoutStates {}

//================================================================================================================================

// States related to searching for products
class ShopLoadingSearchState extends ShopLayoutStates {}
class ShopSuccessSearchState extends ShopLayoutStates {}
class ShopErrorSearchState extends ShopLayoutStates {}

//================================================================================================================================
