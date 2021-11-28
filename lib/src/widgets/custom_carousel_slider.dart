import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/imports.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  const Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

class CustomCarouselSlider extends StatefulWidget {
  final List<Slide> slides;
  final double itemHeight;

  const CustomCarouselSlider({
    Key key,
    @required this.slides,
    this.itemHeight = 200,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.width * 3 / 6,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: widget.slides
              .map((sliderItem) => CachedNetworkImage(
                    imageUrl: sliderItem.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: widget.itemHeight,
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 36.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12.0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.slides.map((sliderItem) {
              final isCurrent = widget.slides.indexOf(sliderItem) == currentIndex;

              return Container(
                margin: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? Palette.grayColor : Palette.grayColor[100],
                ),
                width: isCurrent ? 8.0 : 6.0,
                height: isCurrent ? 8.0 : 6.0,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
