import 'package:antrian_apk/cubit/keperluan/keperluan_state.dart';
import 'package:antrian_apk/repositories/antrian_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeperluanCubit extends Cubit<KeperluanState> {
  KeperluanCubit() : super(InitialKeperluanState());

  AntrianRepository antrianRepository = AntrianRepository();

  void listKeperluan() async {
    emit(LoadingKeperluanState());

    await Future.delayed(const Duration(seconds: 3));

    antrianRepository.getKeperluan().then((resp) async {
      emit(SuccessKeperluanState(resp));
    });
  }
}
