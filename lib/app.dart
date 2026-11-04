import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/ui/results/view.dart';
import 'navigation.dart';
import 'store/path.dart';
import 'ui/home/cubit/home_cubit.dart';
import 'ui/home/view.dart';
import 'ui/preview/view.dart';
import 'ui/process/view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PathRepository(),
      child: BlocProvider(
        create: (context) => HomeCubit(context.read<PathRepository>())..init(),
        child: MaterialApp(
          title: 'Webspark test',
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              primary: Colors.blue,
            ),
          ),
          routes: {
            Routes.home: (context) => const HomeView(),
            Routes.process: (context) => const ProcessView(),
            Routes.results: (context) => const ResultsView(),
            Routes.preview: (context) => const PreviewView(),
          },
          initialRoute: Routes.home,
        ),
      ),
    );
  }
}
