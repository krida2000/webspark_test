import '/domain/models/grid_result.dart';
import 'domain/models/grid.dart';

class Routes {
  static const home = '/home';
  static const preview = '/preview';
  static const process = '/process';
  static const results = '/results';
}

class ProcessViewArguments {
  ProcessViewArguments({required this.grids, required this.uri});

  List<Grid> grids;

  Uri uri;
}


class ResultsViewArguments {
  ResultsViewArguments({required this.results});

  List<GridResult> results;
}


class PreviewViewArguments {
  PreviewViewArguments({required this.result});

  GridResult result;
}
