import 'package:naveenboutique/Packages/packages.dart';

class shippingTextField extends StatefulWidget {
  shippingTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.type,
      required this.validatior});

  final TextEditingController controller;
  String hinttext;
  TextInputType? type;
  String? Function(String?)? validatior;

  @override
  State<shippingTextField> createState() => _shippingTextFieldState();
}

class _shippingTextFieldState extends State<shippingTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: widget.controller,
      keyboardType: widget.type,
      validator: widget.validatior,
      onSaved: (value) {
        widget.controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: widget.hinttext,
      ),
    );
  }
}
