import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' as html;
import 'package:html/parser.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/OrdersScreen/order_history.dart';

import '../../main.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.product_id});
  var product_id;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  //late Future<void> _fetchProductVariationsFuture;
  bool variationsFetched = false;
  List _sizeOptions = service.prodVariationsOptions;
  bool xs = false;
  bool isUnstitched = true;
  bool show_prod_description = false;
  String size = "";
  int size1 = 0;
  bool s = false;
  bool m = false;
  bool l = false;
  bool xl = false;

// radio size buttons
  void setSizeXS() {
    setState(() {
      size = "XS";
      xs = true;
      s = false;
      m = false;
      l = false;
      xl = false;
    });
  }

  void setSizeS() {
    setState(() {
      size = "S";
      xs = false;
      s = true;
      m = false;
      l = false;
      xl = false;
    });
  }

  void setSizeM() {
    setState(() {
      size = "M";
      xs = false;
      s = false;
      m = true;
      l = false;
      xl = false;
    });
  }

  void setSizeL() {
    setState(() {
      size = "L";
      xs = false;
      s = false;
      m = false;
      l = true;
      xl = false;
    });
  }

  void setSizeXL() {
    setState(() {
      size = "XL";
      xs = false;
      s = false;
      m = false;
      l = false;
      xl = true;
    });
  }

  int _dataLength = 1;
  int current_index = 0;

  String removeHtmlCode(String parseString) {
    final document = html.parse(parseString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = true; // Initially set to true

  @override
  void dispose() {
    // service.prodImages.clear();
    // service.prodVariations.clear();
    // TODO: implement dispose
    super.dispose();
    service.prodImages.clear();
    service.prodVariations.clear();
  }

  // Future<void> fetchProductVariations() async {
  //   await service.getProductVariations(widget.product_id);
  //   //await service.getProductVariationsOptions(widget.product_id);
  // }
  Future<void> fetchProductVariations() async {
    if (!variationsFetched) {
      await service.getProductVariations(widget.product_id);
      await service.getProductVariationsOptions(widget.product_id);
      variationsFetched = true;
    }
  }
  //List<String> _prodImages = []; // Placeholder for product images

  // Future<void> fetchProductImages() async {
  //   // Replace this with your service call to get product images
  //   _prodImages = await service.getProductImages(widget.product_id);
  //   setState(() {}); // Trigger a rebuild after fetching images
  // }
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.product_id);
    }
    //_fetchProductVariationsFuture = fetchProductVariations();
    //fetchProductImages();
    //fetchProductVariations();
    // variationsFetched = true;
    //fetchProductVariations();
    // await service.getProductVariations(widget.product_id);
    // await service.getProductVariationsOptions(widget.product_id);
    //service.getProductVariations(widget.product_id);
    //service.getProductVariationsOptions(widget.product_id);
    service.getProductImages(widget.product_id);
    service.getSingleProduct(widget.product_id);
    // TODO: implement initState
    super.initState();

    print(service.prodVariations.length);
  }

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(() {
        nextScreen(context, CartScreen());
      }, () {
        nextScreen(context, OrderHistoryScreen());
      }),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              if (_dataLength != 0)
                // FutureBuilder(
                //   future: service.getProductImages(widget.product_id),
                //   builder: (_, snapShot) {
                //     return snapShot.data == null
                //         ? const Center(
                //             child: CircularProgressIndicator(),
                //           )
                //         : Padding(
                //             padding: const EdgeInsets.only(top: 4),
                //             child: CarouselSlider.builder(
                //               itemCount: service.prodImages.length,
                //               itemBuilder: (BuildContext context, index, int) {
                //                 return Image.network(service.prodImages[index],
                //                     fit: BoxFit.cover);
                //               },
                //               options: CarouselOptions(
                //                 viewportFraction: 1,
                //                 initialPage: 0,
                //                 height: MediaQuery.sizeOf(context).height * 0.5,
                //                 onPageChanged:
                //                     (int i, carouselPageChangedReason) {
                //                   setState(
                //                     () {
                //                       current_index = i;
                //                     },
                //                   );
                //                 },
                //               ),
                //             ),
                //           );
                //   },
                // ),
                FutureBuilder(
                  future: service.getProductImages(widget.product_id),
                  builder: (_, snapShot) {
                    if (snapShot.data == null || service.prodImages.isEmpty) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xff83b941)),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: CarouselSlider.builder(
                          itemCount: service.prodImages.length,
                          itemBuilder: (BuildContext context, index, int) {
                            if (service.prodImages.isEmpty) {
                              // Handle the case where service.prodImages is empty
                              return const SizedBox(); // Return an empty widget or placeholder
                            } else if (index >= 0 &&
                                index < service.prodImages.length) {
                              return Image.network(
                                service.prodImages[index],
                                fit: BoxFit.cover,
                              );
                            } else {
                              // Handle the case where the index is out of range
                              return const SizedBox(); // Return an empty widget or placeholder
                            }
                          },
                          // Ensure that the index is within the valid range

                          // if (index >= 0 &&
                          //     index < service.prodImages.length) {
                          //   return Image.network(
                          //     service.prodImages[index],
                          //     fit: BoxFit.cover,
                          //   );
                          // } else {
                          //   // Handle the case where the index is out of range
                          //   return const SizedBox(); // Return an empty widget or placeholder
                          // }
                          options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1,
                            initialPage: 0,
                            height: MediaQuery.of(context).size.height * 0.5,
                            onPageChanged: (int i, carouselPageChangedReason) {
                              setState(() {
                                current_index = i;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),

              // FutureBuilder(
              //   future: service.getProductImages(widget.product_id),
              //   builder: (_, snapShot) {
              //     if (snapShot.data == null || service.prodImages.isEmpty) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else {
              //       return Padding(
              //         padding: const EdgeInsets.only(top: 4),
              //         child: CarouselSlider.builder(
              //           itemCount: service.prodImages.length,
              //           itemBuilder: (BuildContext context, index, int) {
              //             // Ensure that the index is within the valid range
              //
              //             //var index = 0;
              //             if (service.prodImages != null &&
              //                 index < service.prodImages.length) {
              //               return Image.network(
              //                 service.prodImages[index],
              //                 fit: BoxFit.cover,
              //               );
              //             } else {
              //               // Handle the case where the index is out of range
              //               return const SizedBox(); // Return an empty widget or placeholder
              //             }
              //           },
              //           options: CarouselOptions(
              //             viewportFraction: 1,
              //             initialPage: 0,
              //             height: MediaQuery.sizeOf(context).height * 0.5,
              //             onPageChanged: (int i, carouselPageChangedReason) {
              //               setState(() {
              //                 current_index = i;
              //               });
              //             },
              //           ),
              //         ),
              //       );
              //     }
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      height: 5,
                      width: 5,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color:
                              current_index == i ? buttonColor : Colors.black,
                          shape: BoxShape.circle),
                    ),
                ],
              ),
              FutureBuilder(
                future: fetchProductVariations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Variations have been fetched, you can now use `service.prodVariations`
                    return buildProductDetailsWidget();
                  } else {
                    // Loading indicator or placeholder
                    return CircularProgressIndicator(
                      color: Color(0xff83b941),
                    );
                  }
                },
              ),
              // FutureBuilder(
              //   future: service.getSingleProduct(widget.product_id),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.green,
              //         ),
              //       );
              //     } else {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Padding(
              //               padding: const EdgeInsets.only(
              //                   left: 20, top: 10, right: 20),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   Expanded(
              //                       child: Text(
              //                     snapshot.data["name"],
              //                     style: const TextStyle(
              //                       fontSize: 20,
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.black,
              //                     ),
              //                   ))
              //                 ],
              //               )),
              //           Padding(
              //               padding: const EdgeInsets.only(
              //                   left: 20, top: 15, right: 20),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   Expanded(
              //                       child: Text(
              //                     snapshot.data["price"] + " PKR",
              //                     style: const TextStyle(
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.w400,
              //                       color: Colors.black,
              //                     ),
              //                   ))
              //                 ],
              //               )),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(left: 10),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.only(
              //                             left: 10,
              //                             right: 12,
              //                             top: 13,
              //                             bottom: 0),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             //  if (service.prodVariations.isEmpty)
              //                             // const
              //                             Text(
              //                               service.prodVariations.isNotEmpty
              //                                   ? "Stitched"
              //                                   : "Product is Unstitched",
              //                               style: TextStyle(
              //                                   color: Colors.black,
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 14),
              //                             )
              //                             // else
              //                             //   const Text(
              //                             //     "Select Size",
              //                             //     style: TextStyle(
              //                             //         color: Colors.black,
              //                             //         fontWeight: FontWeight.bold,
              //                             //         fontSize: 14),
              //                             //   ),
              //                           ],
              //                         ),
              //                       ),
              //                       if (service.prodVariations
              //                           .isNotEmpty) // Check if variations exist
              //                         Padding(
              //                           padding: const EdgeInsets.only(
              //                               right: 10,
              //                               left: 10,
              //                               bottom: 10,
              //                               top: 5),
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.start,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   for (int i = 0;
              //                                       i <
              //                                           service.prodVariations
              //                                               .length;
              //                                       i++)
              //                                     InkWell(
              //                                       child: Container(
              //                                         width: 35,
              //                                         height: 35,
              //                                         alignment:
              //                                             Alignment.center,
              //                                         //margin: EdgeInsets.symmetric(horizontal: 10),
              //                                         decoration: BoxDecoration(
              //                                             color: Colors.white,
              //                                             boxShadow: [
              //                                               BoxShadow(
              //                                                 color:
              //                                                     buttonColor,
              //                                                 spreadRadius: 2,
              //                                                 //blurRadius: 8,
              //                                               )
              //                                             ]),
              //                                         child: Text(
              //                                           _sizeOptions[i],
              //                                           style: TextStyle(
              //                                               fontSize: 18,
              //                                               fontWeight:
              //                                                   FontWeight.bold,
              //                                               color:
              //                                                   Colors.black54),
              //                                         ),
              //                                       ),
              //                                       onTap: () {
              //                                         setState(() {
              //                                           size1 = service
              //                                               .prodVariations[i];
              //                                           print(size1);
              //                                         });
              //                                       },
              //                                     ),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                         )
              //                     ],
              //                   ),
              //                 ),
              //
              //                 // Padding(
              //                 //     padding: const EdgeInsets.only(
              //                 //         left: 10, right: 12, top: 13, bottom: 0),
              //                 //     child: Row(
              //                 //       mainAxisAlignment:
              //                 //           MainAxisAlignment.spaceBetween,
              //                 //       children: [
              //                 //         service.prodVariations.isEmpty
              //                 //             ? const Text(
              //                 //                 "Product is Unstitched",
              //                 //                 style: TextStyle(
              //                 //                     color: Colors.black,
              //                 //                     fontWeight: FontWeight.bold,
              //                 //                     fontSize: 14),
              //                 //               )
              //                 //             : const Text(
              //                 //                 "Select Size",
              //                 //                 style: TextStyle(
              //                 //                     color: Colors.black,
              //                 //                     fontWeight: FontWeight.bold,
              //                 //                     fontSize: 14),
              //                 //               )
              //                 //       ],
              //                 //     )),
              //                 // Padding(
              //                 //   padding: const EdgeInsets.only(
              //                 //       right: 10, left: 10, bottom: 10, top: 5),
              //                 //   child: Row(
              //                 //     mainAxisAlignment:
              //                 //         MainAxisAlignment.spaceBetween,
              //                 //     children: [
              //                 //       Row(
              //                 //         children: [
              //                 //           for (int i = 0;
              //                 //               i < service.prodVariations.length;
              //                 //               i++)
              //                 //             InkWell(
              //                 //               child: Container(
              //                 //                 width: 35,
              //                 //                 height: 35,
              //                 //                 alignment: Alignment.center,
              //                 //                 //margin: EdgeInsets.symmetric(horizontal: 10),
              //                 //                 decoration: BoxDecoration(
              //                 //                     color: Colors.white,
              //                 //                     boxShadow: [
              //                 //                       BoxShadow(
              //                 //                         color: buttonColor,
              //                 //                         spreadRadius: 2,
              //                 //                         //blurRadius: 8,
              //                 //                       )
              //                 //                     ]),
              //                 //                 child: Text(
              //                 //                   _sizeOptions[i],
              //                 //                   style: const TextStyle(
              //                 //                       fontSize: 18,
              //                 //                       fontWeight: FontWeight.bold,
              //                 //                       color: Colors.black54),
              //                 //                 ),
              //                 //               ),
              //                 //               onTap: () {
              //                 //                 setState(() {
              //                 //                   size1 =
              //                 //                       service.prodVariations[i];
              //                 //                   print(size1);
              //                 //                 });
              //                 //               },
              //                 //             ),
              //                 //         ],
              //                 //       ),
              //                 //     ],
              //                 //   ),
              //                 // )
              //               ],
              //             ),
              //           ),
              //           Padding(
              //               padding: const EdgeInsets.only(
              //                   left: 20, top: 10, right: 20, bottom: 10),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 children: [
              //                   Icon(
              //                     Icons.production_quantity_limits,
              //                     color: buttonColor,
              //                   ),
              //                   Expanded(
              //                     child: Padding(
              //                         padding: const EdgeInsets.only(left: 5),
              //                         child: (snapshot.data["stock_quantity"] ==
              //                                 null)
              //                             ? const Text("out of stock")
              //                             : Text(
              //                                 "${snapshot.data["stock_quantity"]} Pieces left")),
              //                   ),
              //                   GestureDetector(
              //                     onTap: () {},
              //                     child: Text(
              //                       "Terms and conditions",
              //                       style: TextStyle(
              //                         color: buttonColor,
              //                         fontSize: 12,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   )
              //                 ],
              //               )),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 5, bottom: 10),
              //             child: InkWell(
              //               onTap: () async {
              //                 SharedPreferences prefs =
              //                     await SharedPreferences.getInstance();
              //                 prefs.getBool('loggedin') == true
              //                     ? snapshot.data['stock_quantity'] == null
              //                         ? null
              //                         : dbHelper
              //                             ?.insert(Cart(
              //                             id: snapshot.data['id'],
              //                             productId:
              //                                 snapshot.data['id'].toString(),
              //                             productName:
              //                                 snapshot.data['name'].toString(),
              //                             initialPrice:
              //                                 int.parse(snapshot.data['price']),
              //                             productPrice:
              //                                 int.parse(snapshot.data['price']),
              //                             size: size1,
              //                             quantity: 1,
              //                             image: snapshot.data['images'][0]
              //                                     ['src']
              //                                 .toString(),
              //                           ))
              //                             .then((value) {
              //                             if (kDebugMode) {
              //                               print("added ");
              //                             }
              //                             cartprovider.addTotalPrice(
              //                                 double.parse(
              //                                     snapshot.data['price']));
              //                             cartprovider.addCounter();
              //                             ScaffoldMessenger.of(context)
              //                                 .showSnackBar(alertmessage(
              //                                     context,
              //                                     "Product is added to Cart",
              //                                     '',
              //                                     buttonColor));
              //                           }).onError(
              //                             (error, stackTrace) {
              //                               if (kDebugMode) {
              //                                 print(
              //                                   error.toString(),
              //                                 );
              //                               }
              //                               ScaffoldMessenger.of(context)
              //                                   .showSnackBar(alertmessage(
              //                                       context,
              //                                       "Product is already in Cart",
              //                                       '',
              //                                       errorColor));
              //                             },
              //                           )
              //                     : Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) =>
              //                                 const LoginScreen()),
              //                       );
              //                 if (kDebugMode) {
              //                   print(service.prodVariations);
              //                 }
              //               },
              //               child: Container(
              //                 height: 50,
              //                 width: MediaQuery.of(context).size.width * 0.8,
              //                 decoration: BoxDecoration(
              //                     color: snapshot.data['stock_quantity'] == null
              //                         ? Colors.grey
              //                         : buttonColor,
              //                     borderRadius: BorderRadius.circular(10)),
              //                 child: Center(
              //                   child: Text(
              //                     snapshot.data['stock_quantity'] == null
              //                         ? "Out of Stock"
              //                         : "ADD TO CART",
              //                     style: const TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.w400),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.stretch,
              //               children: [
              //                 const Padding(
              //                   padding: EdgeInsets.only(left: 6, top: 6),
              //                   child: Text(
              //                     "Description",
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.bold,
              //                         fontSize: 14),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(6),
              //                   child: Text(
              //                     removeHtmlCode(snapshot.data["description"]),
              //                     textAlign: TextAlign.justify,
              //                     style: const TextStyle(
              //                         color: Colors.black, fontSize: 12),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductDetailsWidget() {
    return
        // RefreshIndicator(
        //     key: _refreshIndicatorKey,
        //     onRefresh: () async {
        //       setState(() {
        //         _isLoading = true; // Set to true when manually refreshing
        //       });
        //     },
        //     child:
        FutureBuilder(
      future: service.getSingleProduct(widget.product_id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _isLoading = false;
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final productData = snapshot.data; // Retrieve product data
            // if (!variationsFetched) {
            //   service.getProductVariations(widget.product_id);
            //   service.getProductVariationsOptions(widget.product_id);
            //   variationsFetched = true;
            // }
            // if (!variationsFetched) {
            //   // Fetch variations and options only if they haven't been fetched yet
            //   service.getProductVariations(widget.product_id).then((_) {
            //     if (mounted) {
            //       setState(() {
            //         variationsFetched = true;
            //       });
            //     }
            //   });
            //   service.getProductVariationsOptions(widget.product_id);
            // }
            if (!variationsFetched) {
              fetchProductVariations(); // Fetch variations only if not fetched yet
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          productData["name"], // Access product name
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          productData["price"] + " PKR", // Access product price
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Rest of your widget content
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 12,
                                top: 13,
                                bottom: 0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    service.prodVariations.isNotEmpty
                                        ? "Stitched"
                                        : "Product is Unstitched",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            variationsFetched
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                      bottom: 10,
                                      top: 5,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    service
                                                        .prodVariations.length;
                                                i++)
                                              InkWell(
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    //color: Colors.white,
                                                    color:
                                                        service.prodVariations[
                                                                    i] ==
                                                                size1
                                                            ? buttonColor
                                                            : Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: buttonColor,
                                                        spreadRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Text(
                                                    i < _sizeOptions.length
                                                        ? _sizeOptions[i]
                                                        : "",
                                                    // Check index validity
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          service.prodVariations[
                                                                      i] ==
                                                                  size1
                                                              ? Colors.white
                                                              : buttonColor,
                                                      //color: Colors.black54,
                                                    ),
                                                  ),
                                                  // Text(
                                                  //   _sizeOptions[i],
                                                  //   style: TextStyle(
                                                  //     fontSize: 18,
                                                  //     fontWeight: FontWeight.bold,
                                                  //     color: Colors.black54,
                                                  //   ),
                                                  // ),
                                                ),
                                                onTap: () {
                                                  if (_isLoading) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    if (i <
                                                        service.prodVariations
                                                            .length) {
                                                      size1 = service
                                                          .prodVariations[i];
                                                      print(size1);
                                                    }
                                                  });
                                                  // setState(() {
                                                  //   size1 =
                                                  //       service.prodVariations[i];
                                                  //   print(size1);
                                                  // });
                                                },
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Text("")
                            // : Center(
                            //     child: CircularProgressIndicator(),
                            //   ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.production_quantity_limits,
                          color: buttonColor,
                        ),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: (snapshot.data["stock_quantity"] == null)
                                  ? const Text("out of stock")
                                  : Text(
                                      "${snapshot.data["stock_quantity"]} Pieces left")),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showDialog(context);
                          },
                          child: Text(
                            "Terms and conditions",
                            style: TextStyle(
                              color: buttonColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.getBool('loggedin') == true
                          ? snapshot.data['stock_quantity'] == null
                              ? null
                              : dbHelper
                                  ?.insert(Cart(
                                  id: snapshot.data['id'],
                                  productId: snapshot.data['id'].toString(),
                                  productName: snapshot.data['name'].toString(),
                                  initialPrice:
                                      int.parse(snapshot.data['price']),
                                  productPrice:
                                      int.parse(snapshot.data['price']),
                                  size: size1,
                                  quantity: 1,
                                  image: snapshot.data['images'][0]['src']
                                      .toString(),
                                ))
                                  .then((value) {
                                  if (kDebugMode) {
                                    print("added ");
                                  }
                                  cartprovider.addTotalPrice(
                                      double.parse(snapshot.data['price']));
                                  cartprovider.addCounter();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      alertmessage(
                                          context,
                                          "Product is added to Cart",
                                          buttonColor));
                                }).onError(
                                  (error, stackTrace) {
                                    if (kDebugMode) {
                                      print(
                                        error.toString(),
                                      );
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        alertmessage(
                                            context,
                                            "Product is already in Cart",
                                            errorColor));
                                  },
                                )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                      if (kDebugMode) {
                        print(service.prodVariations);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: snapshot.data['stock_quantity'] == null
                              ? Colors.grey
                              : buttonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          snapshot.data['stock_quantity'] == null
                              ? "Out of Stock"
                              : "ADD TO CART",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 6, top: 6),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 6, left: 6, right: 20),
                        child: Text(
                          removeHtmlCode(snapshot.data["description"]),
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        } else {
          return CircularProgressIndicator(
              color:
                  Color(0xff83b941)); // Loading indicator while fetching data
        }
      },
      //)
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: Container(
                  height: 600,
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "Please carefully read the following terms and conditions. By accessing, using, or shopping on the Naveen Boutique website, you agree to abide by these terms and conditions.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "1.    Dispute Resolution: Any dispute or claim arising from this website shall be governed and construed in accordance with the applicable laws.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "2.    Exchange Policy: Products purchased from Naveen Boutique’s website can be exchanged within 7 days only under the following conditions:",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "·        Exchange request made within the specified time frame.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "·        The item(s) is faulty, damaged, or defective upon delivery.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "·        Received product(s) differ from the original order.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "·        Missing items in the package, including price tags, labels, original packing, etc.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "3.    Damaged or Missing Products: In case of damaged or missing products, customers must share images of the outer packaging via email at help@naveenboutique.com  as evidence before discarding the packaging.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "4.    Raising a Dispute: For any disputes regarding defective items, customers must email pictures of the item to help@naveenboutique.com  or call at +92 347 6227740  within 3 days after order delivery. Naveen Boutique will review each dispute individually and endeavor to be fair to both parties. Once the dispute is settled, a replacement product will be issued or a coupon of equivalent value for future purchases will be provided.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "5.    Responsibility of Purchases: The buyer/customer/order maker is fully responsible for all purchases made in good faith and assures no intention of fraudulent activity. Additionally, the buyer is solely responsible for all selections made, including articles, dresses, and products.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "6.    Data Usage: Naveen Boutique may use customer data for marketing offers such as newsletters and catalogs. This includes email addresses, wish lists, names, and postal addresses. Customers may create personal accounts on naveenboutique.com, including name, number, and email address.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "7.    Communication and Contact Information: Naveen Boutique may contact customers in case of delivery issues, using the contact details provided such as telephone numbers and addresses.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "8.    Data Disclosure: Naveen Boutique may disclose customer data to fraud prevention agencies as required.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "9.    Age Verification: Naveen Boutique may validate that customers are of legal age for shopping online.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "10. Payment Methods: We accept payments online using Visa and MasterCard credit/debit cards, Jazz Cash, and Easy Paisa in PKR (or any other agreed currencies). Payment details are securely transmitted to our payment provider.",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "11. Agreement Acceptance: By visiting, using, or shopping on the Naveen Boutique website, you acknowledge and agree to these terms and conditions, as modified or amended from time to time.",
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ))),
            ));
  }
}
