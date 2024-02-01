//================================================================================================================================
// This file contains utility functions related to user authentication and token management.

import 'package:shop/layout/home_cubit/home_cubit.dart'; 
import 'package:shop/modules/login/login_screen.dart'; 
import 'package:shop/shared/components/components.dart'; 
import 'package:shop/shared/network/local/cache_helper.dart'; 

//================================================================================================================================

// Function to sign out the user by removing the token from local storage and resetting relevant data in the HomeCubit.
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      // If the token is successfully removed, reset user-related data in the HomeCubit.
      HomeCubit.get(context).userModel = null;
      HomeCubit.get(context).changeFavoritesModel = null;
      HomeCubit.get(context).homeModel = null;
      HomeCubit.get(context).favoritesModel = null;
      HomeCubit.get(context).categoriesModel = null;

      // Navigate to the LoginScreen after signing out.
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

//================================================================================================================================

String? token; // Declaring a global variable to hold the user token.

//================================================================================================================================

