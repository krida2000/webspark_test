import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modes/process.dart';
import '/domain/models/cell.dart';
import '/domain/models/grid.dart';
import '/domain/models/grid_result.dart';
import '/store/path.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit(this._pathRepository, this._grids, this._uri)
    : super(ProcessState());

  final PathRepository _pathRepository;

  final List<Grid> _grids;

  final Uri _uri;

  Future<void> computeGrids() async {
    emit(state.copyWith(status: .loading));

    try {
      List<GridResult?> results = [];
      for (int i = 0; i < _grids.length; i++) {
        results.add(await _compute(_grids[i]));

        if (isClosed) {
          return;
        }

        emit(state.copyWith(percentsCompleted: (i + 1) / _grids.length));
      }

      emit(
        state.copyWith(status: .success, results: results.nonNulls.toList()),
      );
    } catch (_) {
      emit(state.copyWith(status: .failure));
      rethrow;
    }
  }

  Future<void> sendResults() async {
    emit(state.copyWith(status: .loading));
    try {
      await _pathRepository.sendResults(_uri, state.results!);
    } catch (_) {
      emit(state.copyWith(status: .failure));
      rethrow;
    }

    emit(state.copyWith(status: .success));
  }

  Future<GridResult?> _compute(Grid grid) => compute((grid) {
    final List<Cell> visited = [grid.start];
    List<List<Cell>> paths = [
      [grid.start],
    ];
    List<Cell> availableCells(Cell cell, Grid grid, List<Cell> visited) {
      final List<Cell> result = [
        Cell(x: cell.x - 1, y: cell.y - 1),
        Cell(x: cell.x - 1, y: cell.y),
        Cell(x: cell.x - 1, y: cell.y + 1),
        Cell(x: cell.x, y: cell.y - 1),
        Cell(x: cell.x, y: cell.y + 1),
        Cell(x: cell.x + 1, y: cell.y - 1),
        Cell(x: cell.x + 1, y: cell.y),
        Cell(x: cell.x + 1, y: cell.y + 1),
      ];

      return result
          .where(
            (e) =>
                !visited.contains(e) &&
                e.x >= 0 &&
                e.y >= 0 &&
                grid.getCell(e.x, e.y)?.available == true,
          )
          .toList();
    }

    List<Cell>? result;

    while (result == null) {
      int visitedCount = visited.length;
      List<List<Cell>> pathsCopy = paths.toList();
      paths.clear();

      for (var path in pathsCopy) {
        List<Cell> available = availableCells(path.last, grid, visited);
        visited.addAll(available);

        if (available.any((e) => e == grid.end)) {
          result = path..add(grid.end);
          break;
        }

        paths.addAll(
          List.generate(
            available.length,
            (i) => path.toList()..add(available[i]),
          ),
        );
      }

      if (visitedCount == visited.length) {
        break;
      }
    }

    if (result != null) {
      return GridResult(grid: grid, steps: result);
    }

    return null;
  }, grid);
}
