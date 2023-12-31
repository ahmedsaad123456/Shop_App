
import 'package:shop_app/models/register_model.dart';

//================================================================================================================================


abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

//================================================================================================================================


class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel? model;

  RegisterSuccessState({required this.model});
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

//================================================================================================================================


class ChangePasswordVisibilityState extends RegisterStates {}

//================================================================================================================================

