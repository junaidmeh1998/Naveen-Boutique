import 'package:naveenboutique/Packages/packages.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10 / MediaQuery.of(context).devicePixelRatio,
                vertical: 20 / MediaQuery.of(context).devicePixelRatio),
            child: CarouselSlider(
              items: slider_images
                  .map(
                    (item) => Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              carouselController: carouselController,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                scrollPhysics: const BouncingScrollPhysics(),
                viewportFraction: 1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
