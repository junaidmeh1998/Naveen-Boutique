import 'package:naveenboutique/Packages/packages.dart';

//Main Colors
Color bgColor = const Color(0xffeeeeee);
Color textFieldBorderColor = const Color(0xff222222);
Color buttonColor = const Color(0xff83b941);
Color buttonColorwithopacity = const Color(0xff83B735).withOpacity(0.5);
Color textColor = const Color(0xff222222);
Color errorColor = Colors.red;
Color headerColor = const Color(0xffD9D9D9);
Color headerColor1 = const Color(0xffD9D9D9).withOpacity(0.5);
Color newbgcolor = Color(0xffeeeeee);

Color wishlistmessage = Colors.lightBlueAccent;
//Global Form key
GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
GlobalKey<FormState> signupformKey = GlobalKey<FormState>();
GlobalKey<FormState> adminLoginFormkey = GlobalKey<FormState>();
GlobalKey<FormState> cartPageFormKey = GlobalKey<FormState>();
//Text Editing Controllers

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
//admin dahboard controllers
TextEditingController productNameController = TextEditingController();
TextEditingController productPriceController = TextEditingController();
TextEditingController productCategoryController = TextEditingController();
TextEditingController productStockController = TextEditingController();
TextEditingController productColorController = TextEditingController();
TextEditingController productDescriptionController = TextEditingController();

//order editiors
TextEditingController adressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController postalcontroller = TextEditingController();
TextEditingController phonenocontroller = TextEditingController();
TextEditingController postalcodeController = TextEditingController();

//textstyle of productdetail scren
TextStyle txtstyle = GoogleFonts.playfairDisplay(fontSize: 15);

//slider image list
List slider_images = [
  {"id": 1, "image_path": 'assets/1.jpg'},
  {"id": 2, "image_path": 'assets/2.jpg'},
  {"id": 3, "image_path": 'assets/3.png'},
  {"id": 4, "image_path": 'assets/4.jpg'}
];

List slider_images1 = [
  {"id": 1, "image_path1": 'assets/easyreturn.jpg'},
];
String email = '';

// Cart List
List cartPrimary = [];
final CarouselController carouselController = CarouselController();

String? userName;

Services service = Services();

DBHelper? dbHelper = DBHelper();
DBHelperWishList dbHelperWishList = DBHelperWishList();

//shipping screen controller
final firstNameEditingController = TextEditingController();
final lastNameEditingController = TextEditingController();
final address1EditingController = TextEditingController();
final cityEditingController = TextEditingController();
final provinceEditingController = TextEditingController();
final postEditingController = TextEditingController();
final phoneNumberEditingController = TextEditingController();
