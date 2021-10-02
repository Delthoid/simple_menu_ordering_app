import 'package:flutter/material.dart';
import 'package:menu_ordering_app/global/global_padding.dart';
import 'package:menu_ordering_app/global/global_style.dart';
import 'package:menu_ordering_app/global/global_widgets.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/presentation/screens/cart.dart';
import 'package:menu_ordering_app/presentation/screens/otw.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage(
      {Key? key,
      required this.checkOutList,
      required this.subtotal,
      required this.deliveryFee,
      required this.total})
      : super(key: key);

  final Map<Product, int> checkOutList;
  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  static bool mockPaymentBool = false;
  late Future<bool> waitPayment;

  Future<bool> getPayment() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      mockPaymentBool = true;
    });
    return true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mockPaymentBool = false;
  }

  @override
  void initState() {
    super.initState();
    mockPaymentBool = false;
    //waitPayment = nu;;''
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.pink,
        elevation: 0,
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Subtotal
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Subtotal',
                        style: montRegular,
                      ),
                    ),
                    Text(
                      '₱' + widget.subtotal.toString(),
                      style: montRegular,
                    )
                  ],
                ),
                //Shipping fee
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Delivery fee',
                        style: montRegular,
                      ),
                    ),
                    Text(
                      '₱' + widget.deliveryFee.toString(),
                      style: montRegular,
                    )
                  ],
                ),
                Padding(
                  padding: topBottomPadding,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Total',
                          style: montMediumBold,
                        ),
                      ),
                      Text(
                        '₱' + widget.total.toString(),
                        style: montMediumBold,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //show fake payment dialog
                    waitPayment = getPayment();
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                              title: const Text('Processing Payment'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FutureBuilder(
                                      future: waitPayment,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          mockPaymentBool = true;
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Icons.check_rounded,
                                                color: Colors.pink,
                                              ),
                                              ElevatedButton(
                                                child: const Text(
                                                  'Done',
                                                  style: montRegular,
                                                ),
                                                onPressed: () {
                                                  Cart.myCart.clear();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              const OnTheWay()));
                                                },
                                                style: customButtonStyle,
                                              )
                                            ],
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      })
                                ],
                              ),
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: montRegular,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        children: [
          CustomCard(
            cardContentsCol: Row(
              children: [
                const SizedBox(
                  width: 70,
                  height: 70,
                  child: Icon(
                    Icons.motorcycle,
                    color: Colors.pink,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery time'),
                    const Text(
                      'Thursday, 3:00 PM',
                      style: montMediumBold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Change',
                          style: montRegularPinkBold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: topBottomPadding,
            child: CustomCard(
              cardContentsCol: Row(
                children: [
                  const Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.pink,
                  ),
                  Container(
                    width: 10,
                  ),
                  const Text(
                    'Delivery Address',
                    style: montMediumBold,
                  ),
                ],
              ),
            ),
          ),
          //payment method
          Padding(
            padding: topBottomPadding,
            child: CustomCard(
              cardContentsCol: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.payment_rounded,
                        color: Colors.pink,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text(
                        'Payment Method',
                        style: montMediumBold,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Padding(
                    padding: topBottomPadding,
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          color: Colors.blue[600],
                        ),
                        Container(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'GCash',
                              style: montRegularBold,
                            ),
                            Text(
                              '63-9*******42',
                              style: montRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: topBottomPadding,
            child: CustomCard(
              cardContentsCol: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.receipt_long_rounded,
                        color: Colors.pink,
                      ),
                      Container(
                        width: 10,
                      ),
                      const Text(
                        'Order Summary',
                        style: montMediumBold,
                      ),
                    ],
                  ),
                  Padding(
                    padding: topBottomPadding,
                    child: Container(
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: fetchOrder(widget.checkOutList),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> fetchOrder(Map<Product, int> orders) {
  var _items = <Widget>[];

  orders.forEach((key, value) {
    double _price = key.price * double.parse(value.toString());

    _items.add(Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            value.toString() + 'x',
            style: montRegular,
          ),
        ),
        Expanded(
          child: Text(
            key.name,
            style: montRegular,
          ),
        ),
        Text(
          '₱' + _price.toString(),
          style: montRegular,
        ),
      ],
    ));
  });

  return _items;
}
