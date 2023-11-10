import 'package:flutter/foundation.dart';
import 'package:naveenboutique/Packages/packages.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // to get the length of cart collecrtion to show on cart icon

  //prechache image fucntion

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DBHelperWishList? dbHelper = DBHelperWishList();

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);
    return Scaffold(
        backgroundColor: const Color(0xffeeeeee),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: headerColor,
          title: RichText(
            text: TextSpan(
              text: 'WishList ',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
        ),
        body: FutureBuilder(
          future: wishlist.getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Add some products in wishlist"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        nextScreen(
                            context,
                            ProductDetailScreen(
                                product_id: snapshot.data![index].id));
                      },
                      child: ListTile(
                        leading: Container(
                          height: 400,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Image.network(
                            snapshot.data![index].image.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          snapshot.data![index].productName.toString(),
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Price: ${snapshot.data![index].productPrice.toString()}'),
                            InkWell(
                              onTap: () {
                                dbHelper!.delete(snapshot.data![index].id!);
                                wishlist.removeCounter();
                                if (kDebugMode) {
                                  print('item deleted');
                                }
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return const Text('');
          },
        ));
  }
}
