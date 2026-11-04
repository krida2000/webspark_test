import 'package:collection/collection.dart';

import 'cell.dart';

class Grid {
  Grid({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Grid.fromJson(Map<String, dynamic> json) {
    return Grid(
      id: json['id'],
      field: (json['field'] as List<dynamic>)
          .mapIndexed(
            (y, e) => (e as String)
                .split("")
                .mapIndexed((x, e) => Cell(x: x, y: y, available: e != 'X'))
                .toList(),
          )
          .toList(),
      start: Cell.fromJson(json['start'] as Map<String, dynamic>),
      end: Cell.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  String id;

  List<List<Cell>> field;

  Cell start;

  Cell end;

  Cell? getCell(int x, int y) => field.elementAtOrNull(y)?.elementAtOrNull(x);
}
