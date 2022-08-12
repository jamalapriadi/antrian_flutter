import 'package:equatable/equatable.dart';

abstract class AntrianState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAntrianState extends AntrianState {}

class LoadingAntrianState extends AntrianState {}

class FailureAntrianState extends AntrianState {
  final String errorMessage;

  FailureAntrianState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureAntrianState{errorMessage: $errorMessage}';
  }
}

class SuccessAntrianState extends AntrianState {
  final String success;
  final String message;
  final String noantrian;
  final String keperluan;

  SuccessAntrianState(
      this.success, this.message, this.noantrian, this.keperluan);

  @override
  List<Object> get props => [success, message, noantrian, keperluan];
}
