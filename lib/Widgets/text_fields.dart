import 'package:naveenboutique/Packages/packages.dart';

class textfields extends StatelessWidget {
  textfields(
      {required this.obsecuretext,
      required this.controller,
      this.onchnaged,
      this.inputtype,
      required this.text});
  String text;
  final bool obsecuretext;
  void Function(String)? onchnaged;
  late TextInputType? inputtype;
  TextEditingController controller = TextEditingController();
  Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        keyboardType: inputtype,
        onChanged: onchnaged,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          }
          return null;
        },
        obscureText: obsecuretext,
        style: GoogleFonts.lato(color: textColor),
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textFieldBorderColor),
              borderRadius: BorderRadius.circular(10.0)),
          fillColor: bgColor,
          isDense: true, // Added this
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
