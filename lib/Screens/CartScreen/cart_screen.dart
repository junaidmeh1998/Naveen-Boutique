import 'package:badges/badges.dart' as badges;
import 'package:flutter/foundation.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/ShippingDetails/shipping_detail_screen.dart';
import 'package:naveenboutique/Screens/ShippingDetails/shipping_detail_screen2.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: headerColor,
        title: RichText(
          text: TextSpan(
            text: 'Cart ',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'Screen',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: buttonColor),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: buttonColor,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: Provider.of<CartProvider>(context).getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 140),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image: AssetImage('assets/empty_cart.jpg')),
                              Text(
                                "Your Cart Is Empty",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             AllCategoriesScreen()));
                                    nextScreen(context, AllCategoriesScreen());
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            buttonColor), // Change color here
                                  ),
                                  child: Text(
                                    "Continue Shopping",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image(
                                              height: 100,
                                              width: 100,
                                              image: NetworkImage(snapshot
                                                  .data![index].image
                                                  .toString()),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .productName
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      InkWell(
                                                          onTap: () async {
                                                            await dbHelper!
                                                                .delete(snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                            cart.removeCounter();
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                            print(snapshot
                                                                .data![index]
                                                                .id!);
                                                            print('deleted');
                                                          },
                                                          child: const Icon(
                                                              Icons.delete))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    //snapshot.data![index].unitTag.toString() +
                                                    // " " +
                                                    r"Rs:" +
                                                        snapshot.data![index]
                                                            .productPrice
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: buttonColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!;
                                                                    quantity--;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;
                                                                    if (quantity >
                                                                        0) {
                                                                      dbHelper!
                                                                          .updateQuantity(Cart(
                                                                              id: snapshot.data![index].id!,
                                                                              productId: snapshot.data![index].productId!.toString(),
                                                                              productName: snapshot.data![index].productName!,
                                                                              initialPrice: snapshot.data![index].initialPrice!,
                                                                              size: snapshot.data![index].size!,
                                                                              productPrice: newPrice,
                                                                              quantity: quantity,
                                                                              //  unitTag: snapshot.data![index].unitTag.toString(),
                                                                              image: snapshot.data![index].image.toString()))
                                                                          .then((value) {
                                                                        newPrice =
                                                                            0;
                                                                        quantity =
                                                                            0;
                                                                        cart.removeTotalPrice(double.parse(snapshot
                                                                            .data![index]
                                                                            .initialPrice!
                                                                            .toString()));
                                                                      }).onError((error, stackTrace) {
                                                                        if (kDebugMode) {
                                                                          print(
                                                                              error.toString());
                                                                        }
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!;
                                                                    quantity++;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;
                                                                    dbHelper!
                                                                        .updateQuantity(Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].productId!.toString(),
                                                                            productName: snapshot.data![index].productName!,
                                                                            initialPrice: snapshot.data![index].initialPrice!,
                                                                            size: snapshot.data![index].size!,
                                                                            productPrice: newPrice,
                                                                            quantity: quantity,
                                                                            //  unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString()))
                                                                        .then((value) {
                                                                      newPrice =
                                                                          0;
                                                                      quantity =
                                                                          0;
                                                                      cart.addTotalPrice(double.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!
                                                                          .toString()));
                                                                    }).onError((error, stackTrace) {
                                                                      if (kDebugMode) {
                                                                        print(error
                                                                            .toString());
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                    }
                  }
                  return const Text('');
                }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                    ? false
                    : true,
                child: Column(
                  children: [
                    ReusableWidget(
                        title: 'Total',
                        value: r'PKR: ' +
                            value.getTotalPrice().toStringAsFixed(2)),
                    Button(
                        text: 'Confirm Order',
                        ontap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          nextScreen(
                              context,
                              prefs.getBool('storeddata') == true
                                  ? ShippingDetailScreen2()
                                  : ShippingAddress());
                        }),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
