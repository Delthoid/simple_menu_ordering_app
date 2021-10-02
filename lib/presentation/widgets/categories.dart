import 'package:flutter/material.dart';
import 'package:menu_ordering_app/global/global_style.dart';
import 'package:menu_ordering_app/global/global_widgets.dart';
import 'package:menu_ordering_app/presentation/screens/category_items.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.pink,
      child: Text(category),
    );
  }
}

class FoodCatergory extends StatelessWidget {
  const FoodCatergory({
    Key? key,
    required this.category,
    required this.color,
    required this.image,
  }) : super(key: key);

  final String category;
  final Color color;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 150,
        width: 150,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [smoothBoxShadow],
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryItems(category: category))),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.pink.withOpacity(0.3),
                      Colors.pink.withOpacity(0.1),
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShopCategory extends StatelessWidget {
  const ShopCategory({
    Key? key,
    required this.category,
    required this.color,
    required this.image,
  }) : super(key: key);

  final String category;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 150,
        width: 150,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryItems(category: category))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(category),
          ),
        ),
      ),
    );
  }
}
