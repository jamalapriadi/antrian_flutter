import 'package:equatable/equatable.dart';

abstract class PrinterState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPrinterState extends PrinterState {}

class GetPrinterConnectedState extends PrinterState {}

class LoadingPrinterState extends PrinterState {}

class LoadingSetPrinterState extends PrinterState {}

class FailureGetPrinterState extends PrinterState {
  final String errorMessage;

  FailureGetPrinterState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureGetPrinterState{errorMessage: $errorMessage}';
  }
}

class SuccessSetPrinterState extends PrinterState {
  final String message;

  SuccessSetPrinterState(this.message);

  @override
  List<Object> get props => [message];
}

class RemovePrinterState extends PrinterState {}
