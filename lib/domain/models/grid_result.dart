import 'cell.dart';
import 'grid.dart';

class GridResult {
  GridResult({required this.grid, required this.steps});

  Grid grid;

  List<Cell> steps;

  String get path => steps.map((e) => e.toString()).join('->');

  Map<String, dynamic> toJson() {
    return {
      'id': grid.id,
      'result': {'steps': steps.map((e) => e.toJson()).toList(), 'path': path},
    };
  }
}
