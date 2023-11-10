import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naveenboutique/Packages/packages.dart';

class Services {
  var categories_name,
      category_Product,
      all_Products,
      response,
      single_Product,
      newarrival_Category,
      forteenaugCollection,
      searched_product,
      addto_cart;

  List prodImages = [];
  List prodVariations = [];
  List prodVariationsOptions = [];
  Future getCategories() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    categories_name = await wooCommerceAPI.getAsync("products/categories");
    return categories_name;
  }

  Future getCategoryProduct(categoryId) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    category_Product = await wooCommerceAPI
        .getAsync("products?category=$categoryId&per_page=20");
    return category_Product;
  }

  // Future addReview(
  //   int productId,
  // ) async {
  //   // Initialize the API
  //   WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
  //       url: 'https://naveenboutique.com',
  //       consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
  //       consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');
  //   var data = {
  //     "product_id": productId,
  //   };
  //
  //   // Get data using the "products" endpoint
  //   var response =
  //       await wooCommerceAPI.postAsync("products/$productId/reviews", data);
  //   return response;
  // }
  //Replace with your WooCommerce package import

// Function to fetch reviews for a specific product
  Future<List<dynamic>> fetchProductReviews(int productId) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: 'https://naveenboutique.com',
      consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
      consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0',
    );

    try {
      var response =
          await wooCommerceAPI.getAsync("products/$productId/reviews");

      if (response != null && response is List<dynamic>) {
        return response;
      } else {
        print("Failed to fetch reviews: Response not as expected");
        // Handle the error if the response doesn't match the expected structure
        return <dynamic>[];
      }
    } catch (e) {
      print("Error fetching reviews: $e");
      // Handle the error in case of an exception during the request
      return <dynamic>[];
    }
  }

  Future addReview(
    int productId,
    String reviewText,
    String reviewerName,
    String reviewerEmail,
    int rating,
  ) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: 'https://naveenboutique.com',
      consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
      consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0',
    );
    // Dummy review data
    // final int productId =
    //     17052; // Replace with the product ID you want to add a review for
    // final String reviewText = 'This product is amazing!';
    // final String reviewerName = 'John Doe';
    // final String reviewerEmail = 'john@example.com';
    // final int rating = 5; // Rating on a scale of 1 to 5

    var data = {
      "product_id": productId,
      "review": reviewText,
      "reviewer": reviewerName,
      "reviewer_email": reviewerEmail,
      "rating": rating,
      "name": reviewerName, // Include name in the data
      "email": reviewerEmail, // Include email in the data
    };

    try {
      var response =
          await wooCommerceAPI.postAsync("products/$productId/reviews", data);

      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('id')) {
          print("Review added successfully with ID: ${response['id']}");
          // Handle successful review addition here
        } else {
          print("Failed to add the review: ${response['message']}");
          // Handle the error if the review addition fails
        }
      } else {
        print("Failed to add the review: Response not as expected");
        // Handle the error if the response doesn't match the expected structure
      }
    } catch (e) {
      print("Error adding the review: $e");
      // Handle the error in case of an exception during the request
    }
    // var data = {
    //   "product_id": 123,
    //   "review": "gerhrtjtjtyjktyjty",
    //   "reviewer": "junaid Mehmood",
    //   "reviewer_email":
    //       "ali1@gmail.com", // Replace this with the actual user's email
    //   "rating": 4,
    // };
    //
    // var response = await wooCommerceAPI.postAsync("products/140/reviews", data);
    //
    // if (response == 201) {
    //   print("Review added successfully");
    //   // Optionally, you might want to do something upon successful review addition
    // } else {
    //   print("Failed to add the review: ${response}");
    //   // Handle the error if the review addition fails
    // }
  }

  Future getAllProducts() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    all_Products = await wooCommerceAPI.getAsync("products");
    return all_Products;
  }

  Future getSingleProduct(productId) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    single_Product = await wooCommerceAPI.getAsync("products/$productId");
    // service.getProductVariationsOptions(productId);
    return single_Product;
  }

  Future getProductImages(productId) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    single_Product = await wooCommerceAPI.getAsync("products/$productId");

    // Clear the existing prodImages list before populating it
    prodImages.clear();

    // Check if images exist before adding them to prodImages
    if (single_Product['images'] != null &&
        single_Product['images'].isNotEmpty) {
      for (int i = 0; i < single_Product['images'].length; i++) {
        final image = single_Product['images'][i]['src'];
        if (image != null) {
          prodImages.add(image);
        }
      }
    }

    return prodImages;
  }

  // Future getProductImages(productId) async {
  //   // Initialize the API
  //   WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
  //       url: 'https://naveenboutique.com',
  //       consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
  //       consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');
  //
  //   // Get data using the "products" endpoint
  //   single_Product = await wooCommerceAPI.getAsync("products/$productId");
  //
  //   prodImages.add(single_Product['images'][0]['src']);
  //   prodImages.add(single_Product['images'][1]['src']);
  //   prodImages.add(single_Product['images'][2]['src']);
  //   prodImages.add(single_Product['images'][3]['src']);
  //   return prodImages;
  // }

  Future getProductVariations(productId) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    single_Product = await wooCommerceAPI.getAsync("products/$productId");
    prodVariations.addAll(single_Product['variations']);

    return prodVariations;
  }

  Future getProductVariationsOptions(productId) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    single_Product = await wooCommerceAPI.getAsync("products/$productId");
    prodVariationsOptions.addAll(single_Product['attributes'][0]['options']);
//[0]
    return prodVariationsOptions;
  }

  Future getNewArrivalCategory() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    newarrival_Category = await wooCommerceAPI
        .getAsync("products?status=publish&category=140&per_page=30");
    return newarrival_Category;
  }

  Future get14AugCollection() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    forteenaugCollection = await wooCommerceAPI
        .getAsync("products?status=publish&category=137&per_page=30");

    return forteenaugCollection;
  }

  Future getSearchedProduct(prodName) async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    searched_product = await wooCommerceAPI
        .getAsync("products?status=publish&search=$prodName&per_page=40");

    return searched_product;
  }

  Future addtoCart() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: 'https://naveenboutique.com',
        consumerKey: 'ck_429653af52992037368c9f1153aa82c7e64cf424',
        consumerSecret: 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0');

    // Get data using the "products" endpoint
    addto_cart = await wooCommerceAPI.postAsync(
      "cart/add",
      {'product_id': 16601, 'quantity': 1},
    );
    if (addto_cart == true) {
      return const Text('added');
    } else {
      return const Text('wrong');
    }
    return addto_cart;
  }

  final String targetEmail = 'customer@example.com';

  Future<List<dynamic>> fetchAllOrders() async {
    final String baseURL = 'https://naveenboutique.com/wp-json/wc/v3/orders';
    final String consumerKey = 'ck_429653af52992037368c9f1153aa82c7e64cf424';
    final String consumerSecret = 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0';
    // Replace with the desired email address
    final response = await http.get(
      Uri.parse(baseURL),
      headers: {
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
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
}
//https://naveenboutique.com/wp-json/wc/v3/products?per_page20&category=140
