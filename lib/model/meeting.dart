import "dart:math";

class Meeting {
  num id;
  String name;
  DateTime dateTime;
  List<Task> todoList;
  List<Task> doingList;
  List<Task> doneList;
  List<Task> obsList;
}

class Task {
  num id;
  String text;

  Task(num id, String text) {
    this.id = id;
    this.text = text;
  }
}

List<Meeting> generateRandomMeetings() {
  var listAll = <Meeting>[];

  for(var i = 0; i < 10; i++) {
    listAll.add(_buildOne(i));
  }

  return listAll;
}

Meeting _buildOne(int index){
  Meeting m = Meeting();

  m.id = index;
  m.name = "Reunião " + index.toString();
  m.dateTime = DateTime.now();
  var r = Random();
  m.todoList = _buildManyTasks(r.nextInt(10), "TODO ");
  m.doingList = _buildManyTasks(r.nextInt(10), "DOING ");
  m.doneList = _buildManyTasks(r.nextInt(10), "DONE ");
  m.obsList = _buildManyTasks(r.nextInt(10), "OBS ");

  print(m);

  return m;
}

List<Task> _buildManyTasks(int qtd, String prefix) {
  List<Task> listAll = [];
  for(var i = 0; i < qtd; i++) {
    listAll.add(_buildOneTask(i, prefix));
  }
  return listAll;
}

Task _buildOneTask(int index, String prefix) {
  return Task(index, prefix + index.toString());
}