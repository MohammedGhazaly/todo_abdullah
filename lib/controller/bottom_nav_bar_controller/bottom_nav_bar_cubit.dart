import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_states.dart';
import 'package:to_do_abdullah/modules/archived_tasks.dart';
import 'package:to_do_abdullah/modules/done_tasks.dart';
import 'package:to_do_abdullah/modules/new_tasks.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int currentIndex = 0;

  List<Widget> tabs = const [
    NewTasksScreen(),
    ArchivedTasksScreen(),
    DoneTasksScreen()
  ];
  List<String> appBarText = [
    "Tasks",
    "Done tasks",
    "Archived tasks",
  ];

  void onBottomNavbarTab(int index) {
    currentIndex = index;
    emit(BottomNavBarChanged());
  }
}
