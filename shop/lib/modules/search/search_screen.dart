//================================================================================================================================

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_cubit/home_cubit.dart';
import 'package:shop/layout/home_cubit/home_states.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

//================================================================================================================================
// This screen allows users to search for products

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = HomeCubit.get(context).searchModel;
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    onSubmit: (value) {
                      if (formKey.currentState!.validate()) {
                        HomeCubit.get(context).searchProducts(text: value);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10.0,),
                if (state is ShopLoadingSearchState) const LinearProgressIndicator(),
                Expanded(child: searchBuilder(list, context, isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }

//================================================================================================================================

  // Widget to build the search results
  Widget searchBuilder(SearchModel? list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list?.data?.products.isNotEmpty ?? false,
    builder: (context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildSearchItem(list?.data!.products[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list?.data!.products.length ?? 0, 
    ),
    fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()),
  );

//================================================================================================================================

  // Widget to build a single search item
  Widget buildSearchItem(ProductData? product, context) {
    return Padding(
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
                  image: NetworkImage(product!.image ??
                      'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg'))
                ),
              ],
            ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'Product',
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
                        '${product.price.round()} \$',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      const Spacer(),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: HomeCubit.get(context).favorites[product.id] == true ? defaultColor : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          HomeCubit.get(context).changeFavoritesData(product.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//================================================================================================================================
}

//================================================================================================================================
