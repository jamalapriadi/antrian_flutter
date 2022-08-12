import 'package:antrian_apk/helpers/cache_storage.dart';
import 'package:antrian_apk/helpers/http_request.dart';
import 'package:antrian_apk/models/buat_antrian_request.dart';
import 'package:antrian_apk/models/buat_antrian_response.dart';
import 'package:antrian_apk/models/keperluan_response.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class AntrianRepository {
  final network = Network();

  Future<List<KeperluanResponse>> getKeperluan() async {
    var url = "https://antrian-api.jamalapriadi.com/api/list-keperluan";

    final response = await network.getRequest(url);

    return keperluanResponseFromJson(response.body);
  }

  Future<BuatAntrianResponse> buatAntrian(BuatAntrianRequest request) async {
    var url = "https://antrian-api.jamalapriadi.com/api/buat-antrian";

    final response = await network.postRequest(url, request.toJson());

    return buatAntrianResponseFromJson(response.body);
  }

  Future<dynamic> setPrinter(BluetoothDevice print) async {
    return await Cache.setCache(key: 'printer', data: print);
  }

  Future<BluetoothDevice> getPrinter() async {
    return await Cache.getCache(key: 'printer');
  }

  Future<dynamic> removePrinter() async {
    return await Cache.removeCache(key: 'printer');
  }
}
