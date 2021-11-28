import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:flutter_template/src/views/auth/phone_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const _onboardingImages = [
    "https://picsum.photos/300?random=0",
    "https://picsum.photos/300?random=1",
    "https://picsum.photos/300?random=2",
    "https://picsum.photos/300?random=3",
  ];

  final _carouselController = CarouselController();
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grayColor[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.grayColor[200],
        actions: [
          CustomButton.child(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            customPadding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  'Skip',
                  style: CustomTheme.headline6(context, color: Palette.primaryColor),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneScreen(loginBloc: context.read<LoginBloc>())));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: .6.sh,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() => _currentImageIndex = index);
                },
              ),
              items: _onboardingImages.map((imageUrl) {
                return CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: MediaQuery.of(context).size.width,
                );
              }).toList(),
            ),
          ),
          Container(
            height: .4.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Height(48.0),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur.",
                    style: CustomTheme.headline4(context, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  const Height(18.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et lectus magna ac fames lacus condimentum.",
                      style: CustomTheme.headline6(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 48.0,
                    child: Row(
                      children: [
                        CustomButton.child(
                          customButtonType: CustomButtonType.faded,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          onPressed: () => _carouselController.previousPage(),
                          isEnabled: _currentImageIndex != 0,
                          child: const Icon(
                            FeatherIcons.arrowLeft,
                            color: Palette.primaryColor,
                          ),
                        ),
                        const Width(30.0),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _onboardingImages.asMap().entries.map((entry) {
                              final isSelected = entry.key == _currentImageIndex;

                              return GestureDetector(
                                onTap: () => _carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: isSelected ? 36.0 : 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isSelected ? Palette.primaryColor : Palette.grayColor[300],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        CustomButton(
                          customPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                          margin: EdgeInsets.zero,
                          isExpanded: false,
                          text: 'Next',
                          customButtonType: CustomButtonType.primary,
                          onPressed: () {
                            if (_currentImageIndex != _onboardingImages.length - 1) {
                              _carouselController.nextPage();
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneScreen(loginBloc: context.read<LoginBloc>())));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Height(MediaQuery.of(context).padding.bottom + 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
