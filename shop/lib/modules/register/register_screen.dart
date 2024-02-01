import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/register/cubit/register_cubit.dart';
import 'package:shop/modules/register/cubit/register_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
//================================================================================================================================

// StatelessWidget representing the Register screen
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        // Listen for registration success or failure and display appropriate message
        if (state is RegisterSuccessState) {
          if (state.model!.status == true) {
            CacheHelper.saveData(
              key: 'token',
              value: state.model!.data!.token,
            ).then((value) {
              token = state.model!.data!.token;
              HomeCubit.get(context).getHomeData();
              HomeCubit.get(context).getCategoriesData();
              HomeCubit.get(context).getFavorites();
              HomeCubit.get(context).getProfile();
              navigateAndFinish(
                context,
                const ShopLayout(),
              );
            });

            messageScreen(
                message: state.model!.message, state: ToastStates.SUCCESS);
          } else {
            messageScreen(
                message: state.model!.message, state: ToastStates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Register title
                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                            ),
                      ),
                      // Subtitle
                      Text(
                        'Register now to browse our hot offers',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // Name field
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          prefix: Icons.person),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Email field
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Password field
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        prefix: Icons.lock_outlined,
                        suffix: RegisterCubit.get(context).passwordIcon,
                        suffixPressed: () {
                          RegisterCubit.get(context).changeIcon();
                        },
                        isPassword: RegisterCubit.get(context).isClicked,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Phone field
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // Register button
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                            isUpperCase: true),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

//================================================================================================================================
