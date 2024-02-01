import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/login/cubit/login_states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

//================================================================================================================================

// Cubit responsible for handling login-related states and logic
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  // Model to hold login data
  LoginModel? loginModel;

  // Static method to easily access LoginCubit instance
  static LoginCubit get(context) => BlocProvider.of(context);

//================================================================================================================================

  // Function to handle user login
  void userLogin({
    required String email,
    required String password,
  }) {
    // Emit loading state
    emit(LoginLoadingState());

    // Make API call to login endpoint
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      // Parse login response and update loginModel
      loginModel = LoginModel.fromjson(value.data);
      // Emit success state with loginModel data
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      // Emit error state with error message
      emit(LoginErrorState(error.toString()));
    });
  }

//================================================================================================================================

  // Icon data for password visibility
  IconData passwordIcon = Icons.visibility_outlined;
  bool isClicked = true;

  // Function to toggle password visibility
  void changeIcon() {
    // Toggle isClicked and update passwordIcon accordingly
    isClicked = !isClicked;
    passwordIcon =
        isClicked ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    // Emit state change to notify UI
    emit(ChangePasswordVisibilityState());
  }

//================================================================================================================================

}

//================================================================================================================================

