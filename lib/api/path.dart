import 'package:dio/dio.dart';

import '/domain/models/grid_result.dart';
import '/domain/models/grid.dart';

class PathApi {
  final Dio _dio = Dio();

  Future<List<Grid>> getGrids(Uri uri) async {
    Response response = await _dio.getUri(uri);

    return ((response.data as Map<String, dynamic>)['data'] as List<dynamic>)
        .map((e) => Grid.fromJson(e))
        .toList();
  }

  Future<void> sendResults(Uri uri, List<GridResult> results) async {
    print(
      (await _dio.postUri(
        uri,
        data: results.map((e) => e.toJson()).toList(),
      )).data,
    );
  }
}
