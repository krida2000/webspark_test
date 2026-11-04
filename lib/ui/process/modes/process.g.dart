// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProcessStateCWProxy {
  ProcessState percentsCompleted(double percentsCompleted);

  ProcessState status(Status status);

  ProcessState results(List<GridResult>? results);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProcessState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProcessState(...).copyWith(id: 12, name: "My name")
  /// ```
  ProcessState call({
    double percentsCompleted,
    Status status,
    List<GridResult>? results,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProcessState.copyWith(...)` or call `instanceOfProcessState.copyWith.fieldName(value)` for a single field.
class _$ProcessStateCWProxyImpl implements _$ProcessStateCWProxy {
  const _$ProcessStateCWProxyImpl(this._value);

  final ProcessState _value;

  @override
  ProcessState percentsCompleted(double percentsCompleted) =>
      call(percentsCompleted: percentsCompleted);

  @override
  ProcessState status(Status status) => call(status: status);

  @override
  ProcessState results(List<GridResult>? results) => call(results: results);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `ProcessState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ProcessState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  ProcessState call({
    Object? percentsCompleted = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? results = const $CopyWithPlaceholder(),
  }) {
    return ProcessState(
      percentsCompleted:
          percentsCompleted == const $CopyWithPlaceholder() ||
              percentsCompleted == null
          ? _value.percentsCompleted
          // ignore: cast_nullable_to_non_nullable
          : percentsCompleted as double,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as Status,
      results: results == const $CopyWithPlaceholder()
          ? _value.results
          // ignore: cast_nullable_to_non_nullable
          : results as List<GridResult>?,
    );
  }
}

extension $ProcessStateCopyWith on ProcessState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProcessState.copyWith(...)` or `instanceOfProcessState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProcessStateCWProxy get copyWith => _$ProcessStateCWProxyImpl(this);
}
