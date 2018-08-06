import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../model/meeting.dart';

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
        _buildTaskList(this.widget._meeting.todoList),
        _buildListHeader("DOING", Colors.blue),
        _buildTaskList(this.widget._meeting.doingList),
        _buildListHeader("DONE", Colors.green),
        _buildTaskList(this.widget._meeting.doneList),
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
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
    );
  }

  Widget _buildTaskList(List<Task> taskList) {
    return Container(
      child: Column(
        children: 
          List.generate(taskList.length, (index) {
            return ListTile(
              leading: const Icon(Icons.arrow_left),
              title: Text(taskList[index].text),
              trailing: const Icon(Icons.arrow_right),
            );
          })
      ),
    );
  }
}