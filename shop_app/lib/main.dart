import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

//==========================================================================================================================================================

void main() async {
  // sure that the every thing in this method was finished then open the app
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    isDark ?? false,
    widget,
  ));
}

//==========================================================================================================================================================

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  const MyApp(this.isDark, this.startWidget, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (buildcontext) =>
              DarkCubit()..changeAppMode(isShared: isDark),
        ),
        BlocProvider(
            create: (buildcontext) => HomeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()
              ..getProfile())
      ],
      child: BlocConsumer<DarkCubit, DarkStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: DarkCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}

//==========================================================================================================================================================

