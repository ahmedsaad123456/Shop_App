import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/register_model.dart';
import 'package:shop/modules/register/cubit/register_states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
//================================================================================================================================

// A Cubit responsible for handling registration-related states and operations
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  RegisterModel? registerModel; // The model to hold registration data

  // Static method to easily access the RegisterCubit instance from any context
  static RegisterCubit get(context) => BlocProvider.of(context);

//================================================================================================================================

  // Method to initiate the user registration process
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState()); // Emit loading state

    // Make a POST request to the registration endpoint with provided data
    DioHelper.postData(
      url: REGISTER,
      data: {'email': email, 'password': password, 'name': name, 'phone': phone},
    ).then((value) {
      registerModel = RegisterModel.fromjson(value.data); // Parse response data to model
      emit(RegisterSuccessState(model: registerModel)); // Emit success state
    }).catchError((error) {
      emit(RegisterErrorState(error.toString())); // Emit error state in case of failure
    });
  }

//================================================================================================================================

  // Variables to manage password visibility icon
  IconData passwordIcon = Icons.visibility_outlined;
  bool isClicked = true;

  // Method to toggle password visibility icon
  void changeIcon() {
    isClicked = !isClicked; // Toggle visibility flag
    // Update icon based on visibility flag
    passwordIcon =
        isClicked ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState()); // Emit state change
  }

//================================================================================================================================

}

//================================================================================================================================
