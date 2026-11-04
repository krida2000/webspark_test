import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/models/grid.dart';
import '/navigation.dart';
import '/ui/widget/primary_button.dart';
import 'cubit/home_cubit.dart';
import 'modes/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Home screen'),
      ),
      body: SafeArea(
        child: BlocListener<HomeCubit, HomeState>(
          listenWhen: (prev, current) =>
              current.uri != null && _controller.text.isEmpty,
          listener: (_, HomeState state) {
            _controller.text = state.uri!.toString();
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const Text(
                          'Set valid API base URL in order to continue',
                        ),
                        SizedBox(height: 20),
                        Row(
                          spacing: 20,
                          children: [
                            Icon(Icons.compare_arrows, color: Colors.grey),
                            Expanded(
                              child: TextField(
                                enabled: state.status != .loading,
                                controller: _controller,
                                textCapitalization: .none,
                                onSubmitted: (_) => _submit,
                              ),
                            ),
                          ],
                        ),
                        if (state.getGridsException != null) ...[
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              state.getGridsException!.message,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                        Spacer(),
                        PrimaryButton(
                          onPressed: state.status == .loading
                              ? null
                              : () => _submit(context),
                          title: 'Start counting process',
                        ),
                      ],
                    ),
                  ),
                  if (state.status == .loading)
                    Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    HomeCubit cubit = context.read<HomeCubit>();
    List<Grid> grids = await cubit.getGrids(_controller.text);

    if (context.mounted) {
      Navigator.of(context).pushNamed(
        Routes.process,
        arguments: ProcessViewArguments(grids: grids, uri: cubit.state.uri!),
      );
    }
  }
}
