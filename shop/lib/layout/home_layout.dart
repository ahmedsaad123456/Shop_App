import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/components/components.dart';

//================================================================================================================================

// Define a StatelessWidget for the shop layout
class ShopLayout extends StatelessWidget {
  // Constructor for the ShopLayout widget
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {

    // Use BlocConsumer to listen to changes in HomeCubit state
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {},
      // Builder function to build the UI based on the HomeCubit state
      builder: (context, state) {
        // Obtain an instance of HomeCubit
        var cubit = HomeCubit.get(context);
        // Return a Scaffold widget for the overall layout
        return Scaffold(
          appBar: AppBar(
            // AppBar with title 'Salla'
            title: const Text(
              'Salla',
            ),
            // Action buttons in the app bar, currently only a search icon
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigate to the search screen when the search icon is pressed
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          // Body of the scaffold, currently displaying the screen based on currentIndex
          body: cubit.bottomScreens[cubit.currentIndex],
          // Bottom navigation bar for navigating between screens
          bottomNavigationBar: BottomNavigationBar(
            // Function to handle navigation bar item taps
            onTap: (value) {
              // Change the screen based on the tapped item
              cubit.changeScreen(value);
            },
            // Define navigation bar items: Home, Categories, Favorites, Settings
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            // Set the current index of the navigation bar based on currentIndex in HomeCubit
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
//================================================================================================================================
