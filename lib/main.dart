import 'package:naveenboutique/Packages/packages.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return const MaterialApp(
          home: MyApp(),
          debugShowCheckedModeBanner: false,
        );
      }),
    ),
  );
}

late CartProvider cartprovider;
late WishlistProvider wishlist;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    cartprovider = Provider.of<CartProvider>(context);
    wishlist = Provider.of<WishlistProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Naveen Boutique',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserNavigation());
  }
}
