import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class BaseState extends Equatable {
  const BaseState({
    this.status = StateStatus.initial,
  });

  final StateStatus status;

  @override
  List<Object?> get props => [
        status,
      ];
}

enum StateStatus { initial, loading, loaded, error }

extension BaseStateExtension on BaseState {
  bool get isLoaded => status == StateStatus.loaded;
  bool get isError => status == StateStatus.error;
  bool get isLoading => status == StateStatus.loading;
  bool get isInitial => status == StateStatus.initial;
}
