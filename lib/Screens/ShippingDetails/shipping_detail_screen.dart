import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/PaymetDetails/payment_detail_screen.dart';

import '../../Services/cart_services.dart';
import '../../Widgets/shipping_textfield.dart';
import '../../main.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final _formKey = GlobalKey<FormState>();
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

  // String firstName = '';
  // String lastName = '';
  // String address = '';
  // String city = '';
  // String postalCode = '';
  // String phoneNumber = '';
  // String email = '';
  // getUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('signupEmail').toString();
  //
  //   setState(() {
  //     email = prefs.getString('signupEmail').toString();
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   loadSavedData(email);
  // }
  //
  // void loadSavedData(String currentUserEmail) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Check if the stored user email matches the current user's email
  //   String storedUserEmail = prefs.getString(email) ?? '';
  //   if (storedUserEmail == currentUserEmail) {
  //     setState(() {
  //       firstNameEditingController.text = prefs.getString('first_name') ?? '';
  //       lastNameEditingController.text = prefs.getString('last_name') ?? '';
  //       address1EditingController.text = prefs.getString('email') ?? '';
  //       cityEditingController.text = prefs.getString('city') ?? '';
  //       postEditingController.text = prefs.getString('postal_code') ?? '';
  //       phoneNumberEditingController.text =
  //           prefs.getString('phone_number') ?? '';
  //     });
  //   } else {
  //     // If the stored user email doesn't match the current user, don't set any data
  //     // Clear the text controllers or set them to empty strings
  //     setState(() {
  //       firstNameEditingController.text = '';
  //       lastNameEditingController.text = '';
  //       address1EditingController.text = '';
  //       cityEditingController.text = '';
  //       postEditingController.text = '';
  //       phoneNumberEditingController.text = '';
  //     });
  //   }
  // }

  // void loadSavedData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Check if any field is empty in SharedPreferences to prevent overwriting data
  //   if (prefs.getString('first_name') != null &&
  //       prefs.getString('first_name')!.isNotEmpty) {
  //     setState(() {
  //       firstNameEditingController.text = prefs.getString('first_name') ?? '';
  //     });
  //   }
  //   if (prefs.getString('last_name') != null &&
  //       prefs.getString('last_name')!.isNotEmpty) {
  //     setState(() {
  //       lastNameEditingController.text = prefs.getString('last_name') ?? '';
  //     });
  //   }
  //   if (prefs.getString('email') != null &&
  //       prefs.getString('email')!.isNotEmpty) {
  //     setState(() {
  //       address1EditingController.text = prefs.getString('email') ?? '';
  //     });
  //   }
  //   if (prefs.getString('city') != null &&
  //       prefs.getString('city')!.isNotEmpty) {
  //     setState(() {
  //       cityEditingController.text = prefs.getString('city') ?? '';
  //     });
  //   }
  //   if (prefs.getString('postal_code') != null &&
  //       prefs.getString('postal_code')!.isNotEmpty) {
  //     setState(() {
  //       postEditingController.text = prefs.getString('postal_code') ?? '';
  //     });
  //   }
  //   if (prefs.getString('phone_number') != null &&
  //       prefs.getString('phone_number')!.isNotEmpty) {
  //     setState(() {
  //       phoneNumberEditingController.text =
  //           prefs.getString('phone_number') ?? '';
  //     });
  //   }
  // }

  // void loadSavedData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     firstNameEditingController.text = prefs.getString('first_name') ?? '';
  //     lastNameEditingController.text = prefs.getString('last_name') ?? '';
  //     address1EditingController.text = prefs.getString('email') ?? '';
  //     cityEditingController.text = prefs.getString('city') ?? '';
  //     postEditingController.text = prefs.getString('postal_code') ?? '';
  //     phoneNumberEditingController.text = prefs.getString('phone_number') ?? '';
  //   });
  // }

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
        title: const Text(
          "Check Out",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff83b941),
        automaticallyImplyLeading: false,
        elevation: 02,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 80, bottom: 0, left: 20, right: 20),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.68,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Shipping Information",
                                  style: TextStyle(
                                      color: Color(0xff83b941),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                shippingTextField(
                                  controller: firstNameEditingController,
                                  hinttext: 'First Name',
                                  type: TextInputType.name,
                                  validatior: (value) {
                                    RegExp regex = RegExp(r'^.{3,}$');
                                    if (value!.isEmpty) {
                                      return "First name can not be empty";
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return "Enter valid name(Min. 3 Character)";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                shippingTextField(
                                  controller: lastNameEditingController,
                                  hinttext: 'Second Name',
                                  type: TextInputType.name,
                                  validatior: (value) {
                                    RegExp regex = RegExp(r'^.{3,}$');
                                    if (value!.isEmpty) {
                                      return "Second name can not be empty";
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return "Enter valid name(Min. 3 Character)";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                shippingTextField(
                                  controller: address1EditingController,
                                  hinttext: 'Address',
                                  type: TextInputType.name,
                                  validatior: (value) {
                                    RegExp regex =
                                        RegExp(r'^[0-9A-Za-z\s\.,#\-]+$');
                                    if (value!.isEmpty) {
                                      return "address1 can not be empty";
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return "Enter valid address";
                                    }
                                    return null;
                                  },
                                ),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                // shippingTextField(
                                //   controller: cityEditingController,
                                //   hinttext: 'City',
                                //   type: TextInputType.name,
                                //   validatior: (value) {
                                //     if (value!.isEmpty) {
                                //       return "city name can not be empty";
                                //     }
                                //
                                //     return null;
                                //   },
                                // ),
                                const SizedBox(
                                  height: 15,
                                ),
                                shippingTextField(
                                  controller: postEditingController,
                                  hinttext: 'Postal Code',
                                  type: TextInputType.number,
                                  validatior: (value) {
                                    if (value!.isEmpty) {
                                      return "Postal Code can not be empty";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                shippingTextField(
                                  controller: phoneNumberEditingController,
                                  hinttext: 'Phone Number',
                                  type: TextInputType.number,
                                  validatior: (value) {
                                    if (value!.isEmpty) {
                                      return "Phone Number can not be empty";
                                    }
                                    return null;
                                  },
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
                              ],
                            ),
                          )),
                    ))),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: Button(
                text: onlinePayment
                    ? 'Payment Details'
                    : orderPlacing == true
                        ? 'Placing Order.....'
                        : 'Place Order',
                ontap: () async {
                  if (_formKey.currentState!.validate()) {
                    //firstName =
                    firstNameEditingController.text;
                    //lastName =
                    lastNameEditingController.text;
                    //address =
                    address1EditingController.text;
                    //city =
                    cityEditingController.text;
                    // postalCode =
                    postEditingController.text;
                    //phoneNumber =
                    phoneNumberEditingController.text;
                    onlinePayment
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentDetailScreen()),
                          )
                        : allInOne();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
