import 'package:chat_app/pages/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data.dart';
import '../gen/assets.gen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final _onBordingitems = AppDatabase.onBoardingItem;
  final _pageControllerGet = Get.put(PageController());
  final page = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Assets.img.background.onboarding.image(),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: _onBordingitems.length,
                    controller: _pageControllerGet,
                    itemBuilder: (context, index) {
                      var items = _onBordingitems[index];
                      _pageControllerGet.addListener(() {
                        page.value = _pageControllerGet.page!.round();
                      });
                      return _OnBoardingScreenPageView(items: items);
                    },
                  ),
                ),
                _OnBoardingScreenPageIndicator(
                    pageControllerGet: _pageControllerGet,
                    onBordingitems: _onBordingitems,
                    page: page),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class _OnBoardingScreenPageIndicator extends StatelessWidget {
  const _OnBoardingScreenPageIndicator({
    required PageController pageControllerGet,
    required List<OnBoardingItem> onBordingitems,
    required this.page,
  })  : _pageControllerGet = pageControllerGet,
        _onBordingitems = onBordingitems;

  final PageController _pageControllerGet;
  final List<OnBoardingItem> _onBordingitems;
  final RxInt page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
              effect: ExpandingDotsEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  activeDotColor: Theme.of(context).colorScheme.primary),
              controller: _pageControllerGet,
              count: _onBordingitems.length),
          ElevatedButton(
              onPressed: () {
                if (page.value != _onBordingitems.length - 1) {
                  _pageControllerGet.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                } else {
                  Get.off(() => AuthScreen());
                }
              },
              style: const ButtonStyle().copyWith(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
                foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.onPrimary),
              ),
              child: Obx(
                () => Icon(page.value != _onBordingitems.length - 1
                    ? CupertinoIcons.arrow_right
                    : CupertinoIcons.checkmark_alt),
              ))
        ],
      ),
    );
  }
}

class _OnBoardingScreenPageView extends StatelessWidget {
  const _OnBoardingScreenPageView({
    required this.items,
  });

  final OnBoardingItem items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          Text(
            items.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    items.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
