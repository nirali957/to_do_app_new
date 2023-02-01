import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_new/model/to_do_model.dart';
import 'package:to_do_app_new/screens/to_do_add_screen.dart';
import 'package:to_do_app_new/screens/to_do_complete_screen.dart';
import 'package:to_do_app_new/utiles/constants.dart';
import 'package:to_do_app_new/utiles/local_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocalData localData = LocalData();
  List<ToDoModel> listOfData = [];

  @override
  void initState() {
    // TODO: implement initState
    getToDoData();
    super.initState();
  }

  getToDoData() async {
    dynamic data = await localData.getObject(key: localData.todoData);
    listOfData.add(ToDoModel.fromJson(data));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ToDoCompleteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.check_box),
          ),
        ],
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
          : ListView.separated(
              itemCount: listOfData.length,
              padding: const EdgeInsets.symmetric(vertical: 15),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final item = listOfData[index];
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        listOfCompleteData.add(item);
                        listOfData.removeAt(index);
                        setState(() {});
                      },
                    ),
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
                        onPressed: (context) async {
                          dynamic data = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ToDoAddScreen(
                                item: item,
                              ),
                            ),
                          );

                          if (data != null) {
                            listOfData[index] = data;
                            setState(() {});
                          }
                        },
                        backgroundColor: const Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          listOfData.removeAt(index);
                          setState(() {});
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.grey.shade400,
                    title: Text('${item.title}'),
                    subtitle: Text('${item.description}'),
                    trailing: Text('${item.time}'),
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
