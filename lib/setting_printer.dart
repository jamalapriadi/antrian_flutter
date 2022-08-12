import 'package:antrian_apk/cubit/printer/printer_cubit.dart';
import 'package:antrian_apk/cubit/printer/printer_state.dart';
import 'package:antrian_apk/helpers/constant.dart';
import 'package:antrian_apk/home.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPrinter extends StatefulWidget {
  const SettingPrinter({Key? key}) : super(key: key);

  @override
  State<SettingPrinter> createState() => _SettingPrinterState();
}

class _SettingPrinterState extends State<SettingPrinter> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();
  final printerCubit = PrinterCubit();

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();

    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: false,
        backgroundColor: Warna.hijau,
        body: BlocProvider<PrinterCubit>(
          create: (context) => printerCubit,
          child: BlocListener<PrinterCubit, PrinterState>(
            listener: (context, state) {
              if (state is FailureGetPrinterState) {
              } else if (state is SuccessSetPrinterState) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Home(),
                //   ),
                // );
              }
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image.asset("assets/img/logo.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButton<BluetoothDevice>(
                              value: selectedDevice,
                              hint: Text(
                                "Select Thermal Printer",
                                style: TextStyle(color: Warna.hitam),
                              ),
                              items: devices
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                          e.name!,
                                          style: TextStyle(color: Warna.hitam),
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (device) {
                                setState(() {
                                  selectedDevice = device;
                                });
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  printer.connect(selectedDevice!);
                                  // printerCubit.konekPrinter(selectedDevice!);

                                  if ((await printer.isConnected)!) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(
                                          selectedDevice: selectedDevice!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text('Warning'),
                                              content: const Text(
                                                  "Printer belum terhubung"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'OK'),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ));
                                  }
                                },
                                child: const Text("Connect")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  printer.disconnect();
                                  // printerCubit.disconnectPrinter();
                                },
                                child: const Text("Disconnect"),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Warna.putih),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Warna.merah),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Warna.merah))))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<PrinterCubit, PrinterState>(
                    builder: (context, state) {
                  if (state is LoadingSetPrinterState) {
                    return Container(
                      color: Colors.black.withOpacity(.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ));
  }
}
