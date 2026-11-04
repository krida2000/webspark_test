import 'package:copy_with_extension/copy_with_extension.dart';

import '/domain/models/grid_result.dart';

part 'process.g.dart';

@CopyWith()
class ProcessState {
  ProcessState({
    this.percentsCompleted = 0,
    this.status = .initial,
    this.results,
  });

  List<GridResult>? results;

  double percentsCompleted;

  Status status;
}

enum Status { initial, loading, success, failure }

abstract class MessageException implements Exception {
  String get message;
}
