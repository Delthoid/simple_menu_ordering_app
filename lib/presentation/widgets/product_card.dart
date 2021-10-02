import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_ordering_app/logic/cubit/item_info_cubit.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/presentation/screens/item_info/item.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  static var imagePath = '';

  @override
  Widget build(BuildContext context) {
    print(product.category);
    if (product.category == "Burgers") {
      imagePath = "assets/images/burgers/";
    } else if (product.category == "Beverages") {
      imagePath = "assets/images/beverages/";
    } else if (product.category == "Combo Meals") {
      imagePath = "assets/images/combomeals/";
    }

    return BlocProvider(
      create: (_) => ItemInfoCubit(),
      child: Builder(builder: (context) {
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {
              BlocProvider.of<ItemInfoCubit>(context).setItem(
                product.name,
                double.parse(product.price.toString()),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ItemInfoCubit>(context),
                    child: ItemView(
                      product: product,
                      image: imagePath + product.image,
                    ),
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          imagePath + product.image,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '₱' + product.price.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
