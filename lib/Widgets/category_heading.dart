import 'package:naveenboutique/Packages/packages.dart';

class CategoryHeading extends StatelessWidget {
  CategoryHeading({super.key, required this.first, required this.last});
  String first, last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, MediaQuery.of(context).size.height * 0.01, 0, 0),
      child: Container(
        child: RichText(
          text: TextSpan(
            text: first,
            style: GoogleFonts.playfairDisplay(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: last,
                style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: buttonColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
