import 'package:naveenboutique/Packages/packages.dart';

Widget shimmerHomeScreen(
  context,
) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.4,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600,
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.015,
              vertical: MediaQuery.of(context).size.height * 0.015),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            width: MediaQuery.of(context).size.width * 0.46,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.green,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          height: 200,
                        ))),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Shimmer.fromColors(
                                    baseColor: Colors.black,
                                    highlightColor: Colors.green,
                                    child: Container(
                                      color: Colors.white,
                                      height: 10,
                                    ))),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.green,
                                child: Container(
                                  color: Colors.white,
                                  height: 10,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                                flex: 1,
                                child: Shimmer.fromColors(
                                    baseColor: Colors.black,
                                    highlightColor: Colors.green,
                                    child: const Icon(Icons.favorite_border))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
