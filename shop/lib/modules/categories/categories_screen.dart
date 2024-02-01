import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/shared/components/components.dart';
//================================================================================================================================

// Screen to display categories
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      // Listener to respond to state changes
      listener: (context, state) {},
      // Builder to build the UI based on the current state
      builder: (context, state) {
        return ListView.separated(
          // Build each category item
          itemBuilder: (context, index) => buildCarItem(
              HomeCubit.get(context).categoriesModel!.data!.data![index]),
          // Separator between each category item
          separatorBuilder: (context, index) => myDivider(),
          // Total number of categories
          itemCount: HomeCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );
  }

//================================================================================================================================

  // Widget to build a single category item
  Widget buildCarItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Category image
            Image(
              // Display the image if available, otherwise display a default image
              image: NetworkImage(model.image ??
                  'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
              // Display a placeholder image if an error occurs while loading the image
              errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg'))
            ),
            const SizedBox(
              width: 20.0,
            ),
            // Category name
            Text(
              model.name ?? 'Category',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Icon to navigate to the category details
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );

//================================================================================================================================

}

//================================================================================================================================
