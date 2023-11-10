import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/ShippingDetails/shipping_detail_screen.dart';

import '../../Services/cart_services.dart';
import '../../main.dart';
import '../PaymetDetails/payment_detail_screen.dart';

class ShippingDetailScreen2 extends StatefulWidget {
  const ShippingDetailScreen2({super.key});

  @override
  State<ShippingDetailScreen2> createState() => _ShippingDetailScreen2State();
}

class _ShippingDetailScreen2State extends State<ShippingDetailScreen2> {
  bool orderPlacing = false;
  bool storeddata = true;
  int selectedOption = 0;
  bool onlinePayment = false;

  @override
  void dispose() {
    onlinePayment = false;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allInOne() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await cartprovider.storeShippingDetails(
          firstNameEditingController.text.toString(),
          lastNameEditingController.text.toString(),
          address1EditingController.text.toString(),
          provinceEditingController.text.toString(),
          cityEditingController.text.toString(),
          postEditingController.text.toString(),
          phoneNumberEditingController.text.toString(),
          storeddata);

      final orderData = Order(
        lineitems: lineItems,
        billing: {
          "first_name": prefs.getString('first_name').toString(),
          "last_name": prefs.getString('last_name').toString(),
          "address_1": prefs.getString('email').toString(),
          "city": prefs.getString('city').toString(),
          "state": prefs.getString('province').toString(),
          "postcode": prefs.getString('postal_code').toString(),
          "phone": prefs.getString('phone_number').toString(),
          "email": prefs.getString('signupEmail')
        },
        shipping: {
          "first_name": prefs.getString('first_name').toString(),
          "last_name": prefs.getString('last_name').toString(),
          "address_1": prefs.getString('email').toString(),
          "city": prefs.getString('city').toString(),
          'state': prefs.getString('province').toString(),
          'postcode': prefs.getString('postal_code').toString(),
          'phone': prefs.getString('phone_number').toString(),
          "email": prefs.getString('signupEmail')
        },
        // Other order details
      );
      await CartData();
      setState(() {
        orderPlacing = true;
      });
      await placeOrder(orderData, context).then(
        (value) async {
          setState(() {
            orderPlacing = false;
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Shipping Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality here
                        nextScreenReplace(context, const ShippingAddress());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            buttonColor), // Change color here
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Aligns icon and text
                        children: <Widget>[
                          Icon(Icons.edit), // Icon widget
                          SizedBox(
                              width: 8), // Adding space between icon and text
                          Text('Edit'), // Text widget
                        ],
                      ),
                    ),
                  ]),
                  // InkWell(
                  //   onTap: () {
                  //     nextScreenReplace(context, const ShippingAddress());
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         "Edit",
                  //         style: TextStyle(fontSize: 16),
                  //       ),
                  //       Icon(Icons.edit)
                  //     ],
                  //   ),
                  // ),
                  ShippingDetailViewContainer(
                    text:
                        'First Name: ${snapshot.data?.getString('first_name') ?? ""}',
                  ),
                  ShippingDetailViewContainer(
                    text:
                        'Last Name: ${snapshot.data?.getString('last_name') ?? ""}',
                  ),
                  ShippingDetailViewContainer(
                    text: 'Address: ${snapshot.data?.getString('email') ?? ""}',
                  ),
                  // ShippingDetailViewContainer(
                  //   text: 'City: ${snapshot.data?.getString('city') ?? ""}',
                  // ),
                  ShippingDetailViewContainer(
                    text:
                        'Postal Code: ${snapshot.data?.getString('postal_code') ?? ""}',
                  ),
                  ShippingDetailViewContainer(
                    text:
                        'Phone Number: ${snapshot.data?.getString('phone_number') ?? ""}',
                  ),
                  ListTile(
                    title: const Text('Cash on Delivery'),
                    leading: Radio(
                      activeColor: buttonColor,
                      value: 1,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          onlinePayment = false;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Online Payment'),
                    leading: Radio(
                      activeColor: buttonColor,
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          onlinePayment = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     ElevatedButton(
                  //         onPressed: () {
                  //           nextScreenReplace(context, const ShippingAddress());
                  //         },
                  //         child: const Text('Edit Shipping Details'))
                  //   ],
                  // ),
                  Button(
                    text: orderPlacing ? 'Placing Order....' : 'Place Order',
                    ontap: () async {
                      setState(() {
                        orderPlacing = true;
                      });
                      onlinePayment
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentDetailScreen()),
                            )
                          : allInOne();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ShippingDetailViewContainer extends StatelessWidget {
  ShippingDetailViewContainer({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
