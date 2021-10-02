import 'dart:async';

import 'package:flutter/material.dart';
import 'package:menu_ordering_app/global/global_style.dart';
import 'package:menu_ordering_app/presentation/widgets/global.dart';

class OnTheWay extends StatefulWidget {
  const OnTheWay({Key? key}) : super(key: key);

  @override
  _OnTheWayState createState() => _OnTheWayState();
}

class _OnTheWayState extends State<OnTheWay> with TickerProviderStateMixin {
  late AnimationController controller;
  var _image = 'assets/images/storysets/amico.png';
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          controller.value > 0.80
              ? _image = 'assets/images/storysets/delivered.png'
              : _image = 'assets/images/storysets/amico.png';
          controller.value >= 0.990 ? controller.stop() : print('');
        });
      });
    controller.value >= 0.990
        ? controller.stop()
        : controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset(_image),
            ),
            Padding(
              padding: contentPadding,
              child: LinearProgressIndicator(
                value: controller.value,
                backgroundColor: Colors.grey,
              ),
            ),
            controller.value < 0.990
                ? const Text(
                    'Your order is now on the way',
                    style: montRegular,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your order is delivered',
                        style: montRegular,
                      ),
                      ElevatedButton(
                        child: const Text('Done'),
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
