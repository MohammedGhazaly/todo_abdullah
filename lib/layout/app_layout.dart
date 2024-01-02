import 'package:flutter/material.dart';
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
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetOpened = false;
  PersistentBottomSheetController? controller;

  SqlDb sqlDb = SqlDb();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: tabs[currentIndex],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                if (controller == null) {
                  settingModalBottomSheet();
                } else {
                  controller!.close();
                  controller = null;
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
        title: Text(appBarText[currentIndex]),
        centerTitle: true,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
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
      return TasksModalBottomSheet();
    });
  }

  void _closeModalBottomSheet() {
    if (controller != null) {
      controller!.close();

      controller = null;
    } else {}
  }
}
