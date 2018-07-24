import 'package:flutter/material.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "ToDo",),
              Tab(text: "Doing"),
              Tab(text: "Done"),
            ],
          ),
          title: Text(this.widget._meeting.name),
        ),
        body: _buildTabPage(),
      ),
    );
  }

  Widget _buildTabPage() {
    return TabBarView(
      children: [
        _buildTabContent(this.widget._meeting.todoList),
        _buildTabContent(this.widget._meeting.doingList),
        _buildTabContent(this.widget._meeting.doneList),
      ],
    );
  }

  Widget _buildTabContent(List<Task> taskList) {
    return Container(
      child: ListView.builder(
        itemCount: taskList.length,
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          return _buildRow(taskList[i]);
        },
      )
    );
  }

  Widget _buildRow(Task task) {
    return Text(task.text);
  }
}