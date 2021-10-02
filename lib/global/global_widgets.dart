import 'package:flutter/material.dart';

BoxShadow smoothBoxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.06),
  spreadRadius: 0,
  blurRadius: 5,

  offset: const Offset(0, 4), // changes position of shadow
  // changes position of shadow
);

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.cardContentsCol,
  }) : super(key: key);

  final Widget cardContentsCol;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [smoothBoxShadow],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: cardContentsCol,
      ),
    );
  }
}
