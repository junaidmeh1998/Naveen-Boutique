import 'package:flutter/foundation.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/OrdersScreen/order_history.dart';

import '../../main.dart';
//import '../Orders/order_detail.dart';

class CategoryDisplayScreen extends StatefulWidget {
  CategoryDisplayScreen({super.key, required this.category_id});
  var category_id;

  @override
  State<CategoryDisplayScreen> createState() => _CategoryDisplayScreenState();
}

class _CategoryDisplayScreenState extends State<CategoryDisplayScreen> {
  Services services = Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(() {
        nextScreen(context, const CartScreen());
      }, () {
        nextScreen(context, OrderHistoryScreen());
      }),
      // appBar: appbar(() {
      //   nextScreen(context, CartScreen());
      // }, () {
      //   nextScreen(context, OrderHistoryScreen());
      // }),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _showDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10 / MediaQuery.of(context).devicePixelRatio,
                    vertical: 20 / MediaQuery.of(context).devicePixelRatio),
                child: CarouselSlider(
                  items: slider_images1
                      .map(
                        (item) => Image.asset(
                          item['image_path1'],
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 5,
                    scrollPhysics: const BouncingScrollPhysics(),
                    viewportFraction: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: services.getCategoryProduct(widget.category_id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Loading"),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("No Products in This Category"),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 5,
                      child: GridView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: services.category_Product.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.34),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).devicePixelRatio * 1,
                                horizontal:
                                    MediaQuery.of(context).devicePixelRatio *
                                        1),
                            child: GestureDetector(
                              onTap: () {
                                nextScreen(
                                    context,
                                    ProductDetailScreen(
                                        product_id: snapshot.data![index]
                                            ['id']));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                snapshot.data![index]['images']
                                                    [0]['src']))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  snapshot.data![index]['name'],
                                                  style: GoogleFonts
                                                      .playfairDisplay(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rs.${snapshot.data![index]['price']}",
                                                style:
                                                    GoogleFonts.playfairDisplay(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  dbHelperWishList
                                                      .insert(
                                                    WishList(
                                                      id: snapshot.data![index]
                                                          ['id'],
                                                      productId: snapshot
                                                          .data![index]['id']
                                                          .toString(),
                                                      productName: snapshot
                                                          .data![index]['name'],
                                                      productPrice: int.parse(
                                                          snapshot.data![index]
                                                              ['price']),
                                                      image: snapshot
                                                              .data![index]
                                                          ['images'][0]['src'],
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
                                                        .showSnackBar(alertmessage(
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
                                                child: Icon(
                                                  Icons
                                                      .favorite_outline_rounded,
                                                  color: buttonColor,
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
          ],
        ),
      ),
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
