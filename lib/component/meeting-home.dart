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
        _buildListHeader("TODO", Colors.yellow[600]),
        _buildTaskList(this.widget._meeting.todoList, TaskType.todo),
        _buildListHeader("DOING", Colors.blue[600]),
        _buildTaskList(this.widget._meeting.doingList, TaskType.doing),
        _buildListHeader("DONE", Colors.green[600]),
        _buildTaskList(this.widget._meeting.doneList, TaskType.done),
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
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(child: Text(t.text)),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _popTodoList(t); 
              _pushDoingList(t);
            },
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow[700]
        ),
        color: Colors.yellow[100]
      ),
    );
  }

  Widget _buildDoingRow(Task t) {
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
          Expanded(child: Text(t.text)),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _popDoingList(t); 
              _pushDoneList(t);
            },
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue[700]
        ),
        color: Colors.blue[100]
      ),
    );
  }

  Widget _buildDoneRow(Task t) {
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
          Expanded(child: Text(t.text)),
        ],
      ),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green[700]
        ),
        color: Colors.green[100]
      ),
    );
  }

  _pushTodoList(Task t) {
    print("Inserindo a task " + t.id.toString() + " na lista TODO");
  }

  _popTodoList(Task t) {
    print("Removendo a task " + t.id.toString() + " da lista TODO");
  }

  _pushDoingList(Task t) {
    print("Inserindo a task " + t.id.toString() + " na lista DOING");
  }

  _popDoingList(Task t) {
    print("Removendo a task " + t.id.toString() + " da lista DOING");
  }

  _pushDoneList(Task t) {
    print("Inserindo a task " + t.id.toString() + " na lista DONE");
  }

  _popDoneList(Task t) {
    print("Removendo a task " + t.id.toString() + " da lista DONE");
  }
}