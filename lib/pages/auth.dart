import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final _islogin = false.obs;
  final _isobscure = false.obs;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Assets.img.icons.logo
              .svg(height: 200, width: 200, fit: BoxFit.scaleDown),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: themeData.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          _islogin.value = false;
                        },
                        child: Obx(
                          () => Text(
                            'LOGIN',
                            style: _islogin.value
                                ? themeData.textTheme.headlineSmall!.apply(
                                    color: themeData.colorScheme.onPrimary
                                        .withOpacity(0.5))
                                : themeData.textTheme.headlineSmall!.apply(
                                    color: themeData.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _islogin.value = true;
                        },
                        child: Obx(
                          () => Text('SIGN UP',
                              style: _islogin.value
                                  ? themeData.textTheme.headlineSmall!.apply(
                                      color: themeData.colorScheme.onPrimary)
                                  : themeData.textTheme.headlineSmall!.apply(
                                      color: themeData.colorScheme.onPrimary
                                          .withOpacity(0.5))),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                      child: SingleChildScrollView(
                        child: Obx(
                          () => AnimatedCrossFade(
                              firstChild: _Login(
                                themeData: themeData,
                                isobscure: _isobscure,
                              ),
                              secondChild: _SignUp(
                                themeData: themeData,
                                isobscure: _isobscure,
                              ),
                              crossFadeState: _islogin.value
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 500)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp({
    required this.themeData,
    required this.isobscure,
  });
  final RxBool isobscure;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Welcome to Newsgram!",
              style: themeData.textTheme.headlineMedium,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Create your Acount',
              style:
                  themeData.textTheme.titleMedium!.apply(fontSizeFactor: 0.8),
            ),
          ],
        ),
        const TextField(
          decoration: InputDecoration(
            label: Text('Realname'),
          ),
        ),
        const TextField(
          decoration: InputDecoration(
            label: Text('Username'),
          ),
        ),
        Obx(
          () => TextField(
            obscureText: isobscure.value,
            autocorrect: false,
            decoration: InputDecoration(
              suffix: TextButton(
                onPressed: () {
                  isobscure.toggle();
                },
                child: isobscure.value
                    ? const Text(
                        'Show',
                      )
                    : const Text('Hide'),
              ),
              label: const Text('Password'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(MainPage());
                },
                child: Text(
                  'SIGN UP',
                  style: themeData.textTheme.titleMedium!
                      .apply(color: themeData.colorScheme.onPrimary),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('OR SIGN UP WITH'),
          ],
        ),
        const _SigninWith()
      ],
    );
  }
}

class _Login extends StatelessWidget {
  const _Login({
    required this.themeData,
    required this.isobscure,
  });

  final ThemeData themeData;
  final RxBool isobscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Welcome Back",
              style: themeData.textTheme.headlineMedium,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Sign in with your account',
              style:
                  themeData.textTheme.titleMedium!.apply(fontSizeFactor: 0.8),
            ),
          ],
        ),
        const TextField(
          decoration: InputDecoration(
            label: Text('Username'),
          ),
        ),
        Obx(
          () => TextField(
            obscureText: isobscure.value,
            autocorrect: false,
            decoration: InputDecoration(
              suffix: TextButton(
                onPressed: () {
                  isobscure.toggle();
                },
                child: isobscure.value
                    ? const Text(
                        'Show',
                      )
                    : const Text('Hide'),
              ),
              label: const Text('Password'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.off(() => MainPage());
                },
                child: Text(
                  'LOGIN',
                  style: themeData.textTheme.titleMedium!
                      .apply(color: themeData.colorScheme.onPrimary),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Forgot your password?'),
            TextButton(onPressed: () {}, child: const Text('Reset here'))
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('OR SIGN IN WITH'),
          ],
        ),
        const _SigninWith()
      ],
    );
  }
}

class _SigninWith extends StatelessWidget {
  const _SigninWith();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SigninWithApi(
          child: Assets.img.icons.google.image(width: 24, height: 24),
        ),
        _SigninWithApi(
          child: Assets.img.icons.facebook.image(width: 24, height: 24),
        ),
        _SigninWithApi(
          child: Assets.img.icons.twitter.image(width: 24, height: 24),
        )
      ],
    );
  }
}

class _SigninWithApi extends StatelessWidget {
  final Widget? child;
  const _SigninWithApi({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: InkWell(onTap: () {}, child: child),
    );
  }
}
