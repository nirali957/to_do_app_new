import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_app_new/model/to_do_model.dart';
import 'package:to_do_app_new/utiles/local_data.dart';

class ToDoAddScreen extends StatefulWidget {
  final TodoList? item;
  const ToDoAddScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ToDoAddScreen> createState() => _ToDoAddScreenState();
}

class _ToDoAddScreenState extends State<ToDoAddScreen> {
  ToDoModel toDoModel = ToDoModel();
  LocalData localData = LocalData();

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  getData() async {
    if (await localData.containData(localData.todoData)) {
      dynamic data = await localData.getObject(localData.todoData);
      debugPrint("data ---------->> $data");
      toDoModel = ToDoModel.fromJson(data);
    } else {
      toDoModel.todoList = [];
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.item != null) {
      titleController.text = widget.item!.title!;
      dateController.text = widget.item!.date!;
      timeController.text = widget.item!.time!;
      descriptionController.text = widget.item!.description!;
    }
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo Add"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        physics: const BouncingScrollPhysics(),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black87),
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );

              debugPrint("date ----------->> $pickedDate");
              dateController.text = pickedDate.toString().split(" ").first;
              setState(() {});
            },
            child: TextField(
              controller: dateController,
              enabled: false,
              decoration: InputDecoration(
                hintText: "Select date",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black87),
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () async {
              TimeOfDay? pickTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickTime != null) {
                debugPrint("Time ---------->> ${pickTime.format(context)}");
                timeController.text = pickTime.format(context);
              }
              setState(() {});
            },
            child: TextField(
              controller: timeController,
              enabled: false,
              decoration: InputDecoration(
                hintText: "Select time",
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black87),
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: descriptionController,
            minLines: 5,
            maxLines: 7,
            decoration: InputDecoration(
              hintText: "Enter description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black87),
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              TodoList todoList = TodoList(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
                description: descriptionController.text,
              );
              toDoModel.todoList!.add(todoList);
              localData.removeData(localData.todoData);
              localData.setObject(localData.todoData, jsonEncode(toDoModel));
              Navigator.pop(context);
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
            ),
            child: const Text("Add ToDo"),
          ),
        ],
      ),
    );
  }
}
