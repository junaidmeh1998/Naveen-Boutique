// import 'package:naveenboutique/Packages/packages.dart';
//
// class Reviews extends StatefulWidget {
//   Reviews({Key? key, required this.product_id})
//       : super(
//           key: key,
//         );
//   final int product_id;
//   @override
//   State<Reviews> createState() => _ReviewsState();
// }
//
// class _ReviewsState extends State<Reviews> {
//   // Inside your widget's state
//   List<dynamic> reviews = []; // Initialize an empty list to store reviews
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // Call the function to fetch reviews when the widget initializes
//   //   fetchAndSetReviews(widget.product_id);
//   // }
//
//   Future<void> fetchAndSetReviews(var product_id) async {
//     int productId = 123; // Replace with the actual product ID
//     List<dynamic> fetchedReviews =
//         await service.fetchProductReviews(product_id);
//     setState(() {
//       reviews = fetchedReviews;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder(
//             future: fetchAndSetReviews(widget.product_id),
//             builder: (_, snapShot) {
//               return ListView.builder(
//                 itemCount: reviews.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Reviewer: ${reviews[index]['name']}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Rating: ${reviews[index]['rating']}'),
//                         Text('Review: ${reviews[index]['review']}'),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }));
//   }
// }
import 'package:flutter/material.dart';
import 'package:naveenboutique/Constants/constant.dart';

// class Reviews extends StatefulWidget {
//   Reviews({Key? key, required this.product_id}) : super(key: key);
//   final int product_id;
//
//   @override
//   State<Reviews> createState() => _ReviewsState();
// }
//
// class _ReviewsState extends State<Reviews> {
//   List<dynamic> reviews = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchAndSetReviews(widget.product_id);
//   }
//
//   Future<void> fetchAndSetReviews(int product_id) async {
//     // Fetching reviews logic goes here
//     List<dynamic> fetchedReviews = await service
//         .fetchProductReviews(product_id); // Replace with actual fetched reviews
//     setState(() {
//       reviews = fetchedReviews;
//     });
//   }
//
//   String getStarsFromRating(int rating) {
//     String stars = '⭐' * rating; // For simplicity, using the star emoji
//     return stars;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reviews'),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         itemCount: reviews.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               SizedBox(
//                 child: Card(
//                   elevation: 9,
//                   child: Column(
//                     children: [
//                       ListTile(
//                         title: Padding(
//                           padding: EdgeInsets.only(top: 5),
//                           child: Text(
//                               'Rating: ${getStarsFromRating(reviews[index]['rating'])}'),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Displaying stars for rating
//                             Padding(
//                                 padding: EdgeInsets.only(top: 3),
//                                 child: Text(
//                                   'Reviewer: ${reviews[index]['name']}',
//                                   style: TextStyle(color: Colors.black),
//                                 )),
//                             Padding(
//                                 padding: EdgeInsets.only(top: 8),
//                                 child: Text(
//                                   '${reviews[index]['review']}',
//                                   style: TextStyle(color: Colors.black54),
//                                 )),
//                             // Padding(
//                             //     padding: EdgeInsets.only(top: 8),
//                             //     child: Text(
//                             //       '${reviews.length}',
//                             //       style: TextStyle(color: Colors.black54),
//                             //     )),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
class Reviews extends StatefulWidget {
  Reviews({Key? key, required this.product_id}) : super(key: key);
  final int product_id;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  late Future<List<dynamic>> reviews;

  @override
  void initState() {
    super.initState();
    reviews = fetchAndSetReviews(widget.product_id);
  }

  Future<List<dynamic>> fetchAndSetReviews(int product_id) async {
    // Fetching reviews logic goes here
    return service
        .fetchProductReviews(product_id); // Replace with actual fetched reviews
  }

  String getStarsFromRating(int rating) {
    String stars = '⭐' * rating; // For simplicity, using the star emoji
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: buttonColor,
              ), // Display circular progress indicator while loading
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching data'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No reviews available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      child: Card(
                        elevation: 9,
                        child: Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                    'Rating: ${getStarsFromRating(snapshot.data![index]['rating'])}'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Text(
                                        'Reviewer: ${snapshot.data![index]['name']}',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        '${snapshot.data![index]['review']}',
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
