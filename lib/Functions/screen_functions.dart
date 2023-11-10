import 'package:naveenboutique/Packages/packages.dart';

void nextScreen(BuildContext context, screenName) {
  // Within the `FirstRoute` widget
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screenName),
  );
}

void popupScreen(context) {
  // Within the SecondRoute widget
  Navigator.pop(context);
}

void nextScreenReplace(context, screenName) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => screenName,
    ),
  );
}

alertmessage(context, text1, color) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Container(
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 20 / MediaQuery.of(context).devicePixelRatio),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(text1,
                style: GoogleFonts.playfairDisplay(
                    color: Colors.white, fontSize: 15)),
            SizedBox(
              height: 20 / MediaQuery.of(context).devicePixelRatio,
            ),
            // Text(text2,
            //     style: GoogleFonts.playfairDisplay(
            //         color: Colors.white, fontSize: 15))
          ],
        ),
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
