import '/api/path.dart';
import '/domain/models/grid_result.dart';
import '/domain/models/grid.dart';

class PathRepository {
  final PathApi _api = PathApi();

  Future<List<Grid>> getGrids(Uri uri) async {
    return _api.getGrids(uri);
  }

  Future<void> sendResults(Uri uri, List<GridResult> results) =>
      _api.sendResults(uri, results);
}
