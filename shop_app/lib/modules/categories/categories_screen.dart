import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_cubit/home_cubit.dart';
import 'package:shop_app/layout/home_cubit/home_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

//================================================================================================================================


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

//================================================================================================================================

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCarItem(
              HomeCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: HomeCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );
  }

//================================================================================================================================


  Widget buildCarItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image ??
                  'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1'),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Image(image: AssetImage('assets/images/image_error.jpeg'))
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name ?? 'Category',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );

//================================================================================================================================

}


//================================================================================================================================

