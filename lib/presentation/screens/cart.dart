import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:menu_ordering_app/global/global_padding.dart';
import 'package:menu_ordering_app/global/global_style.dart';
import 'package:menu_ordering_app/model/products_model.dart';
import 'package:menu_ordering_app/model/voucher_model.dart';
import 'package:menu_ordering_app/model/vouchers.dart';
import 'package:menu_ordering_app/presentation/screens/checkout.dart';
import 'package:menu_ordering_app/presentation/widgets/custom_button.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  static Map<Product, int> myCart = {};
  static double deliveryFee = 0.0;
  static double subTotal = 0.0;
  static double total = 0.0;
  static var _imagePath = '';
  static Voucher selectedVoucher = Voucher(
    voucherName: '',
    vourcherValue: 0,
  );

  static bool checkExist(Product key) {
    return myCart.containsKey(key);
  }

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    Cart.myCart.isEmpty ? Cart.deliveryFee = 0.0 : Cart.deliveryFee = 35.0;

    List<Widget> getVouchers(List<Voucher> vouchers) {
      List<Widget> result = [];

      for (var element in vouchers) {
        {
          result.add(ListTile(
            title: Text(element.voucherName),
            trailing: Text(element.vourcherValue.toString() + '% OFF'),
            onTap: () {
              setState(() {
                Cart.selectedVoucher = element;
                Navigator.pop(context);
              });
            },
          ));
        }
      }

      return result;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.pink,
        backgroundColor: Colors.grey[50],
        title: const Text('My Cart'),
      ),
      bottomNavigationBar: Cart.myCart.isEmpty
          ? Container(
              height: 0,
            )
          : BottomAppBar(
              elevation: 5,
              child: SizedBox(
                height: 200,
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
                            '₱' + calculateSubtotal(Cart.myCart).toString(),
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
                            '₱' + Cart.deliveryFee.toString(),
                            style: montRegular,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Select Voucher'),
                              content: SingleChildScrollView(
                                child: SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: ListView(
                                      shrinkWrap: true,
                                      children: getVouchers(Vouchers.vouchers)),
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Cart.selectedVoucher = Voucher(
                                          voucherName: '', vourcherValue: 0);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text("Don't use voucher"),
                                )
                              ],
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(Icons.receipt, color: Colors.pink),
                                  Container(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Apply Voucher',
                                    style: montRegularPinkBold,
                                  ),
                                ],
                              ),
                            ),
                            Cart.selectedVoucher.voucherName == ''
                                ? const Text('')
                                : Chip(
                                    backgroundColor: Colors.pink,
                                    label: Text(
                                      Cart.selectedVoucher.voucherName +
                                          ' ' +
                                          Cart.selectedVoucher.vourcherValue
                                              .toString()
                                              .replaceAll('.0', '') +
                                          '% OFF',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Total',
                              style: montMediumBold,
                            ),
                          ),
                          Cart.selectedVoucher.voucherName == ''
                              ? Text(
                                  '₱' +
                                      calculateTotal(
                                        calculateSubtotal(Cart.myCart),
                                        Cart.deliveryFee,
                                        0.0,
                                      ).toString(),
                                  style: montMediumBold,
                                )
                              : Row(
                                  children: [
                                    Text(
                                      '₱' +
                                          calculateTotal(
                                            calculateSubtotal(Cart.myCart),
                                            Cart.deliveryFee,
                                            0.0,
                                          ).toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      '₱' +
                                          calculateTotal(
                                            calculateSubtotal(Cart.myCart),
                                            Cart.deliveryFee,
                                            Cart.selectedVoucher.vourcherValue,
                                          ).toString(),
                                      style: montMediumBold,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOutPage(
                                checkOutList: Cart.myCart,
                                subtotal: calculateSubtotal(Cart.myCart),
                                deliveryFee: Cart.deliveryFee,
                                total: calculateTotal(
                                    calculateSubtotal(Cart.myCart),
                                    Cart.deliveryFee,
                                    Cart.selectedVoucher.vourcherValue),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Payment',
                          style: montRegular,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      body: Cart.myCart.isEmpty
          ? const NoItems()
          : ListView.builder(
              itemCount: Cart.myCart.length,
              itemBuilder: (context, index) {
                if (Cart.myCart.keys.elementAt(index).category == "Burgers") {
                  Cart._imagePath = "assets/images/burgers/";
                } else if (Cart.myCart.keys.elementAt(index).category ==
                    "Beverages") {
                  Cart._imagePath = "assets/images/beverages/";
                } else if (Cart.myCart.keys.elementAt(index).category ==
                    "Combo Meals") {
                  Cart._imagePath = "assets/images/combomeals/";
                }

                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      Cart.myCart.remove(Cart.myCart.keys.elementAt(index));
                    });
                  },
                  background: Container(
                    color: Colors.pink[600],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(Cart._imagePath +
                                      Cart.myCart.keys.elementAt(index).image),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                          Flexible(
                              child: Text(
                            Cart.myCart.keys.elementAt(index).name,
                            style: montRegular,
                          )),
                        ],
                      ),
                      leading: SizedBox(
                        width: 35,
                        height: 35,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, bottom: 10),
                            border: const OutlineInputBorder(),
                            hintText:
                                Cart.myCart.values.elementAt(index).toString(),
                          ),
                        ),
                      ),
                      trailing: Text(
                        '₱ ' +
                            Cart.myCart.keys.elementAt(index).price.toString(),
                        style: const TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class NoItems extends StatelessWidget {
  const NoItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/storysets/pana.png',
            width: MediaQuery.of(context).size.width / 1.5,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          const Text("It's lonely here 😞, order something 😀🍔"),
        ],
      ),
    );
  }
}

calculateSubtotal(Map<Product, int> cartContents) {
  double _subTotal = 0.0;

  cartContents.forEach((key, value) {
    _subTotal +=
        (double.parse(key.price.toString()) * double.parse(value.toString()));
  });

  return _subTotal;
}

calculateTotal(
  double subtotal,
  double deliveryFee,
  double voucher,
) {
  double _total = subtotal + deliveryFee;
  double _discount = voucher / 100;
  return _total - (_total * _discount);
}
