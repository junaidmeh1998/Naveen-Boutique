import 'package:naveenboutique/Packages/packages.dart';

class threeContainerRow extends StatelessWidget {
  const threeContainerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 31,
          width: 106,
          alignment: Alignment.center,
          child: Text(
            "Orignal Products",
            style: GoogleFonts.playfairDisplay(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 31,
          width: 106,
          alignment: Alignment.center,
          child: Text(
            "All Over Pakistan",
            style: GoogleFonts.playfairDisplay(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 31,
          width: 106,
          alignment: Alignment.center,
          child: Text(
            "Easy Returns",
            style: GoogleFonts.playfairDisplay(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
