class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}
