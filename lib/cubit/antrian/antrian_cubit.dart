import 'package:antrian_apk/cubit/antrian/antrian_state.dart';
import 'package:antrian_apk/models/buat_antrian_request.dart';
import 'package:antrian_apk/repositories/antrian_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AntrianCubit extends Cubit<AntrianState> {
  AntrianCubit() : super(InitialAntrianState());

  AntrianRepository antrianRepository = AntrianRepository();

  void buatAntrian(String type, String keperluan) async {
    emit(LoadingAntrianState());

    await Future.delayed(const Duration(seconds: 3));

    BuatAntrianRequest buatAntrianRequest =
        BuatAntrianRequest(type: type, keperluan: keperluan);

    antrianRepository.buatAntrian(buatAntrianRequest).then((resp) async {
      emit(SuccessAntrianState(resp.success.toString(), resp.message.toString(),
          resp.noantrian.toString(), resp.keperluan.toString()));
    });
  }
}
