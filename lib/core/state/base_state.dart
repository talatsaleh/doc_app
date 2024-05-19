
import 'package:doc_edit_flutter/core/models/app_error.dart';
import 'package:equatable/equatable.dart';

class StateBase extends Equatable {
  final AppError? error;
  const StateBase(this.error);

  @override
  List<Object?> get props => [error];

}