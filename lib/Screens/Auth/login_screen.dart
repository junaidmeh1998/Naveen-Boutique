import 'package:flutter/foundation.dart';
import 'package:naveenboutique/Packages/packages.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool submitTrue = false;
  bool loginProgress = false;
  String loginEmail = '';
  _submit() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState?.save();
    setState(() {
      submitTrue = true;
      loginProgress = true;
    });
  }

  @override
  void dispose() {
    submitTrue = false;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    //getUserLogedinStatus();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset("assets/Naveen Boutique new logo.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                "Login",
                style: GoogleFonts.playfairDisplaySc(
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              textfields(
                controller: emailController,
                text: 'Email',
                obsecuretext: false,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              textfields(
                  controller: passwordController,
                  text: "Password",
                  obsecuretext: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: GoogleFonts.playfairDisplay(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Button(
                text: loginProgress ? 'Login Progress...' : 'LOGIN',
                ontap: () async {
                  SharedPreferences sf = await SharedPreferences.getInstance();
                  await _submit();
                  submitTrue
                      ? loginUser(emailController.text.toString(),
                              passwordController.text.toString())
                          .then((value) async {
                          setState(() {
                            loginProgress = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                              alertmessage(
                                  context, 'Successfully Login', buttonColor));
                          setState(() {
                            loginEmail = emailController.text.toString();
                          });
                          await cartprovider.storeSignupDetails(
                              nameController.text.toString(),
                              loginEmail,
                              phonenocontroller.text.toString());
                          if (kDebugMode) {
                            print(sf.getString('signupEmail'));
                          }
                          await cartprovider.loginStatus(true);
                          popupScreen(context);
                        }).onError(
                          (error, stackTrace) {
                            if (kDebugMode) {
                              print(
                                error.toString(),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              alertmessage(
                                  context, 'Something went Wrong', errorColor),
                            );
                            setState(() {
                              loginProgress = false;
                            });
                          },
                        )
                      : null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 25 / MediaQuery.of(context).devicePixelRatio),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        nextScreen(
                          context,
                          const SignupScreen(),
                        );
                      },
                      child: Text(
                        "Don't Have an Account? Signup Here",
                        style: GoogleFonts.playfairDisplay(
                            color: textColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
