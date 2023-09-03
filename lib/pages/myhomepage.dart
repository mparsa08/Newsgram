import 'package:chat_app/pages/articlescreen.dart';
import 'package:chat_app/pages/profilescreen.dart';
import 'package:chat_app/pages/searchscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../data.dart';
import '../gen/assets.gen.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _selectedNavBarItem = 0.obs;
  final List _navbarHistory = [];

  final GlobalKey<NavigatorState> homePageNavKey = GlobalKey();
  final GlobalKey<NavigatorState> articlePageNavKey = GlobalKey();
  final GlobalKey<NavigatorState> searchPageNavKey = GlobalKey();
  final GlobalKey<NavigatorState> profilePageNavKey = GlobalKey();

  late final navmap = {
    0: homePageNavKey,
    1: articlePageNavKey,
    2: searchPageNavKey,
    3: profilePageNavKey
  };
  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedNavigationstate =
        navmap[_selectedNavBarItem]!.currentState!;

    if (currentSelectedNavigationstate.canPop()) {
      currentSelectedNavigationstate.pop();
      return false;
    } else if (_navbarHistory.isNotEmpty) {
      _selectedNavBarItem.value = _navbarHistory.last;
      _navbarHistory.removeLast();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Stack(
            children: [
              Positioned.fill(
                bottom: 30,
                top: 5,
                right: 4,
                left: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(color: Color(0xaa0D253C), blurRadius: 20)
                    ],
                  ),
                ),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTag2',
                elevation: 0,
                shape: const CircleBorder(
                  side: BorderSide(
                    strokeAlign: 0,
                    color: Colors.white,
                    width: 5,
                  ),
                ),
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
          bottomNavigationBar: _BottomNavBar(
            selectedNavBarItem: _selectedNavBarItem,
            navbarHistory: _navbarHistory,
          ),
          body: Obx(
            () => IndexedStack(
              index: _selectedNavBarItem.value,
              children: [
                _customNavigator(
                    key: homePageNavKey, tabIndex: 0, child: const HomePage()),
                _customNavigator(
                    key: articlePageNavKey,
                    tabIndex: 1,
                    child: const ArticleScreen()),
                _customNavigator(
                    key: searchPageNavKey,
                    tabIndex: 2,
                    child: const SearchScreen(tabName: 'Search')),
                _customNavigator(
                    key: profilePageNavKey,
                    tabIndex: 3,
                    child: const ProfileScreen()),
              ],
            ),
          )),
    );
  }

  Widget _customNavigator(
      {required GlobalKey key, required int tabIndex, required Widget child}) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Offstage(
              offstage: _selectedNavBarItem.value != tabIndex,
              child: child,
            );
          },
        );
      },
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required RxInt selectedNavBarItem,
    required navbarHistory,
  })  : _selectedNavBarItem = selectedNavBarItem,
        _navbarHistory = navbarHistory;

  final RxInt _selectedNavBarItem;
  final List _navbarHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              blurRadius: 20),
        ],
      ),
      child: Obx(
        () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedNavBarItem.value,
            onTap: (value) {
              _navbarHistory.remove(_selectedNavBarItem.value);
              _navbarHistory.add(_selectedNavBarItem.value);
              _selectedNavBarItem.value = value;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.img.icons.home.path,
                    width: 24,
                    height: 24,
                    color: Colors.blueGrey,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.img.icons.articles.path,
                    width: 24,
                    height: 24,
                  ),
                  label: 'Articles'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.img.icons.search.path,
                    width: 24,
                    height: 24,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.img.icons.menu.path,
                    width: 24,
                    height: 24,
                  ),
                  label: 'Menu'),
            ]),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stories = AppDatabase.stories;
    final themeContext = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Parsa!',
                      style: themeContext.textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Assets.img.icons.notification.image(
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      'Explore today\'s',
                      style: themeContext.textTheme.headlineMedium,
                    )
                  ],
                ),
              ),
              _StoryList(stories: stories, themeContext: themeContext),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: _CategoryList(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: _PostList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  _CategoryList({
    Key? key,
  }) : super(key: key);
  final _category = AppDatabase.categories;

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return _Category(category: _category, themeContext: themeContext);
  }
}

class _Category extends StatelessWidget {
  const _Category({
    Key? key,
    required List<Category> category,
    required this.themeContext,
  })  : _category = category,
        super(key: key);

  final List<Category> _category;
  final ThemeData themeContext;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _category.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: realIndex == index
              ? const EdgeInsets.fromLTRB(32, 0, 0, 0)
              : const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
            children: [
              Positioned.fill(
                  top: 100,
                  left: 65,
                  right: 65,
                  bottom: 12,
                  child: Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Color(0xaa0D253C), blurRadius: 20)
                    ]),
                  )),
              Positioned.fill(
                child: Container(
                  foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(
                          colors: [Color(0xff0d253C), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center)),
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/img/posts/large/${_category[index].imageFileName}'),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                child: Text(
                  _category[realIndex].title,
                  style: themeContext.textTheme.headlineSmall,
                ),
              )
            ],
          ),
        );
      },
      options: CarouselOptions(
        padEnds: false,
        enlargeFactor: 0.3,
        viewportFraction: 0.75,
        aspectRatio: 1.2,
        initialPage: 0,
        disableCenter: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    Key? key,
    required this.stories,
    required this.themeContext,
  }) : super(key: key);

  final List<StoryData> stories;
  final ThemeData themeContext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 110,
      child: _Story(stories: stories, themeContext: themeContext),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    Key? key,
    required this.stories,
    required this.themeContext,
  }) : super(key: key);

  final List<StoryData> stories;
  final ThemeData themeContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stories.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var story = stories[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                story.isViewed
                    ? _profileImageViewed(index)
                    : _profileImageNormal(index),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/img/icons/${story.iconFileName}',
                      width: 30,
                      height: 30,
                    ))
              ],
            ),
            Text(
              story.name,
              style: themeContext.textTheme.bodyMedium,
            )
          ],
        );
      },
    );
  }

  Widget _profileImageViewed(int index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      margin: index == 0
          ? const EdgeInsets.only(left: 32, top: 4, right: 4)
          : const EdgeInsets.only(left: 4, top: 4, right: 4),
      width: 80,
      height: 80,
      child: DottedBorder(
        padding: const EdgeInsets.all(1),
        borderType: BorderType.RRect,
        radius: const Radius.circular(24),
        strokeWidth: 2,
        dashPattern: const [
          8,
          3,
        ],
        color: const Color(0xff7B8BB2),
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: _profilePic(index),
        ),
      ),
    );
  }

  Widget _profileImageNormal(int index) {
    return Container(
      margin: index == 0
          ? const EdgeInsets.only(left: 32, top: 4, right: 4)
          : const EdgeInsets.only(left: 4, top: 4, right: 4),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
            colors: [Color(0xfff9ce34), Color(0xffee2a7b), Color(0xff6228d7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: _profilePic(index),
      ),
    );
  }

  Widget _profilePic(int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Image.asset(
          'assets/img/stories/${stories[index].imageFileName}',
          width: 60,
          height: 60,
        ));
  }
}

class _PostList extends StatelessWidget {
  _PostList();
  final _posts = AppDatabase.posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest News',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'More',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemExtent: 141,
          itemCount: _posts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var post = _posts[index];
            return Posts(post: post);
          },
        )
      ],
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (post.id == 0) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const ArticleScreen();
            },
          ));
        } else if (post.id == 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const SearchScreen(tabName: 'Home');
            },
          ));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2))
            ]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:
                  Image.asset('assets/img/posts/small/${post.imageFileName}'),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 18,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post.likes,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          CupertinoIcons.clock,
                          size: 18,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post.time,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              post.isBookmarked
                                  ? Icon(
                                      CupertinoIcons.bookmark_fill,
                                      size: 18,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color,
                                    )
                                  : Icon(
                                      CupertinoIcons.bookmark,
                                      size: 18,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.6),
                                    ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
