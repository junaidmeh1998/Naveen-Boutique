// import 'package:flutter/material.dart';
//
// class PaymentDetail extends StatefulWidget {
//   const PaymentDetail({super.key});
//
//   @override
//   State<PaymentDetail> createState() => _PaymentDetailState();
// }
//
// class _PaymentDetailState extends State<PaymentDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [Container(child: Image.asset('assets/easypesalogo.png'))],
//         ),
//       ),
//     );
//   }
// }
//
// //  deletcart();
// //                   popupScreen(context);
// //                   popupScreen(context);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenboutique/Constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/cart_services.dart';
import '../../Widgets/bankdetail_container.dart';
import '../../Widgets/button.dart';
import '../../Widgets/paymentdetail_container.dart';
import '../../main.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen({Key? key}) : super(key: key);

  @override
  _PaymentscrenWidgetState createState() => _PaymentscrenWidgetState();
}

class _PaymentscrenWidgetState extends State<PaymentDetailScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool orderPlacing = false;
  bool storeddata = true;
  bool onlinePayment = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xffD9D9D9),
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            text: 'Payment ',
            style: GoogleFonts.playfairDisplay(
                fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'Screen',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff83b941),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 7, 10, 3),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Note:',
                              style: GoogleFonts.lato(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Your Order will be shipped after confirmation of payment.Please send screen Shot of your payment and your order number on the below mentioned number',
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Whatsapp Number:  034776227740',
                                style: GoogleFonts.lato(
                                    color: buttonColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                PaymentDetailContainer(
                    image_path: 'assets/easypesalogo.png', ontap: () {}),
                PaymentDetailContainer(
                  image_path: 'assets/jazzcashlogo.png',
                  ontap: () {},
                ),
                BankDetailContianer(
                    ontap: () {}, image_path: 'assets/banklogo.png'),

                // screen shot sending detail
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                  child: Column(
                    children: [
                      Button(
                          text:
                              orderPlacing ? 'Placing Order...' : 'Place Order',
                          ontap: () {
                            allInOne();
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
