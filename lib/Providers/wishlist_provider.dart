import 'package:naveenboutique/Packages/packages.dart';

import '../DB/wishlist_db.dart';
import '../Models/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  DBHelperWishList db = DBHelperWishList();

  int _counter = 0;
  int get counter => _counter;

  late Future<List<WishList>> _cart;
  Future<List<WishList>> get cart => _cart;

  Future<List<WishList>> getData() async {
    _cart = db.getWishList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('wishlist_item', _counter);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('wishlist_item') ?? 0;

    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
