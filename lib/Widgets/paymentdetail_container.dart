import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailContainer extends StatelessWidget {
  PaymentDetailContainer(
      {super.key, required this.image_path, required this.ontap});
  Function()? ontap;
  String image_path;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 7, 10, 3),
        child: Container(
          width: 419,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: const AlignmentDirectional(0, 1),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          image_path,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      height: 43,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Text(
                          'Account Holder: Maira Naveen',
                          style: GoogleFonts.lato(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 196,
                      height: 34,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Text(
                        '0347 76227740',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
