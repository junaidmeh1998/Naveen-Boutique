import 'package:flutter/foundation.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/OrdersScreen/order_history.dart';
import 'package:naveenboutique/Screens/Review/review_screen%5D.dart';
import 'package:naveenboutique/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Services service = Services();
  DBHelperWishList dbHelperWishList = DBHelperWishList();
  shared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedin') == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(() {
        nextScreen(context, const CartScreen());
      }, () {
        nextScreen(context, OrderHistoryScreen());
      }),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10 / MediaQuery.of(context).devicePixelRatio,
                    vertical: 20 / MediaQuery.of(context).devicePixelRatio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CategorieRow(
                      text: 'Categories',
                      file_path: 'assets/catagorie.png',
                      ontap: () {
                        nextScreen(context, const AllCategoriesScreen());
                      },
                    ),
                    CategorieRow(
                      text: 'Festivals',
                      file_path: 'assets/fest.png',
                      ontap: () {
                        nextScreen(
                          context,
                          CategoryDisplayScreen(category_id: 141),
                        );
                      },
                    ),
                    CategorieRow(
                      text: 'Women',
                      file_path: 'assets/womeen.jpg',
                      ontap: () {
                        nextScreen(
                          context,
                          CategoryDisplayScreen(category_id: 138),
                        );
                      },
                    ),
                    CategorieRow(
                      text: 'Men',
                      file_path: 'assets/men.png',
                      ontap: () {
                        nextScreen(
                          context,
                          CategoryDisplayScreen(category_id: 152),
                        );
                      },
                    ),
                    CategorieRow(
                      text: 'Kids',
                      file_path: 'assets/kid.png',
                      ontap: () {
                        nextScreen(
                          context,
                          CategoryDisplayScreen(category_id: 153),
                        );
                      },
                    )
                  ],
                ),
              ),
              // image slider
              const ImageSlider(),
              // 3 containers row
              const threeContainerRow(),
              // new arrival display section
              CategoryHeading(first: 'New', last: " Arrivals"),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
                child: FutureBuilder(
                  future: service.getNewArrivalCategory(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return shimmerHomeScreen(context);
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.015,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade600,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        child: Image.network(
                                          snapshot.data![index]['images'][0]
                                              ['src'],
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          nextScreen(
                                            context,
                                            ProductDetailScreen(
                                                product_id: snapshot
                                                    .data![index]['id']),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 0),
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    snapshot.data![index]
                                                        ['name'],
                                                    style: GoogleFonts
                                                        .playfairDisplay(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rs.${snapshot.data![index]['price']}",
                                                  style: GoogleFonts
                                                      .playfairDisplay(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    dbHelperWishList
                                                        .insert(
                                                      WishList(
                                                        id: snapshot
                                                            .data![index]['id'],
                                                        productId: snapshot
                                                            .data![index]['id']
                                                            .toString(),
                                                        productName: snapshot
                                                                .data![index]
                                                            ['name'],
                                                        productPrice: int.parse(
                                                            snapshot.data![
                                                                    index]
                                                                ['price']),
                                                        image: snapshot.data![
                                                                index]['images']
                                                            [0]['src'],
                                                      ),
                                                    )
                                                        .then((value) {
                                                      if (kDebugMode) {
                                                        print(
                                                            'added to wishlist');
                                                      }
                                                      wishlist.addCounter();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              alertmessage(
                                                                  context,
                                                                  "Product is added to WishList",
                                                                  buttonColor));
                                                    }).onError(
                                                      (error, stackTrace) {
                                                        if (kDebugMode) {
                                                          print(
                                                            error.toString(),
                                                          );
                                                        }
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                alertmessage(
                                                                    context,
                                                                    'Already in Wishlist',
                                                                    errorColor));
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 29,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons
                                                            .favorite_outline_rounded,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              // service.addReview();
                                              _showReviewDialog(
                                                  context,
                                                  snapshot.data[index]['id'],
                                                  prefs
                                                          .getString(
                                                              'first_name')
                                                          .toString() +
                                                      prefs
                                                          .getString(
                                                              'last_name')
                                                          .toString(),
                                                  email);
                                            },
                                            child: Text("Add Review",
                                                style: TextStyle(
                                                    color: buttonColor)),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                nextScreen(
                                                    context,
                                                    Reviews(
                                                        product_id:
                                                            snapshot.data[index]
                                                                ['id']));
                                              },
                                              child: Text(
                                                "Reviews",
                                                style: TextStyle(
                                                    color: buttonColor),
                                              ))
                                        ]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),

              CategoryHeading(first: "Ready To Wear", last: " Collection"),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: FutureBuilder(
                  future: service.get14AugCollection(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return shimmerHomeScreen(context);
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.015,
                                  vertical: MediaQuery.of(context).size.height *
                                      0.015),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade600,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: GestureDetector(
                                        child: Image.network(
                                          snapshot.data![index]['images'][0]
                                              ['src'],
                                          fit: BoxFit.cover,
                                        ),
                                        onTap: () {
                                          nextScreen(
                                            context,
                                            ProductDetailScreen(
                                                product_id: snapshot
                                                    .data![index]['id']),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 4, 0, 0),
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    snapshot.data![index]
                                                        ['name'],
                                                    style: GoogleFonts
                                                        .playfairDisplay(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Rs.${snapshot.data![index]['price']}",
                                                  style: GoogleFonts
                                                      .playfairDisplay(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    dbHelperWishList
                                                        .insert(
                                                      WishList(
                                                        id: snapshot
                                                            .data![index]['id'],
                                                        productId: snapshot
                                                            .data![index]['id']
                                                            .toString(),
                                                        productName: snapshot
                                                                .data![index]
                                                            ['name'],
                                                        productPrice: int.parse(
                                                            snapshot.data![
                                                                    index]
                                                                ['price']),
                                                        image: snapshot.data![
                                                                index]['images']
                                                            [0]['src'],
                                                      ),
                                                    )
                                                        .then((value) {
                                                      if (kDebugMode) {
                                                        print(
                                                            'added to wishlist');
                                                      }
                                                      wishlist.addCounter();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              alertmessage(
                                                                  context,
                                                                  "Product is added to WishList",
                                                                  buttonColor));
                                                    }).onError(
                                                      (error, stackTrace) {
                                                        if (kDebugMode) {
                                                          print(
                                                            error.toString(),
                                                          );
                                                        }
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                alertmessage(
                                                                    context,
                                                                    'Already in Wishlist',
                                                                    errorColor));
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 29,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons
                                                            .favorite_outline_rounded,
                                                        color: buttonColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              //name
            ],
          ),
        ),
      ),
    );
  }

  // void _showReviewDialog(
  //   BuildContext context,
  //   int prod_id,
  //   String name,
  //   String email1,
  // ) {
  //   double _rating = 0;
  //   String _reviewText = '';
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Add Review',
  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             RatingBar.builder(
  //               initialRating: _rating,
  //               minRating: 1,
  //               direction: Axis.horizontal,
  //               allowHalfRating: false,
  //               itemCount: 5,
  //               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
  //               itemBuilder: (context, _) => Icon(
  //                 Icons.star,
  //                 color: Colors.amber,
  //               ),
  //               onRatingUpdate: (rating) {
  //                 setState(() {
  //                   _rating = rating;
  //                 });
  //               },
  //               itemSize: 35,
  //             ),
  //             SizedBox(height: 15),
  //             TextField(
  //               onChanged: (value) {
  //                 setState(() {
  //                   _reviewText = value; // Store the user's input
  //                 });
  //               },
  //               maxLines: 3,
  //               decoration: InputDecoration(
  //                 hintText: 'Enter your review...',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: () async {
  //                 // Call the addReview function here with user inputs
  //                 await service.addReview(
  //                     prod_id, _reviewText, name, email1, _rating.toInt());
  //                 //service.addReview(_reviewText, reviewer, prod_id, user_email,
  //                 //_rating.toInt());
  //                 // addReview(_reviewText, productId, userId, _rating.toInt());
  //                 Navigator.of(context).pop();
  //               },
  //               style: ButtonStyle(
  //                 backgroundColor:
  //                     MaterialStateProperty.all<Color>(buttonColor),
  //               ),
  //               child: Text('Submit Review'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  void _showReviewDialog(
    BuildContext context,
    int prod_id,
    String name,
    String email1,
  ) {
    double _rating = 0;
    String _reviewText = '';
    bool _isSubmitting = false; // State variable for submission state

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Add Review',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    itemSize: 35,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _reviewText = value; // Store the user's input
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your review...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _isSubmitting
                      ? Center(
                          child:
                              CircularProgressIndicator(), // Show circular progress indicator while submitting
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isSubmitting =
                                  true; // Set the state to indicate submission is in progress
                            });

                            // Call the addReview function here with user inputs
                            await service.addReview(prod_id, _reviewText, name,
                                email1, _rating.toInt());
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(buttonColor),
                          ),
                          child: Text('Submit Review'),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
