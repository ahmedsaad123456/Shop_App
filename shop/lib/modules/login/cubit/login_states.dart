import 'package:shop/models/login_model.dart';

//================================================================================================================================

// Abstract class defining different states for login process
abstract class LoginStates {}

// Initial state indicating login process hasn't started yet
class LoginInitialState extends LoginStates {}

//================================================================================================================================

// State indicating loading status during login process
class LoginLoadingState extends LoginStates {}

// State indicating successful login with associated loginModel data
class LoginSuccessState extends LoginStates {
  final LoginModel? loginModel;

  LoginSuccessState({required this.loginModel});
}

// State indicating login error with associated error message
class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

//================================================================================================================================

// State indicating change in password visibility icon
class ChangePasswordVisibilityState extends LoginStates {}

//================================================================================================================================


