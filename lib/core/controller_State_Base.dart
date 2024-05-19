import 'package:doc_edit_flutter/core/models/app_error.dart';
import 'package:equatable/equatable.dart';

class ControllerStateBase extends Equatable {

  const ControllerStateBase({this.error});
  final AppError? error;

  @override
  List<Object?> get props => [error];

  ControllerStateBase copyWith({AppError? error}) =>
      ControllerStateBase(error: error ?? this.error);
}
