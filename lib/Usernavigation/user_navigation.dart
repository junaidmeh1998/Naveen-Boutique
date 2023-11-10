import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/UserProfile/user_profile_screen.dart';

import '../Screens/WishlistScreen/wishlist_screen.dart';

class UserNavigation extends StatefulWidget {
  UserNavigation({this.i});
  int? i;

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  List screens = [
    const WishlistScreen(),
    const HomeScreen(),
    ProductSearch(),
    const UserProfileScreen()
  ];
  int selectedIndex = 1;
  @override
  void initState() {
    DBHelper().initDatabase();
    DBHelperWishList().initDatabase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        index: 1,
        backgroundColor: const Color(0xffeeeeee),
        color: Colors.white,
        items: const [
          Icon(Icons.favorite_border),
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.account_circle_rounded)
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
