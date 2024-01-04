import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_abdullah/controller/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/layout/app_layout.dart';
import 'package:to_do_abdullah/utils/app_theme.dart';
import 'package:to_do_abdullah/utils/states_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => BottomNavBarCubit(),
            lazy: true,
          ),
          BlocProvider(
            create: (_) => ModalBottomSheetCubit(),
            lazy: true,
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          home: const AppLayout(),
        ));
  }
}
