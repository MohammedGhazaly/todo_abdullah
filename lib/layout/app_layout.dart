import 'package:flutter/material.dart';
import 'package:to_do_abdullah/modules/archived_tasks.dart';
import 'package:to_do_abdullah/modules/done_tasks.dart';
import 'package:to_do_abdullah/modules/new_tasks.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
      appBar: AppBar(
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
}
