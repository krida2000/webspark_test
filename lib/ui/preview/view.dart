import 'package:flutter/material.dart';

import '/domain/models/grid.dart';
import '/navigation.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PreviewViewArguments;

    Grid grid = args.result.grid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Preview screen'),
      ),
      body: Column(
        spacing: 15,
        children: [
          Table(
            border: TableBorder.all(width: 2),
            children: grid.field
                .map(
                  (row) => TableRow(
                    children: row
                        .map(
                          (e) => Container(
                            color: !e.available
                                ? Color(0xff000000)
                                : e == grid.start
                                ? Color(0xff64FFDA)
                                : e == grid.end
                                ? Color(0xff009688)
                                : args.result.steps.contains(e)
                                ? Color(0xff4CAF50)
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                  color: !e.available ? Colors.white : null,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
          Text(args.result.path),
        ],
      ),
    );
  }
}
