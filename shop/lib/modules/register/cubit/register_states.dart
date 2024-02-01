
import 'package:shop/models/register_model.dart';
//================================================================================================================================

// Abstract class representing the different states of the registration process
abstract class RegisterStates {}

// Initial state when the registration process starts
class RegisterInitialState extends RegisterStates {}

//================================================================================================================================

// State indicating that the registration process is in progress
class RegisterLoadingState extends RegisterStates {}

// State indicating that the registration process was successful
class RegisterSuccessState extends RegisterStates {
  final RegisterModel? model; // Model containing registration data

  // Constructor to initialize the success state with the registration model
  RegisterSuccessState({required this.model});
}

// State indicating that an error occurred during the registration process
class RegisterErrorState extends RegisterStates {
  final String error; // Error message describing the failure

  // Constructor to initialize the error state with the error message
  RegisterErrorState(this.error);
}

//================================================================================================================================

// State indicating a change in the visibility of the password field
class ChangePasswordVisibilityState extends RegisterStates {}

//================================================================================================================================
