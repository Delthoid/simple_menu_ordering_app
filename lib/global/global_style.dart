import 'package:flutter/material.dart';

final ButtonStyle customButtonStyle = TextButton.styleFrom(
  minimumSize: const Size(88, 50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);

const TextStyle montRegular = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

const TextStyle montRegularBold = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  fontSize: 14,
);

const TextStyle montRegularPink = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w500,
  color: Colors.pink,
);

const TextStyle montRegularPinkBold = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  color: Colors.pink,
);

const TextStyle montMediumBold = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const TextStyle montMediumBoldPink = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.pink,
);
