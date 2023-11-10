import 'package:flutter/foundation.dart';
import 'package:naveenboutique/Packages/packages.dart';
import 'package:naveenboutique/main.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool submit_true = false;
  _submit() {
    final isValid = signupformKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    signupformKey.currentState?.save();
    setState(() {
      submit_true = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Form(
            key: signupformKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset("assets/Naveen Boutique new logo.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "SIGNUP",
                  style: GoogleFonts.playfairDisplaySc(
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                textfields(
                    controller: nameController,
                    text: "Full Name",
                    obsecuretext: false),
                textfields(
                  controller: emailController,
                  text: 'Email',
                  obsecuretext: false,
                ),
                textfields(
                    controller: passwordController,
                    text: "Password",
                    obsecuretext: true),
                textfields(
                    obsecuretext: false,
                    controller: phonenocontroller,
                    text: 'Phone Number'),
                textfields(
                    obsecuretext: false,
                    controller: postalcodeController,
                    text: 'Postal Code'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Button(
                  text: 'SIGNUP',
                  ontap: () async {
                    await _submit();
                    submit_true
                        ? signUpUser(
                                nameController.text.toString(),
                                nameController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString(),
                                phonenocontroller.text.toString(),
                                postalcodeController.text.toString())
                            .then((value) async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                alertmessage(context, 'Successfully Registered',
                                    buttonColor));
                            await cartprovider.storeSignupDetails(
                                nameController.text.toString(),
                                emailController.text.toString(),
                                phonenocontroller.text.toString());
                            popupScreen(context);
                            if (kDebugMode) {
                              print('function executed');
                            }
                          }).onError(
                            (error, stackTrace) {
                              if (kDebugMode) {
                                print(
                                  error.toString(),
                                );
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                alertmessage(context,
                                    'Email is already Registered', errorColor),
                              );
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
                            const LoginScreen(),
                          );
                        },
                        child: Text(
                          "Already have an Account? Login Here",
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
      ),
    );
  }
}
