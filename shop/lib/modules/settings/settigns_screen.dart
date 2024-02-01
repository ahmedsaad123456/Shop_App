//================================================================================================================================

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';

//================================================================================================================================

// This screen allows users to view and update their profile settings

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  // Controllers for handling user input
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  
  // GlobalKey for managing the form state
  final formKey = GlobalKey<FormState>();

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {
        // Listen to state changes, such as profile update success or failure
        if (state is ShopSuccessUpdateProfileState) {
          if (state.model!.status == true) {
            // Show success message if profile update is successful
            messageScreen(message: state.model!.message, state: ToastStates.SUCCESS);
          } else {
            // Show error message if profile update fails
            messageScreen(message: state.model!.message, state: ToastStates.ERROR);
          }
        }
      }, 
      builder: (context, state) {
        // Initialize controller values with user data
        nameController.text = HomeCubit.get(context).userModel?.data?.name ?? '';
        emailController.text = HomeCubit.get(context).userModel?.data?.email ?? '';
        phoneController.text = HomeCubit.get(context).userModel?.data?.phone ?? '';
        
        return ConditionalBuilder(
          // Check if user data is available
          condition: HomeCubit.get(context).userModel != null,
          builder: (context) => buildProfile(context, HomeCubit.get(context).userModel!.data, state),
          // Show loading indicator if user data is not yet available
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          )
        );
      }
    );
  }

//================================================================================================================================

  // Widget to build the user profile settings
  Widget buildProfile(context, UserDataModel? model, state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if (state is ShopLoadingUpdateProfileState)
              // Show loading indicator while updating profile
              const LinearProgressIndicator(),
            const SizedBox(height: 20.0,),
            defaultFormField(
              controller: nameController,
              type: TextInputType.name,
              label: 'Name',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Name must not be empty';
                }
                return null;
              },
              prefix: Icons.person
            ),
            const SizedBox(height: 20.0,),
            defaultFormField(
              controller: emailController,
              type: TextInputType.emailAddress,
              label: 'Email Address',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Email Address must not be empty';
                }
                return null;
              },
              prefix: Icons.email_outlined
            ),
            const SizedBox(height: 20.0,),
            defaultFormField(
              controller: phoneController,
              type: TextInputType.phone,
              label: 'Phone',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Phone must not be empty';
                }
                return null;
              },
              prefix: Icons.phone
            ),
            const SizedBox(height: 20.0,),
            defaultButton(
              function: () {
                // Validate form input and update profile if valid
                if (formKey.currentState!.validate()) {
                  HomeCubit.get(context).updateProfile(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text
                  );
                }
              },
              text: 'UPDATE'
            ),
            const SizedBox(height: 20.0,),
            defaultButton(
              // Call signOut function when logout button is pressed
              function: () {
                signOut(context);
              },
              text: 'LOGOUT'
            ),
          ],
        ),
      ),
    );
  }

//================================================================================================================================
}

//================================================================================================================================
