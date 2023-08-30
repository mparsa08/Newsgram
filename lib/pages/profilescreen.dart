import 'package:chat_app/data.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'myhomepage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var posts = AppDatabase.posts;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBar(themeData: themeData),
            _ProfileOverview(themeData: themeData),
            _PostsList(themeData: themeData, posts: posts)
          ],
        ),
      )),
    );
  }
}

class _ProfileOverview extends StatelessWidget {
  const _ProfileOverview({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 12, 32, 32),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 64),
            margin: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: themeData.colorScheme.onSurface.withOpacity(0.2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Assets.img.stories.story8.image(
                        width: 84,
                        height: 84,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '@khavier_belatoni',
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Parsa Kermanian',
                            style: themeData.textTheme.headlineMedium!
                                .copyWith(fontSize: 18),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Android Developer',
                            style: themeData.textTheme.titleMedium!.copyWith(
                                fontSize: 16, color: themeData.primaryColor),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'About me',
                  style: themeData.textTheme.headlineMedium,
                ),
                Text(
                  'I pride myself on writing high-quality code and maintainable systems that make lives easier across the technology stack: Java, Kotlin, C++, ReactNative, and Javascript. Special expertise in assessing risk and translating innovative ideas into technology solutions. Highlights include building the next generation of products leveraging frameworks, such as Android SDK, for Salesforce, and tackling complex problems related to large-scale backend infrastructure and mobile platforms.',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: themeData.textTheme.bodyMedium!.copyWith(
                      color: themeData.colorScheme.onSurface.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 32,
            left: 32,
            child: Container(
              height: 68,
              decoration: BoxDecoration(
                color: themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  _InsidBlueBox(
                    num: '56',
                    title: 'Post',
                    enable: true,
                  ),
                  _InsidBlueBox(
                    num: '250',
                    title: 'Folowing',
                    enable: false,
                  ),
                  _InsidBlueBox(
                    num: '4.5K',
                    title: 'Folowers',
                    enable: false,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 4, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: themeData.textTheme.headlineMedium,
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.ellipsis)),
        ],
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  const _PostsList({
    required this.themeData,
    required this.posts,
  });

  final ThemeData themeData;
  final List<PostData> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, -3),
              color: themeData.colorScheme.onSurface.withOpacity(0.2)),
          BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 3),
              color: themeData.colorScheme.surface),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'My Posts',
                style: themeData.textTheme.headlineMedium,
              )),
              Icon(
                CupertinoIcons.square_grid_2x2,
                color: themeData.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Icon(
                CupertinoIcons.list_bullet,
                color: themeData.colorScheme.onSurface.withOpacity(0.5),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ListView.builder(
            itemExtent: 141,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var post = posts[index];
              return Posts(post: post);
            },
          ),
        ],
      ),
    );
  }
}

class _InsidBlueBox extends StatelessWidget {
  const _InsidBlueBox({
    required this.num,
    required this.title,
    required this.enable,
  });
  final String num;
  final String title;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: enable
                  ? Colors.blue[900]
                  : Theme.of(context).colorScheme.primary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                num,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14, color: Theme.of(context).colorScheme.surface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
