part of 'modal_bottom_sheet_cubit.dart';

@immutable
sealed class ModalBottomSheetState {}

final class ModalBottomSheetClosed extends ModalBottomSheetState {}

final class ModalBottomSheetOpended extends ModalBottomSheetState {}

final class TaskAdded extends ModalBottomSheetState {}

final class TasksFetched extends ModalBottomSheetState {}
