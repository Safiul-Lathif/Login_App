import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GridPage extends StatefulWidget {
  const GridPage({super.key});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  final numbers = List.generate(30, (index) => '$index');

  @override
  Widget build(BuildContext context) =>
      OrientationBuilder(builder: (context, orientation) {
        final isweb = MediaQuery.of(context).size.width > 700;
        final isPotrait = orientation == Orientation.portrait;
        return Scaffold(
            appBar: AppBar(
              title: const Text("Grid View"),
              backgroundColor: Colors.pink.shade400,
            ),
            body: isweb
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6),
                    ))
                : Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  fontSize: 60, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isPotrait ? 2 : 4),
                    )));
      });
}
