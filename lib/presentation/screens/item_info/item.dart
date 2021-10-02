import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_ordering_app/global/global_style.dart';
import 'package:menu_ordering_app/logic/cubit/cart_count_cubit.dart';
import 'package:menu_ordering_app/logic/cubit/item_info_cubit.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/presentation/screens/cart.dart';
import 'package:menu_ordering_app/presentation/widgets/custom_button.dart';
import 'package:menu_ordering_app/presentation/widgets/global.dart';

class ItemView extends StatefulWidget {
  const ItemView({
    Key? key,
    required this.product,
    required this.image,
  }) : super(key: key);

  final Product product;
  final String image;

  //static Map<Product, int> myCart = Cart.myCart;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  //1 by default
  static int _quantity = 1;
  static bool _alreadyOnCart = false;
  int? _quantity2 = 0;

  @override
  void initState() {
    super.initState();
    _quantity = 1;

    Cart.myCart.containsKey(widget.product)
        ? _alreadyOnCart = true
        : _alreadyOnCart = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_quantity <= 1) {
                          } else {
                            _quantity -= 1;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle_rounded,
                        color: Colors.pink,
                      ),
                    ),
                    Text(_quantity.toString(),
                        style: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                        )),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity += 1;
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.pink,
                      ),
                    )
                  ],
                ),
              ),
              BlocProvider(
                create: (_) => CartCountCubit(),
                child: BlocBuilder<CartCountCubit, CartCountState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size(50, double.infinity)),
                        onPressed: () {
                          setState(() {
                            Cart.checkExist(widget.product)
                                ? Cart.myCart.update(
                                    widget.product,
                                    (value) => value +=
                                        Cart.myCart[widget.product] = _quantity)
                                : Cart.myCart[widget.product] = _quantity;
                            _quantity2 = Cart.myCart[widget.product];
                          });

                          //update bloc
                          BlocProvider.of<CartCountCubit>(context)
                              .addCartCount(1);
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 2),
                            content:
                                Text(widget.product.name + ' added to cart!'),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text(
                          'Add to cart',
                          style: montRegular,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              child: BlocConsumer<ItemInfoCubit, ItemInfoState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(widget.image),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: contentPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.productName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border_rounded,
                                      color: Colors.pink,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '₱' + state.productPrice.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
