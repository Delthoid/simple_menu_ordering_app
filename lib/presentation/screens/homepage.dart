import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:menu_ordering_app/db/products_db.dart';
import 'package:menu_ordering_app/global/global_padding.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/presentation/screens/cart.dart';
import 'package:menu_ordering_app/presentation/widgets/categories.dart';
import 'package:menu_ordering_app/presentation/widgets/product_card.dart';
import 'package:menu_ordering_app/presentation/widgets/searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  static int _cartCount = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<bool> readProducts;
  late List<Product> productsList;
  bool isLoading = false;

  Future<bool> refreshProducts() async {
    //setState(() => isLoading = true);
    productsList = await ProductsDatabase.instance.readAll();
    // setState(() => isLoading = false);
    return true;
  }

  @override
  void initState() {
    readProducts = refreshProducts();
    print('db opened');
    super.initState();
  }

  @override
  void dispose() {
    ProductsDatabase.instance.close();
    print('db closed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      HomePage._cartCount = Cart.myCart.length;
      print(HomePage._cartCount);
    });
    readProducts = refreshProducts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.pink,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deliver to: ',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      //THIS ISN'T WORKING WELL SORRY
                      child: Container(
                        width: 20,
                        height: 20,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.pink),
                        child: Text(
                          HomePage._cartCount.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SearchBar(placeHolder: 'something'),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Categories'),
          ),
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              FoodCatergory(
                category: 'Burgers',
                color: Colors.yellow,
                image: 'assets/images/burger_home.png',
              ),
              Padding(
                padding: topBottomPadding,
                child: FoodCatergory(
                  category: 'Beverages',
                  color: Colors.orange,
                  image: 'assets/images/beverage_home.png',
                ),
              ),
              Padding(
                padding: topBottomPadding,
                child: FoodCatergory(
                  category: 'Combo Meals',
                  color: Colors.red,
                  image: 'assets/images/combomeal.jpg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
