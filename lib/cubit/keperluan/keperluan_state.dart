import 'package:equatable/equatable.dart';

abstract class KeperluanState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialKeperluanState extends KeperluanState {}

class LoadingKeperluanState extends KeperluanState {}

class FailureKeperluanState extends KeperluanState {
  final String errorMessage;

  FailureKeperluanState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureKeperluanState{errorMessage: $errorMessage}';
  }
}

class SuccessKeperluanState extends KeperluanState {
  final List<dynamic> listKeperluan;

  SuccessKeperluanState(this.listKeperluan);

  @override
  String toString() {
    return 'SuccessKeperluanState{listKeperluan: $listKeperluan}';
  }
}
