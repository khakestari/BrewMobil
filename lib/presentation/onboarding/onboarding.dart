import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/routes_manager.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<Slider> _list = _getSliderData();
  PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  List<Slider> _getSliderData() => [
        Slider(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1,
            ImageAssets.onboardingLogo1),
        Slider(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2,
            ImageAssets.onboardingLogo2),
        Slider(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3,
            ImageAssets.onboardingLogo3),
        Slider(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4,
            ImageAssets.onboardingLogo4)
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.darkPrimary,
      // appBar: AppBar(
      //   elevation: AppSize.s1_5,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: ColorManager.darkPrimary,
      //     statusBarBrightness: Brightness.dark,
      //     statusBarIconBrightness: Brightness.dark,
      //   ),
      // ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
      ),
      bottomSheet: Container(
        color: ColorManager.darkPrimary,
        height: AppSize.s100,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      _currentIndex == _list.length - 1
                          ? 'Let\'s go'
                          : AppStrings.skip,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                _getBottomSheetWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: _currentIndex == 0
                      ? null
                      : SvgPicture.asset(ImageAssets.leftArrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    _getPreviousIndex(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut,
                  );
                },
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < _list.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightarrowIc),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    _getNextIndex(),
                    duration:
                        const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceIn,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getPreviousIndex() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  int _getNextIndex() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc, width: 10);
    }
    return SvgPicture.asset(ImageAssets.solidCircleIc, width: 7);
  }
}

class OnBoardingPage extends StatelessWidget {
  Slider? _sliderObject;
  OnBoardingPage(this._sliderObject);
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSize.s100),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject!.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject!.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: AppSize.s130),
        SvgPicture.asset(
          _sliderObject!.image,
          // width: 350,
          height: deviceSize.width * 0.65,
        ),
      ],
    );
  }
}

class Slider {
  String title;
  String subtitle;
  String image;
  Slider(this.title, this.subtitle, this.image);
}
