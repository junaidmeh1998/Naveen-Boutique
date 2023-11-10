import 'package:naveenboutique/Packages/packages.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  int _counter = 0;
  int get counter => _counter;
  double _totalprice = 0.0;
  double get totalprice => _totalprice;

  String _firstname = '';
  String get firstname => _firstname;
  String _lastname = '';
  String get lastname => _lastname;
  String _email = '';
  String get email => _email;
  String _province = '';
  String get province => _province;
  String _city = '';
  String get city => _city;
  String _postalcode = '';
  String get postalcode => _postalcode;
  String _phonenumber = '';
  String get phonenumber => _phonenumber;
  bool _stored_data = false;
  bool get storeddata => _stored_data;
  bool _loggedin = false;
  bool get loggedin => _loggedin;

  String _signupName = '';
  String _signupEmail = '';
  String _signup_PhoneNumebr = '';
  String get signupName => _signupName;
  String get signupEmail => _signupEmail;
  String get signupPhoneNumber => _signup_PhoneNumebr;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setSignupDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('signupName', _signupName);
    prefs.setString('signupEmail', _signupEmail);
    prefs.setString('signupPhoneNumber', _signup_PhoneNumebr);
    notifyListeners();
  }

  storeSignupDetails(String name, String email, String phoneNumber) async {
    _signupName = name;
    _signupEmail = email;
    _signup_PhoneNumebr = phoneNumber;
    _setSignupDetails();
    notifyListeners();
  }

  void _setLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', _loggedin);
    notifyListeners();
  }

  loginStatus(bool logginstatus) {
    _loggedin = logginstatus;
    _setLoginStatus();
    notifyListeners();
  }

  logoutStatus(bool logginstatus) {
    _loggedin = logginstatus;
    _setLoginStatus();
    notifyListeners();
  }

  void _setSHippingDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('first_name', _firstname);
    prefs.setString('last_name', _lastname);
    prefs.setString('email', _email);
    prefs.setString('province', _province);
    prefs.setString('city', _city);
    prefs.setString('postal_code', _postalcode);
    prefs.setString('phone_number', _phonenumber);
    prefs.setBool('storeddata', _stored_data);
    notifyListeners();
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalprice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalprice = prefs.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  storeShippingDetails(
      String firstName,
      String lastName,
      String email,
      String province,
      String city,
      String postalCode,
      String phoneNumber,
      bool storeddata) {
    _firstname = firstName;
    _lastname = lastName;
    _email = email;
    _city = city;
    _postalcode = postalCode;
    _phonenumber = phoneNumber;
    _stored_data = storeddata;
    _setSHippingDetails();
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalprice = _totalprice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalprice = _totalprice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void setTotalPrice() {
    _totalprice = 0.0;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalprice;
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

  void setCounter() {
    _counter = 0;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
}
