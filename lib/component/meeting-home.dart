import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../model/meeting.dart';

enum TaskType { todo, doing, done}

class MeetingEdition extends StatefulWidget {

  final Meeting _meeting;

  MeetingEdition(this._meeting);

  @override
  State<StatefulWidget> createState() {
    return MeetingEditionState();
  }
}

class MeetingEditionState extends State<MeetingEdition> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget._meeting.name),
        centerTitle: true,
      ),
      body: _buildMeetingBody(),
    );
  }

  Widget _buildMeetingBody() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        _buildInfoCard(),
        _buildListHeader("TODO (" + this.widget._meeting.todoList.length.toString() + ")", Colors.yellow[600]),
        _buildTaskList(this.widget._meeting.todoList, TaskType.todo),
        _addTodoButton(),
        _buildListHeader("DOING (" + this.widget._meeting.doingList.length.toString() + ")", Colors.blue[600]),
        _buildTaskList(this.widget._meeting.doingList, TaskType.doing),
        _addDoingButton(),
        _buildListHeader("DONE (" + this.widget._meeting.doneList.length.toString() + ")", Colors.green[600]),
        _buildTaskList(this.widget._meeting.doneList, TaskType.done),
        _addDoneButton(),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Container(
        child: Text(
          formatDate(this.widget._meeting.dateTime, [dd, '/', mm, '/', yy]),
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget _buildListHeader(String header, Color innerColor) {
    return Container(
      child: Text(header, style: TextStyle(color: Colors.white, fontSize: 25.0),),
      padding: EdgeInsets.fromLTRB(35.0, 5.0, 35.0, 5.0),
      decoration: BoxDecoration(
        color: innerColor,
        border: Border.all(
          color: Colors.black, 
          width: 1.0, 
          style: BorderStyle.solid
        ), 
        borderRadius: BorderRadius.circular(15.0)
      ),
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
    );
  }

  Widget _buildTaskList(List<Task> taskList, TaskType type) {
    return Container(
      child: Column(
        children: 
          List.generate(taskList.length, (index) {
            if(type == TaskType.todo) {
              return _buildTodoRow(taskList[index]);
            } else if(type == TaskType.doing) {
              return _buildDoingRow(taskList[index]);
            } else {
              return _buildDoneRow(taskList[index]);
            }
          }),
      ),
    );
  }

  Widget _buildTodoRow(Task t) {
    // TODO: Revisar a criação do TextEditingController para dar dispose junto com o Widget. Opção 1: ter um controller e o listener ser compartilhado
    final _textController = TextEditingController(text: t.text);

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: EditableText(
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                controller: _textController,
                maxLines: null,
                focusNode: FocusNode(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                cursorColor: Colors.blue,
              ),
            )
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _popTodoList(t); 
              _pushDoingList(t);
            },
          ),
        ],
      ),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow[700],
          width: 2.0
        ),
      ),
    );
  }

  Widget _buildDoingRow(Task t) {
    // TODO: Revisar a criação do TextEditingController para dar dispose junto com o Widget. Opção 1: ter um controller e o listener ser compartilhado
    final _textController = TextEditingController(text: t.text);

    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _popDoingList(t); 
              _pushTodoList(t);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: EditableText(
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                controller: _textController,
                maxLines: null,
                focusNode: FocusNode(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                cursorColor: Colors.blue,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _popDoingList(t); 
              _pushDoneList(t);
            },
          ),
        ],
      ),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue[700]
        ),
      ),
    );
  }

  Widget _buildDoneRow(Task t) {
    // TODO: Revisar a criação do TextEditingController para dar dispose junto com o Widget. Opção 1: ter um controller e o listener ser compartilhado
    final _textController = TextEditingController(text: t.text);

    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _popDoneList(t); 
              _pushDoingList(t);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: EditableText(
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                controller: _textController,
                maxLines: null,
                focusNode: FocusNode(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                cursorColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[700]
        ),
      ),
    );
  }

  _pushTodoList(Task t) {
    setState(() {
          this.widget._meeting.todoList.add(t);
          print("Inserindo a task " + t.id.toString() + " na lista TODO");
        });
  }

  _popTodoList(Task t) {
    setState(() {
          this.widget._meeting.todoList.remove(t);
          print("Removendo a task " + t.id.toString() + " na lista TODO");
        });
  }

  _pushDoingList(Task t) {
    setState(() {
          this.widget._meeting.doingList.add(t);
          print("Inserindo a task " + t.id.toString() + " na lista DOING");
        });
  }

  _popDoingList(Task t) {
    setState(() {
          this.widget._meeting.doingList.remove(t);
          print("Removendo a task " + t.id.toString() + " na lista DOING");
        });
  }

  _pushDoneList(Task t) {
    setState(() {
          this.widget._meeting.doneList.add(t);
          print("Inserindo a task " + t.id.toString() + " na lista DONE");
        });
  }

  _popDoneList(Task t) {
    setState(() {
          this.widget._meeting.doneList.remove(t);
          print("Removendo a task " + t.id.toString() + " na lista DONE");
        });
  }

  _addTodoButton() {
    return IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 50.0,
            color: Colors.yellow[600],
            splashColor: Colors.yellow[200],
            onPressed: () {
              // Ação para adicionar Todo task
              print("ADD Todo task");
            },
          );
  }

  _addDoingButton() {
    return IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 50.0,
            color: Colors.blue[600],
            splashColor: Colors.blue[200],
            onPressed: () {
              // Ação para adicionar Doing task
              print("ADD Doing task");
            },
          );
  }

  _addDoneButton() {
    return IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 50.0,
            color: Colors.green[600],
            splashColor: Colors.green[200],
            onPressed: () {
              // Ação para adicionar Done task
              print("ADD Done task");
            },
          );
  }
}