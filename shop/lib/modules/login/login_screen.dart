import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/login/cubit/login_cubit.dart';
import 'package:shop/modules/login/cubit/login_states.dart';
import 'package:shop/modules/register/register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

//================================================================================================================================

// Screen for user login
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  
  // Controllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // GlobalKey for form validation
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide LoginCubit to the widget tree
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        // Listener to respond to state changes
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel!.status == true) {
              // Save token to local storage
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel!.data!.token,
              ).then((value) {
                // Update token and fetch data on successful login
                token = state.loginModel!.data!.token;
                HomeCubit.get(context).getHomeData();
                HomeCubit.get(context).getCategoriesData();
                HomeCubit.get(context).getFavorites();
                HomeCubit.get(context).getProfile();
                // Navigate to home layout after successful login
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
              });
              // Show success message
              messageScreen(
                  message: state.loginModel!.message, state: ToastStates.SUCCESS);
            } else {
              // Show error message if login fails
              messageScreen(
                  message: state.loginModel!.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
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
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        // Text form field for email
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
                        // Text form field for password
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
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              // Trigger login action on submit
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          prefix: Icons.lock_outlined,
                          suffix: LoginCubit.get(context).passwordIcon,
                          suffixPressed: () {
                            LoginCubit.get(context).changeIcon();
                          },
                          isPassword: LoginCubit.get(context).isClicked,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        // Conditional builder for login button
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  // Trigger login action on button press
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'LOGIN',
                              isUpperCase: true),
                          // Show loading indicator while logging in
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // Text to navigate to register screen
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account? '),
                            defaultTextButton(
                                fun: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'Register now')
                          ],
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

