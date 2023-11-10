import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/Screens/OrdersScreen/order_history.dart';
import 'package:naveenboutique/Screens/WishlistScreen/wishlist_screen.dart';
import 'package:naveenboutique/main.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool login = false;
  //String email = '';
  String address = "";
  String phoneNumber = " ";

  launchWhatsapp() async {
    const phone = '+92 3102548084';
    const url = 'https://wa.me/$phone';
    await launch(url);
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('signupEmail').toString();
    prefs.getString('signupPhoneNumber').toString();
    prefs.getString('email').toString();

    setState(() {
      email = prefs.getString('signupEmail').toString();
      address = prefs.getString('email').toString();
      phoneNumber = prefs.getString('signupPhoneNumber').toString();
    });
  }

  @override
  void initState() {
    checkLoginStatus();
    getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  checkLoginStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    setState(() {
      login = sf.getBool('loggedin')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: SafeArea(
          child: login
              ? Column(
                  children: [
                    SizedBox(
                      height: height * 0.6,
                      child: Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/userprofile-light-green-background.png'),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: height * 0.33,
                              left: width * 0.09,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff83B735),
                                      width: 5,
                                    ),
                                    color: const Color(0xffeeeeee),
                                    borderRadius: BorderRadius.circular(40)),
                                height: height * 0.24,
                                width: width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      userDetailedRow(
                                          icon: Icons.email, text: email),
                                      userDetailedRow(
                                        icon: Icons.location_city,
                                        text: address,
                                      ),
                                      userDetailedRow(
                                        icon: Icons.phone,
                                        text: phoneNumber,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: height * 0.25,
                              left: width * 0.38,
                              child: const CircleAvatar(
                                backgroundColor: Color(0xff83B735),
                                radius: 44,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff83B735),
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage('assets/avatar.jpeg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ProfileScreenButton(
                      text: 'Contact Us',
                      icon: FontAwesomeIcons.whatsapp,
                      onTap: () {
                        launchWhatsapp();
                      },
                    ),
                    ProfileScreenButton(
                      text: 'Wish List',
                      icon: Icons.favorite_outline,
                      onTap: () {
                        nextScreen(context, WishlistScreen());
                      },
                    ),
                    ProfileScreenButton(
                      text: 'Orders',
                      icon: Icons.fire_truck,
                      onTap: () {
                        nextScreen(context, OrderHistoryScreen());
                      },
                    ),
                    ProfileScreenButton(
                      text: 'Logout',
                      icon: Icons.exit_to_app,
                      onTap: () async {
                        login == true ? cartprovider.logoutStatus(false) : null;
                        nextScreenReplace(context, UserNavigation());
                      },
                    )
                  ],
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text('Kindly Login First to See Your Profile'))
                  ],
                )),
    );
  }
}

class ProfileScreenButton extends StatelessWidget {
  ProfileScreenButton(
      {super.key, required this.text, required this.icon, required this.onTap});
  Function()? onTap;
  IconData icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 40,
          width: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: buttonColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    text,
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class userDetailedRow extends StatelessWidget {
  userDetailedRow({super.key, required this.icon, required this.text});
  IconData? icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: buttonColor,
          ),
          Flexible(
              child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 10),
                  child: Text(text)))
        ],
      ),
    );
  }
}
