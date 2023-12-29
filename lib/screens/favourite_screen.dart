import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C',
      'A',
      'B',
      'C'
    ];
    final List<int> colorCodes = <int>[
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
      600,
      500,
      100,
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("this is sample title"),
            floating: true,
            flexibleSpace: Placeholder(),
            expandedHeight: 200,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => ListTile(
                    title: Text("hello"),
                  )))
        ],
      ),
      // body: Center(
      //   child: ListView.builder(
      //       padding: const EdgeInsets.all(8),
      //       itemCount: entries.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return Container(
      //           height: 50,
      //           color: Colors.amber[colorCodes[index]],
      //           child: Center(child: Text('Entry ${entries[index]}')),
      //         );
      //       }),
      // ),
    );
  }
}
