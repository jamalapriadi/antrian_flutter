import 'package:antrian_apk/detail.dart';
import 'package:antrian_apk/helpers/constant.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  BluetoothDevice selectedDevice;

  Home({Key? key, required this.selectedDevice}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldState = GlobalKey<FormState>();
  final formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      resizeToAvoidBottomInset: false,
      backgroundColor: Warna.hijau,
      body: Stack(
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
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    _buildUmumButton(),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildDifabelButton()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUmumButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text(
          "Umum".toUpperCase(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Warna.hitam),
            backgroundColor: MaterialStateProperty.all<Color>(Warna.putih),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Warna.putih)))),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(
                      selectedDevice: widget.selectedDevice,
                      id: '2',
                      nama: 'UMUM')));
        },
      ),
    );
  }

  Widget _buildDifabelButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        child: Text(
          "Difabel/Prioritas".toUpperCase(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Warna.putih),
            backgroundColor: MaterialStateProperty.all<Color>(Warna.merah),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Warna.merah)))),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(
                      selectedDevice: widget.selectedDevice,
                      id: '1',
                      nama: 'DIFABEL/PRIORITAS')));
        },
      ),
    );
  }
}
