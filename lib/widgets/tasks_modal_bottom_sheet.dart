import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_abdullah/widgets/custom_text_form_field.dart';

class TasksModalBottomSheet extends StatefulWidget {
  const TasksModalBottomSheet({super.key});

  @override
  State<TasksModalBottomSheet> createState() => _TasksModalBottomSheetState();
}

class _TasksModalBottomSheetState extends State<TasksModalBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode datePickerFocusNode = FocusNode();

  late final TextEditingController titleController;
  late final TextEditingController dateTimeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    dateTimeController = TextEditingController();
    datePickerFocusNode.addListener(() {
      if (datePickerFocusNode.hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    dateTimeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 250,
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24,
              ),
              CustomTextFormField(
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
                  focusNode: datePickerFocusNode,
                  textInputType: TextInputType.datetime,
                  prefix: const Icon(Icons.watch_later_outlined),
                  textEditingController: dateTimeController,
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
                        dateTimeController.text = value?.format(context) ??
                            TimeOfDay.now().format(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
