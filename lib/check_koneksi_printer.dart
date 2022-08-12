import 'package:antrian_apk/cubit/printer/printer_cubit.dart';
import 'package:antrian_apk/cubit/printer/printer_state.dart';
import 'package:antrian_apk/setting_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckKoneksiPrinter extends StatefulWidget {
  const CheckKoneksiPrinter({Key? key}) : super(key: key);

  @override
  State<CheckKoneksiPrinter> createState() => _CheckKoneksiPrinterState();
}

class _CheckKoneksiPrinterState extends State<CheckKoneksiPrinter> {
  final printerCubit = PrinterCubit();

  @override
  void initState() {
    printerCubit.getPrinterConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrinterCubit>(
      create: (context) => printerCubit,
      child: BlocListener<PrinterCubit, PrinterState>(
        listener: (context, state) {
          if (state is FailureGetPrinterState) {}
        },
        child: BlocBuilder<PrinterCubit, PrinterState>(
          builder: (context, state) {
            if (state is FailureGetPrinterState) {
              return const SettingPrinter();
            } else if (state is GetPrinterConnectedState) {
              return Container();
            } else {
              return const SettingPrinter();
            }
          },
        ),
      ),
    );
  }
}
