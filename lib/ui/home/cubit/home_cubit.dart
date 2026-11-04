import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/domain/models/grid.dart';
import '/store/path.dart';
import '../modes/home.dart';

final RegExp urlRegExp = RegExp(
  r'(https?://)?([a-z0-9\-_]{2,256}\.)+(?<domain>(xn--[a-z0-9]{2,16}(?:-[a-z]{3})?)|[a-z]{2,16})(?<port>:\d{1,5})?(/([.!?]?[^\s.!?])*)?',
  caseSensitive: false,
);

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._pathRepository) : super(HomeState());

  final PathRepository _pathRepository;

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  Future<void> init() async {
    String? stringUri = await _asyncPrefs.getString('uri');

    if (stringUri != null) {
      Uri? uri = Uri.tryParse(stringUri);

      if (uri != null) {
        emit(state.copyWith(uri: uri));
      }
    }
  }

  Future<List<Grid>> getGrids(String stringUri) async {
    _asyncPrefs.setString('uri', stringUri);

    Uri? uri;
    try {
      if (!urlRegExp.hasMatch(stringUri)) {
        throw UriFormatException();
      }

      if (!stringUri.startsWith(RegExp(r'https?://'))) {
        stringUri = 'https://$stringUri';
      }

      uri = Uri.parse(stringUri);
    } catch (_) {
      emit(state.copyWith(getGridsException: UriFormatException()));
      rethrow;
    }

    emit(state.copyWith(getGridsException: null, uri: uri, status: .loading));

    List<Grid> grids;
    try {
      grids = await _pathRepository.getGrids(uri);
    } catch (_) {
      emit(
        state.copyWith(getGridsException: RequestException(), status: .failure),
      );
      rethrow;
    }

    emit(state.copyWith(status: .success));

    return grids;
  }
}
