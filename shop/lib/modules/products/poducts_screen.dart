import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';
//================================================================================================================================

// StatelessWidget representing the Products screen
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {
        // Listen for changes in favorite status and display appropriate message
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            messageScreen(
              message: state.model.message,
              state: ToastStates.ERROR,
            );
          } else {
            messageScreen(
              message: state.model.message,
              state: ToastStates.SUCCESS,
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          builder: (context) => builderWidget(
              HomeCubit.get(context).homeModel,
              HomeCubit.get(context).categoriesModel,
              context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

//================================================================================================================================

  // Widget to build the products screen layout
  Widget builderWidget(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel slider for banners
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg')),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories section title
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // List of categories
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoriesItems(
                          categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // New products section title
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // Grid view of products
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        gridViewProduct(model.data!.products[index], context)),
              ),
            ),
          ],
        ),
      );

//================================================================================================================================

  // Widget to build category items
  Widget buildCategoriesItems(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image ??
                'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
            errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg')),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(.8),
            child: Text(
              model.name ?? 'Category',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );

//================================================================================================================================

  // Widget to build product items for the grid view
  Widget gridViewProduct(ProductModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image ??
                    'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg')),
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  model.name ?? 'Product',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    // Product price
                    Text(
                      '${model.price.round()} \$',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // Product old price if discounted
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} \$',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[300],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    // Favorite icon
                    IconButton(
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            HomeCubit.get(context).favorites[model.id] == true
                                ? defaultColor
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        HomeCubit.get(context).changeFavoritesData(model.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//================================================================================================================================

}


//================================================================================================================================
