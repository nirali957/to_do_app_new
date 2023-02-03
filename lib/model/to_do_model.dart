class ToDoModel {
  List<TodoList>? todoList;

  ToDoModel({
    this.todoList,
  });

  ToDoModel.fromJson(Map<String, dynamic> json)
      : todoList = (json['todo_list'] as List?)
            ?.map(
              (dynamic e) => TodoList.fromJson(e as Map<String, dynamic>),
            )
            .toList();

  Map<String, dynamic> toJson() => {
        'todo_list': todoList?.map((e) => e.toJson()).toList(),
      };
}

class TodoList {
  final String? title;
  final String? time;
  final String? date;
  final String? description;

  TodoList({
    this.title,
    this.time,
    this.date,
    this.description,
  });

  TodoList.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        time = json['time'] as String?,
        date = json['date'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'date': date,
        'description': description,
      };
}
