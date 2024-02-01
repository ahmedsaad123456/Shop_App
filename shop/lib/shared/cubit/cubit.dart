//==========================================================================================================================================================
// This file contains the DarkCubit class, which manages the state related to the app's dark mode.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/states.dart'; 
import 'package:shop/shared/network/local/cache_helper.dart'; 

//==========================================================================================================================================================

// A Cubit class to handle the state related to dark mode.
class DarkCubit extends Cubit<DarkStates> {
  DarkCubit() : super(DarkInitialState()); // Initializing the cubit with DarkInitialState.

  // Static method to get an instance of DarkCubit from the context.
  static DarkCubit get(context) => BlocProvider.of(context);

  // A boolean variable to hold the current state of dark mode.
  bool isDark = false;

  // Function to toggle the app mode between light and dark.
  void changeAppMode({bool? isShared}) {
    if (isShared != null) {
      // If the mode is shared (from another source), update the state and emit the change.
      isDark = isShared;
      emit(DarkcChangeState());
    } else {
      // If the mode is not shared, toggle it and update the local storage.
      isDark = !isDark;
      // Update local storage with the new mode and emit the change.
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(DarkcChangeState());
      });
    }
  }
}

//==========================================================================================================================================================
