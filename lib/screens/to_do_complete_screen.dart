import 'package:flutter/material.dart';
import 'package:to_do_app_new/utiles/constants.dart';

class ToDoCompleteScreen extends StatefulWidget {
  const ToDoCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ToDoCompleteScreen> createState() => _ToDoCompleteScreenState();
}

class _ToDoCompleteScreenState extends State<ToDoCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do Complete"),
      ),
      body: listOfCompleteData.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.separated(
              itemCount: listOfCompleteData.length,
              padding: const EdgeInsets.symmetric(vertical: 15),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final item = listOfCompleteData[index];
                return ListTile(
                  tileColor: Colors.grey.shade400,
                  title: Text('${item.title}'),
                  subtitle: Text('${item.description}'),
                  trailing: Text('${item.time}'),
                );
              },
            ),
    );
  }
}
