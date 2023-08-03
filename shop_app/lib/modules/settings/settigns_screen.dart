import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home_cubit/home_states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

//================================================================================================================================


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
        listener: (context, state) {
      if (state is ShopSuccessUpdateProfileState) {
        if (state.model!.status == true) {
          messageScreen(
              message: state.model!.message, state: ToastStates.SUCCESS);
        } else {
          messageScreen(
              message: state.model!.message, state: ToastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      
      nameController.text = HomeCubit.get(context).userModel?.data?.name ?? '';
      emailController.text = HomeCubit.get(context).userModel?.data?.email ?? '';
      phoneController.text = HomeCubit.get(context).userModel?.data?.phone ?? '';
      return ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null,
          builder: (context) =>
              buildProfile(context, HomeCubit.get(context).userModel!.data, state),
          fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
    });
  }
//================================================================================================================================

  Widget buildProfile(context, UserDataModel? model, state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if(state is ShopLoadingUpdateProfileState)
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
                prefix: Icons.person),
            const SizedBox(
              height: 20.0,
            ),
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
                prefix: Icons.email_outlined),
            const SizedBox(
              height: 20.0,
            ),
            defaultFormField(
                controller: phoneController,
                type: TextInputType.phone,
                label: 'Phone',
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'phone must not be empty';
                  }
                  return null;
                },
                prefix: Icons.phone),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    HomeCubit.get(context).updateProfile(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
                  }
                },
                text: 'UPDATE'),
            const SizedBox(
              height: 20.0,
            ),
            defaultButton(
                function: () {
                  signOut(context);
                },
                text: 'LOGOUT'),
          ],
        ),
      ),
    );
  }

//================================================================================================================================

}

//================================================================================================================================

