import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_new/model/to_do_model.dart';
import 'package:to_do_app_new/screens/to_do_add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ToDoModel> listOfData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: listOfData.isEmpty
          ? const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              itemCount: listOfData.length,
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemBuilder: (context, index) {
                final item = listOfData[index];
                return Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        label: 'Complete',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15).copyWith(top: 0),
                    child: ListTile(
                      tileColor: Colors.grey.shade400,
                      title: Text('${item.title}'),
                      subtitle: Text('${item.description}'),
                      trailing: Text('${item.time}'),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic data = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ToDoAddScreen(),
            ),
          );

          if (data != null) {
            listOfData.add(data);
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
