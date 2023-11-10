import 'package:naveenboutique/Packages/packages.dart';

class CategorieRow extends StatelessWidget {
  CategorieRow({
    super.key,
    required this.text,
    required this.file_path,
    required this.ontap,
  });

  String text;
  String file_path;
  Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(25), // Image radius
              child: Image.asset(file_path, fit: BoxFit.cover),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.playfairDisplay(
                fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
