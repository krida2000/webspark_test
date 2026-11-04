import 'package:copy_with_extension/copy_with_extension.dart';

part 'home.g.dart';

@CopyWith()
class HomeState {
  HomeState({this.uri, this.getGridsException, this.status = .initial});

  Uri? uri;

  MessageException? getGridsException;

  Status status;
}

enum Status { initial, loading, success, failure }

abstract class MessageException implements Exception {
  String get message;
}

class UriFormatException implements MessageException {
  @override
  String get message => 'An error occurred while URL parsing';
}

class RequestException implements MessageException {
  @override
  String get message =>
      'An error occurred while request, try again later or provide another URL';
}
