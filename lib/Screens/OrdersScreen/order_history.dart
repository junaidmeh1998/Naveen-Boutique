import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:naveenboutique/Packages/packages.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final String baseURL = 'https://naveenboutique.com/wp-json/wc/v3/orders/';
  final String consumerKey = 'ck_429653af52992037368c9f1153aa82c7e64cf424';
  final String consumerSecret = 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0';
  String? targetEmail = '';
  Future<List<dynamic>> fetchAllOrders() async {
    final response = await http.get(
      Uri.parse(baseURL),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> orders = json.decode(response.body);
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Future<List<dynamic>> fetchOrdersByEmail() async {
    List<dynamic> allOrders = await fetchAllOrders();
    List<dynamic> filteredOrders = [];

    for (var order in allOrders) {
      // Check if the order has a 'billing' section and 'email' field
      if (order.containsKey('billing') &&
          order['billing'].containsKey('email')) {
        String customerEmail = order['billing']['email'];

        if (customerEmail == targetEmail) {
          filteredOrders.add(order);
        }
      }
    }

    return filteredOrders;
  }

  void getTargetEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(sf.getString('signupEmail'));
    }
    setState(() {
      targetEmail = sf.getString('signupEmail');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTargetEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text('Orders'),
        ),
        body: Center(
          child: FutureBuilder<List<dynamic>>(
            future: fetchOrdersByEmail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: buttonColor,
                );
              } else if (snapshot.data!.isEmpty) {
                return const Text('No order has been placed');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<dynamic> orders = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var order = orders[index];
                    //     return ListTile(
                    //       leading: C,
                    //       title: Text('Order ID: ${order['id']}'),
                    //       subtitle: Text('Date Created: ${order['date_created']}'),
                    //     );
                    return InkWell(
                      child: SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 9,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery Details",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Order ID:       ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Flexible(child: Text("${order['id']}"))
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name:           ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Flexible(
                                      child: Text(
                                          "${order['billing']['first_name']} ${order['billing']['last_name']}"),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Address:       ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Flexible(
                                          child: Text(
                                              "${order['shipping']['address_1']}"))
                                    ],
                                  )),

                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Phone:           ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Flexible(
                                          child: Text(
                                              "${order['billing']['phone']}"))
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Total Price:   ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Flexible(child: Text("${order['total']}"))
                                    ],
                                  )),
                              // Padding(
                              //     padding:
                              //         const EdgeInsets.only(left: 20, top: 2),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Flexible(
                              //             child: Text(
                              //           "Email:            ",
                              //           style: TextStyle(
                              //               color: Colors.black,
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold),
                              //         )),
                              //         Flexible(
                              //             child: Text(
                              //                 "${order['billing']['email']}"))
                              //       ],
                              //     )),
                              // ListTile(
                              //   // leading: CircleAvatar(
                              //   //   backgroundColor: buttonColor,
                              //   //   child: Text(
                              //   //     order['billing']['email'].toString()[0],
                              //   //     style: const TextStyle(
                              //   //         color: Colors.black,
                              //   //         fontWeight: FontWeight.bold),
                              //   //   ),
                              //   // ),
                              //   title: Text(
                              //       "Name:${order['billing']['first_name']} ${order['billing']['last_name']}"),
                              //   subtitle:
                              //       Text("Total Price: ${order['total']}"),
                              // ),
                              // // SizedBox(height:2, ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Text("OrderId: ${order['id']}"),
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 1,
                              // ),
                              // Padding(
                              //     padding: const EdgeInsets.only(left: 20),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Flexible(
                              //             child: Text(
                              //                 "Address: ${order['shipping']['address_1']}"))
                              //       ],
                              //     )),
                              // Padding(
                              //     padding: const EdgeInsets.only(left: 20),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Flexible(
                              //             child: Text(
                              //                 "Email:    ${order['billing']['email']}")),
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        nextScreen(
                            context, UserOrderItems(orderId: order['id']));
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserOrderItems extends StatefulWidget {
  const UserOrderItems({Key? key, required this.orderId}) : super(key: key);
  final int orderId;

  @override
  State<UserOrderItems> createState() => _UserOrderItemsState();
}

class _UserOrderItemsState extends State<UserOrderItems> {
  final String baseURL = 'https://naveenboutique.com/wp-json/wc/v3/orders/';
  final String consumerKey = 'ck_429653af52992037368c9f1153aa82c7e64cf424';
  final String consumerSecret = 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0';
  String? targetEmail = '';
  // Replace with the desired email address

  Future<List<dynamic>> fetchAllOrders() async {
    final response = await http.get(
      Uri.parse(baseURL),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> orders = json.decode(response.body);
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Future<List<dynamic>> fetchOrdersByEmail() async {
    List<dynamic> allOrders = await fetchAllOrders();
    List<dynamic> filteredOrders = [];

    for (var order in allOrders) {
      // Check if the order has a 'billing' section and 'email' field
      if (order.containsKey('billing') &&
          order['billing'].containsKey('email')) {
        String customerEmail = order['billing']['email'];

        if (customerEmail == targetEmail) {
          filteredOrders.add(order);
        }
      }
    }

    return filteredOrders;
  }

  Future<List<dynamic>> fetchOrdersById(orderid) async {
    List<dynamic> allOrders = await fetchAllOrders();
    List<dynamic> filteredOrders = [];

    for (var order in allOrders) {
      if (order['id'] == orderid) {
        filteredOrders.add(order);
      }
    }

    return filteredOrders;
  }

  void getTargetEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(sf.getString('signupEmail'));
    }
    setState(() {
      targetEmail = sf.getString('signupEmail');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTargetEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Order ',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'Items',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: fetchOrdersById(widget.orderId),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went wrong ${snapshot.error}"));
            } else if (snapshot.hasData) {
              List<dynamic> orders = snapshot.data ?? [];
              if (orders.isEmpty) {
                return const Center(
                  child: Text("No orders found for the given ID"),
                );
              }
              //final List<dynamic> lineItems = snapshot.data['line_items'];
              var order = orders[
                  0]; // Assuming there's only one order with the given ID

              final List<dynamic> lineItems = order['line_items'];

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lineItems.length,
                itemBuilder: (context, index) {
                  var lineItem = lineItems[index];
                  //var productId = lineItem['id'];
                  return InkWell(
                      // or InkWell
                      onTap: () {
                        // Navigate to the product detail screen
                        nextScreen(
                            context,
                            // ProductDetailScreen(product_id: lineItem[''])
                            //ProductDetailScreen(productId: lineItem['product_id']),
                            ProductDetailScreen(
                                product_id: lineItem['product_id']));
                        print("this is id ${lineItem['id']}");
                      },
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: Card(
                              elevation: 9,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Image.network(
                                            lineItem["image"]["src"])),
                                    title: Text("Name: ${lineItem['name']}"),
                                    subtitle: Text(
                                        "Product total: ${lineItem['total']}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 105),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Quantity: ${lineItem['quantity']}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )));
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            }
          }),
    );
  }
}
