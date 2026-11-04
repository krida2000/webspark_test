import 'package:flutter/material.dart';

import '/navigation.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResultsViewArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Result list screen'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (_, i) => InkWell(
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(bottom: BorderSide()),
              ),
              alignment: .center,
              padding: EdgeInsets.all(20.0),
              child: Text(args.results[i].path),
            ),
            onTap: () => Navigator.of(context).pushNamed(
              Routes.preview,
              arguments: PreviewViewArguments(result: args.results[i]),
            ),
          ),
          itemCount: args.results.length,
        ),
      ),
    );
  }
}
