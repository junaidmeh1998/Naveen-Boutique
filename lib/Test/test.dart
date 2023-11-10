import 'package:naveenboutique/Packages/packages.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  DBHelper cartitems = DBHelper();
  late Future<List<String>> productNames;
  @override
  void initState() {
    productNames = dbHelper!.getProductNames();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: productNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while fetching data.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final List<String>? productNames = snapshot.data;
            return ListView.builder(
              itemCount: productNames?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productNames![index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
