import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home_cubit/home_states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';


//================================================================================================================================


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});


//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) {
            return ListView.separated(
            itemBuilder: (context, index) => buildFavoritesItem(HomeCubit.get(context).favoritesModel!.data!.data![index] , context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: HomeCubit.get(context).favoritesModel!.data!.data!.length,
          );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

//================================================================================================================================


  Widget buildFavoritesItem(FavoritesData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product!.image ??
                      'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg'))
                ),
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
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              HomeCubit.get(context).favorites[model.product!.id]== true? defaultColor : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
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

