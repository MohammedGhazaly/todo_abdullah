import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_states.dart';
import 'package:to_do_abdullah/modules/archived_tasks.dart';
import 'package:to_do_abdullah/modules/done_tasks.dart';
import 'package:to_do_abdullah/modules/new_tasks.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/tasks_modal_bottom_sheet.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetOpened = false;
  PersistentBottomSheetController? controller;

  SqlDb sqlDb = SqlDb();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarStates>(
      builder: (context, state) {
        final bottonNavBarCubit =
            BlocProvider.of<BottomNavBarCubit>(context, listen: false);
        return Scaffold(
          key: _scaffoldKey,
          body: bottonNavBarCubit.tabs[bottonNavBarCubit.currentIndex],
          floatingActionButton: bottonNavBarCubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    if (controller == null) {
                      settingModalBottomSheet();
                    } else {
                      _closeModalBottomSheet();
                    }
                    setState(() {});
                  },
                  child: Icon(
                    controller == null ? Icons.edit : Icons.close,
                  ),
                )
              : null,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                bottonNavBarCubit.appBarText[bottonNavBarCubit.currentIndex]),
            centerTitle: true,
          ),
          bottomNavigationBar: buildBottomNavigationBar(),
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    final bottonNavBarCubit =
        BlocProvider.of<BottomNavBarCubit>(context, listen: false);
    return BottomNavigationBar(
      currentIndex: bottonNavBarCubit.currentIndex,
      onTap: bottonNavBarCubit.onBottomNavbarTab,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: "Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: "done",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive_rounded),
          label: "Archived",
        ),
      ],
    );
  }

  void settingModalBottomSheet() {
    controller = _scaffoldKey.currentState!.showBottomSheet(
        backgroundColor: Colors.white, enableDrag: false, (context) {
      return const TasksModalBottomSheet();
    });
  }

  void _closeModalBottomSheet() {
    if (controller != null) {
      controller!.close();

      controller = null;
    } else {}
  }
}
