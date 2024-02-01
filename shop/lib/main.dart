//==========================================================================================================================================================
// This file contains the main entry point of the application, where the app is initialized and configured.

import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart'; 
import 'package:shop/layout/home_layout.dart'; 
import 'package:shop/modules/login/login_screen.dart'; 
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/bloc_observer.dart'; 
import 'package:shop/shared/components/constants.dart'; 
import 'package:shop/shared/cubit/cubit.dart'; 
import 'package:shop/shared/cubit/states.dart'; 
import 'package:shop/shared/network/local/cache_helper.dart'; 
import 'package:shop/shared/network/remote/dio_helper.dart'; 
import 'package:shop/shared/styles/themes.dart'; 

//==========================================================================================================================================================

void main() async {
  // Ensure that everything in this method is finished before opening the app.
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter bindings are initialized.
  Bloc.observer = MyBlocObserver(); // Set custom BlocObserver for observing bloc state changes.
  await CacheHelper.init(); // Initialize CacheHelper for managing local caching.
  DioHelper.init(); // Initialize DioHelper for making network requests.

  bool? isDark = CacheHelper.getData(key: 'isDark'); // Retrieve dark mode preference from cache.

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding'); // Check if onboarding is completed.
  token = CacheHelper.getData(key: 'token'); // Retrieve user token from cache.

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout(); // Navigate to the main app layout if the user is logged in.
    } else {
      widget = LoginScreen(); // Navigate to the login screen if the user is not logged in.
    }
  } else {
    widget = const OnBoardingScreen(); // Navigate to the onboarding screen if onboarding is not completed.
  }

  runApp(MyApp(
    isDark ?? false, // Pass the dark mode preference to MyApp.
    widget,
  ));
}

//==========================================================================================================================================================

// MyApp class represents the root of the application.
class MyApp extends StatelessWidget {
  final bool isDark; // Represents the current dark mode preference.
  final Widget startWidget; // Represents the starting widget of the application.

  // MyApp constructor.
  const MyApp(this.isDark, this.startWidget, {super.key});

  // This method builds the root widget of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (buildcontext) =>
              DarkCubit()..changeAppMode(isShared: isDark), // Create DarkCubit instance and set the initial dark mode state.
        ),
        BlocProvider(
            create: (buildcontext) => HomeCubit() // Create HomeCubit instance for managing home-related state.
              ..getHomeData() // Fetch home data.
              ..getCategoriesData() // Fetch categories data.
              ..getFavorites() // Fetch favorite products.
              ..getProfile()) // Fetch user profile data.
      ],
      child: BlocConsumer<DarkCubit, DarkStates>(
          listener: (context, state) {}, // Empty listener as no state changes are handled here.
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // Disable debug banner.
              theme: lightTheme, // Set light theme.
              darkTheme: darkTheme, // Set dark theme.
              themeMode: DarkCubit.get(context).isDark
                  ? ThemeMode.dark // Set theme mode based on dark mode state.
                  : ThemeMode.light,
              home: startWidget, // Set the starting widget of the application.
            );
          }),
    );
  }
}

//==========================================================================================================================================================
