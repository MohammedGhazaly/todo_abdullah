import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_abdullah/controller/modal_bottom_sheet_controller/modal_bottom_sheet_cubit.dart';
import 'package:to_do_abdullah/model/task_model.dart';
import 'package:to_do_abdullah/utils/local_db.dart';
import 'package:to_do_abdullah/widgets/custom_text_form_field.dart';

class TasksModalBottomSheet extends StatefulWidget {
  const TasksModalBottomSheet({super.key});

  @override
  State<TasksModalBottomSheet> createState() => _TasksModalBottomSheetState();
}

class _TasksModalBottomSheetState extends State<TasksModalBottomSheet> {
  SqlDb db = SqlDb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode timeOfDateFocusNode = FocusNode();
  FocusNode dateTimeFocusNode = FocusNode();

  late final TextEditingController titleController;
  late final TextEditingController timeOfDayController;
  late final TextEditingController dateTimeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    timeOfDayController = TextEditingController();
    dateTimeController = TextEditingController();
    timeOfDateFocusNode.addListener(() {
      if (timeOfDateFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
    dateTimeFocusNode.addListener(() {
      if (dateTimeFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    timeOfDayController.dispose();
    dateTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modalBottomSheetCubit =
        BlocProvider.of<ModalBottomSheetCubit>(context);
    return SizedBox(
      // height: 250,
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
                enabled: true,
                textInputType: TextInputType.text,
                prefix: const Icon(Icons.title_rounded),
                textEditingController: titleController,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title must not be empty";
                  }
                  return null;
                },
                hintText: "Task title",
              ),
              SizedBox(
                height: 16,
              ),
              FocusScope(
                child: CustomTextFormField(
                  focusNode: timeOfDateFocusNode,
                  textInputType: TextInputType.datetime,
                  prefix: const Icon(Icons.watch_later_outlined),
                  textEditingController: timeOfDayController,
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return "Time must not be empty";
                    }
                    return null;
                  },
                  hintText: "Time",
                  tapFuntion: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then(
                      (value) {
                        timeOfDayController.text = value?.format(context) ??
                            TimeOfDay.now().format(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FocusScope(
                child: CustomTextFormField(
                  focusNode: dateTimeFocusNode,
                  textInputType: TextInputType.datetime,
                  prefix: const Icon(Icons.date_range),
                  textEditingController: dateTimeController,
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return "Date must not be empty";
                    }
                    return null;
                  },
                  hintText: "Date",
                  tapFuntion: () {
                    showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            // lastDate: DateTime.parse("2024-02-27")
                            lastDate:
                                DateTime.now().add(const Duration(days: 30)))
                        .then((value) {
                      dateTimeController.text =
                          DateFormat.yMMMEd().format(value!);
                      print(value);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final TaskModel task = TaskModel(
                        title: titleController.text,
                        time: timeOfDayController.text,
                        date: dateTimeController.text,
                      );
                      modalBottomSheetCubit.addTask(task.toJson());
                    }
                  },
                  child: const Text("Add task"))
            ],
          ),
        ),
      ),
    );
  }
}
