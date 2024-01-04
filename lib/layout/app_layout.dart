import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_states.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/tasks_modal_bottom_sheet.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
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
        final bottomNavBarCubit =
            BlocProvider.of<BottomNavBarCubit>(context, listen: false);
        final modalBottomSheetCubit =
            BlocProvider.of<ModalBottomSheetCubit>(context, listen: true);
        return Scaffold(
          key: modalBottomSheetCubit.scaffoldKey,
          body: bottomNavBarCubit.tabs[bottomNavBarCubit.currentIndex],
          floatingActionButton: bottomNavBarCubit.currentIndex == 0
              ? FloatingActionButton(
                  onPressed: () {
                    if (modalBottomSheetCubit.controller == null) {
                      modalBottomSheetCubit.settingModalBottomSheet();
                    } else {
                      modalBottomSheetCubit.closeModalBottomSheet();
                    }
                    setState(() {});
                  },
                  child: Icon(
                    modalBottomSheetCubit.controller == null
                        ? Icons.edit
                        : Icons.close,
                  ),
                )
              : null,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                bottomNavBarCubit.appBarText[bottomNavBarCubit.currentIndex]),
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
}
