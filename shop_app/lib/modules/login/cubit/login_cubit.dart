import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

//================================================================================================================================


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  LoginModel? loginModel;

  static LoginCubit get(context) => BlocProvider.of(context);

//================================================================================================================================


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {

    loginModel = LoginModel.fromjson(value.data);

      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
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

