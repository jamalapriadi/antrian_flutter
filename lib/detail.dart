import 'package:antrian_apk/cubit/antrian/antrian_cubit.dart';
import 'package:antrian_apk/cubit/antrian/antrian_state.dart';
import 'package:antrian_apk/cubit/keperluan/keperluan_cubit.dart';
import 'package:antrian_apk/cubit/keperluan/keperluan_state.dart';
import 'package:antrian_apk/helpers/constant.dart';
import 'package:antrian_apk/home.dart';
import 'package:antrian_apk/main.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detail extends StatefulWidget {
  BluetoothDevice selectedDevice;
  String id;
  String nama;

  Detail(
      {Key? key,
      required this.selectedDevice,
      required this.id,
      required this.nama})
      : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();
  final keperluanCubit = KeperluanCubit();
  final antrianCubit = AntrianCubit();

  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    keperluanCubit.listKeperluan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldState,
          resizeToAvoidBottomInset: false,
          backgroundColor: Warna.hijau,
          body: BlocProvider<AntrianCubit>(
            create: (context) => antrianCubit,
            child: BlocListener<AntrianCubit, AntrianState>(
              listener: (context, state) {
                if (state is FailureAntrianState) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content: Text(state.errorMessage),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else if (state is SuccessAntrianState) {
                  //print disini
                  // print('sukses disini');
                  // print(state.noantrian.toString());
                  // print(state.keperluan.toString());

                  printer.printNewLine();
                  printer.printCustom('Pengadilan Agama Tegal', 2, 1);
                  printer.printNewLine();
                  printer.printCustom('No. Antrian', 1, 1);
                  printer.printCustom(state.noantrian.toString(), 3, 1);
                  printer.printCustom('Keperluan', 1, 1);
                  printer.printCustom(state.keperluan.toString(), 2, 1);
                  printer.printCustom('Terima Kasih', 0, 1);
                  // printer.printCustom(message, size, align);
                  // printer.printQRcode('Thermal Printer Demo', 200, 200, 1);
                  printer.printNewLine();
                  printer.printNewLine();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(
                        selectedDevice: widget.selectedDevice,
                      ),
                    ),
                  );
                }
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: formState,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 90),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 48,
                            ),
                            Center(
                                child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 48.0,
                              child: Image.asset("assets/img/logo.png"),
                            )),
                            const SizedBox(
                              height: 18,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: Text(
                                    widget.nama.toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Warna.putih),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Warna.hitam),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Warna.hitam)))),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildKeperluanList(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Kembali",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Warna.putih),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Warna.abutua),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Warna.abutua)))),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainPage()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<AntrianCubit, AntrianState>(
                    builder: (context, state) {
                      if (state is LoadingAntrianState) {
                        return Container(
                          color: Colors.black.withOpacity(.5),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildKeperluanList() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: BlocProvider<KeperluanCubit>(
        create: (context) => keperluanCubit,
        child: BlocListener<KeperluanCubit, KeperluanState>(
          listener: (context, state) {
            if (state is FailureKeperluanState) {
            } else if (state is SuccessKeperluanState) {}
          },
          child: BlocBuilder<KeperluanCubit, KeperluanState>(
            builder: (context, state) {
              if (state is SuccessKeperluanState) {
                // var lkeperluan = state.listKeperluan;
                List<dynamic>? lkeperluan = state.listKeperluan;
                return _keperluanList(lkeperluan);
              } else if (state is LoadingKeperluanState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _keperluanList(List<dynamic> keperluanList) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: keperluanList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold),
                        backgroundColor: Warna.putih),
                    onPressed: () {
                      antrianCubit.buatAntrian(widget.id.toString(),
                          keperluanList[index].id.toString());
                    },
                    child: Text(
                      keperluanList[index].nama.toString(),
                      style: TextStyle(color: Warna.hitam),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
