import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:menu_ordering_app/db/products_db.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/presentation/screens/cart.dart';
import 'package:menu_ordering_app/presentation/widgets/product_card.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key, required this.category}) : super(key: key);

  final String category;

  static List testProduct = [
    'Jollibee Yum Burger',
    'McDo Burger',
    'Burger King Burger',
    'Angels Burger',
    'Devils Burger',
  ];

  static List<double> testPrice = [150.0, 125.0, 179.0, 50.0, 45.0];

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.pink,
        elevation: 0,
        title: Text(widget.category),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            sliver: SliverToBoxAdapter(
              child: CategoryCard(
                category: widget.category,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            sliver: SliverToBoxAdapter(
              child: Text('Here our best ones'),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            sliver: SliverToBoxAdapter(
              child: LoadItems(category: widget.category),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadItems extends StatefulWidget {
  const LoadItems({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  _LoadItemsState createState() => _LoadItemsState();
}

class _LoadItemsState extends State<LoadItems> {
  late Future<bool> readProducts;
  late List<Product> _productList;

  Future<bool> loadProducts() async {
    _productList =
        await ProductsDatabase.instance.readByCategory(widget.category);
    return true;
  }

  @override
  void initState() {
    readProducts = loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1 / 1.5,
            ),
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: _productList.elementAt(index),
              );
            },
          );
        } else {
          return const Center(
            child: Text('data is loading'),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  final String category;
  static var image = '';

  @override
  Widget build(BuildContext context) {
    if (category == 'Burgers') {
      image = 'assets/images/burger_home.png';
    } else if (category == 'Beverages') {
      image = 'assets/images/beverage_home.png';
    } else if (category == 'Combo Meals') {
      image = 'assets/images/combo_meals_home.png';
    } else {
      image = 'assets/images/burger3.jpg';
    }

    return Container(
      height: 150,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
