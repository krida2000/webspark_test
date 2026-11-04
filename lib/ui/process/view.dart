import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/navigation.dart';
import '/store/path.dart';
import '/ui/process/modes/process.dart';
import '/ui/widget/primary_button.dart';

import 'cubit/process_cubit.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProcessViewArguments;

    return BlocProvider(
      create: (context) =>
          ProcessCubit(context.read<PathRepository>(), args.grids, args.uri)
            ..computeGrids(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Process screen'),
        ),
        body: BlocBuilder<ProcessCubit, ProcessState>(
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: .center,
                  spacing: 15,
                  children: [
                    Spacer(),
                    if (state.status == .loading && state.results == null)
                      Text('Calculation...')
                    else if (state.status == .failure && state.results == null)
                      Text(
                        'An error occurred while calculation',
                        textAlign: .center,
                        style: TextStyle(color: Colors.red),
                      )
                    else
                      Text(
                        'All calculation has finished, you can send your result to server',
                        textAlign: .center,
                      ),
                    Text('${(state.percentsCompleted * 100).round()}%'),
                    CircularProgressIndicator(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 100,
                      ),
                      value: state.percentsCompleted,
                    ),
                    Spacer(),
                    PrimaryButton(
                      onPressed: state.status == .success
                          ? () async {
                              await context.read<ProcessCubit>().sendResults();

                              if (context.mounted) {
                                Navigator.of(context).pushNamed(
                                  Routes.results,
                                  arguments: ResultsViewArguments(
                                    results: state.results!,
                                  ),
                                );
                              }
                            }
                          : null,
                      title: 'Send results to server',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
