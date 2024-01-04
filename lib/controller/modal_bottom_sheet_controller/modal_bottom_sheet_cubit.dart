import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_abdullah/widgets/tasks_modal_bottom_sheet.dart';

part 'modal_bottom_sheet_state.dart';

class ModalBottomSheetCubit extends Cubit<ModalBottomSheetState> {
  ModalBottomSheetCubit() : super(ModalBottomSheetClosed());
  bool isBottomSheetOpened = false;

  PersistentBottomSheetController? controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void settingModalBottomSheet() {
    controller = scaffoldKey.currentState!.showBottomSheet(
        backgroundColor: Colors.white, enableDrag: false, (context) {
      return const TasksModalBottomSheet();
    });
    emit(ModalBottomSheetClosed());
  }

  void closeModalBottomSheet() {
    if (controller != null) {
      controller!.close();

      controller = null;
    }
    emit(ModalBottomSheetOpended());
  }
}
