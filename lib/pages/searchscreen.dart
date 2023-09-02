import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.tabName, this.screenNumber = 0});
  final String tabName;
  final int screenNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text('Search'),
              titleSpacing: 32,
            )
          ];
        },
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Tab : $tabName Number : $screenNumber'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SearchScreen(
                          tabName: tabName,
                          screenNumber: screenNumber + 1,
                        );
                      },
                    ));
                  },
                  child: const Text('click me'))
            ],
          ),
        ),
      ),
    );
  }
}
