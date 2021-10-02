import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size(
                50,
                double
                    .infinity) // double.infinity is the width and 30 is the height
            ),
        onPressed: () {
          print('asd');
        },
        child: Text(
          title,
          style: const TextStyle(fontFamily: 'OpenSans'),
        ));
  }
}
