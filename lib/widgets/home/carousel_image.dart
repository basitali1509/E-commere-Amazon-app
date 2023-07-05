
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map(
          (i) {
            return Builder(
              builder: (BuildContext context) => ClipRRect(
                borderRadius: BorderRadius.circular(18), // Adjust the radius as per your preference
                child: Image.network(
                  i,
                  fit: BoxFit.fill,
                  height: 215,
                  width: 380,
                ),
              ),
            );
          },
        ).toList(),

        options: CarouselOptions(

          viewportFraction: 1.02,
          height: 215,

        ),

      ),
    );
  }
}
