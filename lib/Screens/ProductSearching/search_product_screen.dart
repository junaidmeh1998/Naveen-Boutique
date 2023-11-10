import 'package:naveenboutique/Packages/packages.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        automaticallyImplyLeading: false,
        title: Card(
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.black),
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
              // Perform the search when the text changes.
              // service.getSearchedProduct(name);
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: service.getSearchedProduct(name),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          } else {
            // Separate the products with null stock quantity
            List<dynamic> products = List.from(snapshot.data);
            List<dynamic> nullStockProducts = products
                .where((product) => product['stock_quantity'] == null)
                .toList();
            List<dynamic> availableStockProducts = products
                .where((product) => product['stock_quantity'] != null)
                .toList();

            // Combine the lists with products having available stock listed first
            products = availableStockProducts + nullStockProducts;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => nextScreen(context,
                      ProductDetailScreen(product_id: products[index]['id'])),
                  child: ListTile(
                    leading: Container(
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.network(
                        products[index]['images'][0]['src'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      products[index]['name'],
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    subtitle: products[index]['stock_quantity'] == null
                        ? const Text('Out of Stock')
                        : Text(
                            'stock: ${products[index]['stock_quantity']} in stock'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: buttonColor,
    //     automaticallyImplyLeading: false,
    //     title: Card(
    //       child: TextFormField(
    //         textCapitalization: TextCapitalization.sentences,
    //         keyboardType: TextInputType.text,
    //         decoration: const InputDecoration(
    //           prefixIcon: Icon(Icons.search),
    //           hintText: 'Search...',
    //           hintStyle: TextStyle(color: Colors.black),
    //         ),
    //         onChanged: (val) {
    //           setState(() {
    //             name = val;
    //           });
    //           service.getSearchedProduct(name);
    //         },
    //       ),
    //     ),
    //   ),
    //   body: FutureBuilder(
    //     future: service.getSearchedProduct(name),
    //     builder: (BuildContext context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //             child: CircularProgressIndicator(
    //           color: Colors.green,
    //         ));
    //       } else {
    //         return ListView.builder(
    //           itemCount: service.searched_product.length,
    //           itemBuilder: (context, index) {
    //             return InkWell(
    //               onTap: () => nextScreen(
    //                   context,
    //                   ProductDetailScreen(
    //                       product_id: snapshot.data![index]['id'])),
    //               child: ListTile(
    //                 leading: Container(
    //                   height: 400,
    //                   decoration: const BoxDecoration(
    //                     color: Colors.white,
    //                   ),
    //                   child: Image.network(
    //                     snapshot.data![index]['images'][0]['src'],
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 title: Text(
    //                   snapshot.data![index]['name'],
    //                   style: GoogleFonts.playfairDisplay(
    //                       fontSize: 12, fontWeight: FontWeight.bold),
    //                 ),
    //                 subtitle: snapshot.data![index]['stock_quantity'] == null
    //                     ? const Text('Out of Stock')
    //                     : Text(
    //                         'stock: ${snapshot.data![index]['stock_quantity']} in stock'),
    //               ),
    //             );
    //           },
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
