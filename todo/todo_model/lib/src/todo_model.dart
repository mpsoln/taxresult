class Todo {
  int id;
  String todo;
  String desc;
  bool isCompleted;

  Todo({
    required this.id,
    required this.todo,
    required this.desc,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'desc': desc,
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      todo: map['todo'] as String,
      desc: map['desc'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}
