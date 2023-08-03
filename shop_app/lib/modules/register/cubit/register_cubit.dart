import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

//================================================================================================================================


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  RegisterModel? registerModel;

  static RegisterCubit get(context) => BlocProvider.of(context);

//================================================================================================================================


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {'email': email, 'password': password, 'name': name, 'phone': phone},
    ).then((value) {

    registerModel = RegisterModel.fromjson(value.data);

      emit(RegisterSuccessState(model: registerModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

//================================================================================================================================


  IconData passwordIcon = Icons.visibility_outlined;
  bool isClicked = true;

  void changeIcon() {
    isClicked = !isClicked;
    passwordIcon =
        isClicked ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

//================================================================================================================================

}


//================================================================================================================================
