import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';


//================================================================================================================================

// Screen to display favorite products
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      // Listener to respond to state changes
      listener: (context, state) {},
      // Builder to build the UI based on the current state
      builder: (context, state) {
        return ConditionalBuilder(
          // Check if the state is not loading favorites
          condition: state is! ShopLoadingGetFavoritesState,
          // Builder for when favorites are loaded
          builder: (context) {
            return ListView.separated(
              // Build each favorite item
              itemBuilder: (context, index) => buildFavoritesItem(HomeCubit.get(context).favoritesModel!.data!.data![index], context),
              // Separator between each favorite item
              separatorBuilder: (context, index) => myDivider(),
              // Total number of favorite items
              itemCount: HomeCubit.get(context).favoritesModel!.data!.data!.length,
            );
          },
          // Placeholder widget shown while loading favorites
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

//================================================================================================================================

  // Widget to build a single favorite item
  Widget buildFavoritesItem(FavoritesData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image of the favorite product
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                // Display the image if available, otherwise display a default image
                image: NetworkImage(model.product!.image ??
                    'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
                // Display a placeholder image if an error occurs while loading the image
                errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg'))
              ),
              // Display a discount label if the product has a discount
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Text(
                    'Discount',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of the favorite product
                Text(
                  model.product!.name ?? 'Product',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    // Price of the favorite product
                    Text(
                      '${model.product!.price.round()} \$',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // Old price with strikethrough if there's a discount
                    if (model.product!.discount != 0)
                      Text(
                        '${model.product!.oldPrice.round()} \$',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[300],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    // Favorite button
                    IconButton(
                      icon: CircleAvatar(
                        radius: 15.0,
                        // Change color based on whether the product is in favorites or not
                        backgroundColor:
                            HomeCubit.get(context).favorites[model.product!.id] == true ? defaultColor : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Toggle favorite status of the product
                        HomeCubit.get(context).changeFavoritesData(model.product!.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );

//================================================================================================================================

}

//================================================================================================================================
