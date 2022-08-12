import 'package:antrian_apk/cubit/printer/printer_state.dart';
import 'package:antrian_apk/repositories/antrian_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class PrinterCubit extends Cubit<PrinterState> {
  PrinterCubit() : super(InitialPrinterState());

  AntrianRepository antrianRepository = AntrianRepository();

  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  void getPrinterConnected() async {
    antrianRepository.getPrinter();
  }

  void konekPrinter(BluetoothDevice device) async {
    emit(LoadingSetPrinterState());
    printer.connect(device);
    antrianRepository.setPrinter(device);
    emit(SuccessSetPrinterState('success'));
  }

  void disconnectPrinter() async {
    printer.disconnect();
    antrianRepository.removePrinter();
    emit(RemovePrinterState());
  }

  void cetakNoAntrian(String noantrian, String keperluan) async {}
}
