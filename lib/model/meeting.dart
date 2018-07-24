import "dart:math";

const sourceText = "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado.";

class Meeting {
  num id;
  String name;
  DateTime dateTime;
  List<Task> todoList;
  List<Task> doingList;
  List<Task> doneList;
}

class Task {
  num id;
  String text;

  Task(num id, String text) {
    this.id = id;
    this.text = text;
  }

  @override
  String toString() {
    return this.text;
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
  m.todoList = _buildManyTasks(r.nextInt(10), "TODOs ");
  m.doingList = _buildManyTasks(r.nextInt(10), "DOINGs ");
  m.doneList = _buildManyTasks(r.nextInt(10), "DONEs ");
  print(m);

  return m;
}

List<Task> _buildManyTasks(int qtd, String prefix) {
  List<Task> listAll = [];
  var r = Random();
  for(var i = 0; i < qtd; i++) {
    var textSize = r.nextInt(sourceText.length - 16) + 15;
    listAll.add(_buildOneTask(i, prefix + sourceText.substring(0, textSize)));
  }
  return listAll;
}

Task _buildOneTask(int index, String text) {
  return Task(index, text);
}