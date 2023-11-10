import 'package:badges/badges.dart' as badges;

import '../Packages/packages.dart';

PreferredSizeWidget? appbar(Function() ontap1, Function() ontap2) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 1,
    backgroundColor: headerColor,
    title: RichText(
      text: TextSpan(
        text: 'Naveen ',
        style: GoogleFonts.playfairDisplay(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: 'Boutique',
            style: GoogleFonts.playfairDisplay(
                fontSize: 20, fontWeight: FontWeight.bold, color: buttonColor),
          ),
        ],
      ),
    ),

    actions: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: InkWell(
              onTap: ontap1,
              child: Center(
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
              // child: const Icon(CupertinoIcons.bag),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: IconButton(
              icon: Icon(
                Icons.fire_truck,
                color: buttonColor,
              ),
              onPressed: ontap2,
            ),
          ),
        ],
      )
    ],
  );
}
