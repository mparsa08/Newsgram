import 'package:chat_app/data.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:chat_app/pages/profilescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var article = AppDatabase.posts[0];
    var themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(article.isBookmarked
                  ? CupertinoIcons.hand_thumbsup
                  : CupertinoIcons.hand_thumbsup_fill),
              const SizedBox(width: 5),
              Text(
                article.likes,
                style: themeData.textTheme.labelSmall!.copyWith(
                    fontSize: 16, color: themeData.colorScheme.onPrimary),
              ),
            ],
          )),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(themeData: themeData, title: 'Articles'),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Four Things Every Women Needs To Know',
                      style: themeData.textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Assets.img.stories.story3
                              .image(width: 50, height: 50),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Parsa Kermanian'),
                                SizedBox(height: 10),
                                Text('2min ago'),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  color: themeData.colorScheme.primary,
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  CupertinoIcons.bookmark,
                                  color: themeData.colorScheme.primary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    child: Assets.img.background.article
                        .image(fit: BoxFit.scaleDown),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    child: Text(
                      'My special message to all women and young girls around the world, specifically to the women of Afghanistan, on this International Women’s Day.',
                      style: themeData.textTheme.headlineMedium!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                    child: Text(
                      '''1. Put yourself first. By putting yourself first and not ignoring your needs, you can better help others and your family. 
        
        2. Love yourself first. In order to get stronger and be able to love your family and friends, you must first love yourself. Find peace within yourself to love and accept who you are.  
        
        3. Teach people how to respect and treat you. Women often overlook this, but you can teach people how to respect you by your own actions and attitudes toward yourself.
        
        4. Understand your worth and value. It is important to be confident in your love for yourself as you are worthy and fabulous. Be your authentic self and don’t worry what others think of you. 
        
        5. Prioritize your professional development. If you are a woman who constantly strives for greatness, make sure to invest in your professional development. No matter where you might be in your career, there is always room for improvement. Treat career development as part of your daily life. Learning, growing and expanding your skills everyday can build your confidence. ''',
                      style: themeData.textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 116,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        themeData.colorScheme.surface,
                        themeData.colorScheme.surface.withOpacity(0),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
