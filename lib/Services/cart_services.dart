import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:naveenboutique/main.dart';

import '../Packages/packages.dart';

class Order {
  List<Map<String, dynamic>> lineitems;
  Map<String, dynamic> billing;
  Map<String, dynamic> shipping;

  // Add other order details here

  Order({
    required this.billing,
    required this.shipping,
    required this.lineitems,
    // Initialize other order details here
  });

  Map<String, dynamic> toJson() {
    return {
      'billing': billing,
      'shipping': shipping,
      'line_items': lineItems,
      // Add other order details here
    };
  }
}

final List<Map<String, dynamic>> lineItems = [];
// var cartItems =  await CartProvider().getData();
Future<void> CartData() async {
  for (Cart cart in await cartprovider.cart) {
    final Map<String, dynamic> lineItem = {
      "name": cart.productName.toString(),
      "product_id": cart.productId,
      "variation_id": cart.size.toString(),
      "quantity": cart.quantity
      // "quantity": cart.quantity,
      // "subtotal": cart.productPrice,
// Add any other product-related details here
    };
// final List<Map<String, dynamic>> lineItems = [];

// lineItems.add(lineItem);
    lineItems.add(lineItem);
  }
}

// final Email email = Email(
//   body: 'Email body',
//   subject: 'Email subject',
//   recipients: ['saif5969396@gmail.com'],
//   isHTML: false,
// );

Future<void> placeOrder(Order order, context) async {
  const String consumerKey = 'ck_429653af52992037368c9f1153aa82c7e64cf424';
  const String consumerSecret = 'cs_609f88d81f2dc0a0afbb53b13f1a7eb9de128db0';
  final String credentials =
      base64Encode(utf8.encode('$consumerKey:$consumerSecret'));

  final response = await http.post(
    Uri.parse('https://naveenboutique.com/wp-json/wc/v3/orders'),
    headers: {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(order.toJson()),
  );

  if (response.statusCode == 201) {
    print("order creared succesasfully");
    ScaffoldMessenger.of(context).showSnackBar(
      alertmessage(context, "Order has been Placed", buttonColor),
    );

    await dbHelper!.deleteAllData();
    cartprovider.setCounter();
    cartprovider.setTotalPrice();
    await removeProductsfromList();
    nextScreen(context, UserNavigation());
    // Order created successfully, handle the response as needed
  } else {
    print("error");
    ScaffoldMessenger.of(context).showSnackBar(
      alertmessage(context, "Something Went Wrong", buttonColor),
    );
    popupScreen(context);
    // Error creating the order, handle the error
  }
}

// Future<void> sendEmail(
//     String recipientEmail, String subject, String body) async {
//   final smtpServer =
//       gmail(recipientEmail, '12345678'); // Enter your Gmail credentials
//   final message = Message()
//     ..from =
//         Address(recipientEmail, 'saif ali') // Change with your email and name
//     ..recipients.add(recipientEmail)
//     ..subject = subject
//     ..text = body;
//
//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Email sent: ' + sendReport.toString());
//   } on MailerException catch (e) {
//     print('Email sending failed: $e');
//   }
// }
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// Future<String?> sendEmail() async {
//   final smtpServer = SmtpServer(
//     'smtp.gmail.com',
//     port: 25, // SMTP port, 25 is the default unencrypted port
//     ignoreBadCertificate:
//         true, // Only needed if server has a self-signed certificate
//   );
//
//   final message = Message()
//     ..from = Address('junaidmehmood1998@gmail.com', 'Junaid Mehmood')
//     ..recipients.add('junaidmehmood1998@gmail.com')
//     ..subject = 'Test Email without Password'
//     ..text =
//         'This email is sent without a password using an SMTP server that allows open relay.';
//
//   try {
//     final sendReport = await send(message, smtpServer);
//     print('Email sent: ' + sendReport.toString());
//     return sendReport.toString();
//   } catch (e) {
//     print('Failed to send email: $e');
//     return 'Failed to send email: $e';
//   }
//   return null;
// }
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void sendEmail() async {
//   final Uri emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: 'junaidmehmood1998@gmail.com',
//     queryParameters: {
//       'subject': 'New Order Created',
//       'body': 'A new order has been created.',
//     },
//   );
//
//   if (await canLaunch(emailLaunchUri.toString())) {
//     await launch(emailLaunchUri.toString());
//   } else {
//     throw 'Could not launch email';
//   }
// }

removeProductsfromList() {
  lineItems.clear();
}
