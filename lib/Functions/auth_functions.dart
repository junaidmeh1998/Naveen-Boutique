import 'dart:convert';

import 'package:http/http.dart' as http;

const String consumerKey = 'ck_429653af52992037368c9f1153aa82c7e64cf424';
const String consumerSecret = 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0';
final String credentials =
    base64Encode(utf8.encode('$consumerKey:$consumerSecret'));
const String baseUrl = 'https://naveenboutique.com/wp-json/';
Future<Map<String, dynamic>> signUpUser(String name, String username,
    String email, String password, String phone, String postcode) async {
  final response = await http.post(
    Uri.parse('https://naveenboutique.com/wp-json/wc/v3/customers'),
    headers: {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'country': 'PK',
      'phone': phone,
      'postcode': postcode
    }),
  );
  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to sign up');
  }
}

Future<Map<String, dynamic>> loginUser(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://naveenboutique.com/wp-json/jwt-auth/v1/token'),
    headers: {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to log in');
  }
}

// Future<void> loginCustomer(String username, String password) async {
//   final response = await http.post(
//     Uri.parse('$baseUrl/jwt-auth/v1/token'),
//     headers: {
//       'Content-Type': 'application/x-www-form-urlencoded',
//     },
//     body: {
//       'username': username,
//       'password': password,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     // Successfully logged in
//     // Parse the response JSON to get the customer's access token
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String accessToken = data['token'];
//     // Store the access token securely for future API requests
//   } else {
//     // Handle login failure
//     throw Exception('Failed to log in');
//   }
// }
