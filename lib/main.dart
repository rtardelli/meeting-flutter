import 'package:flutter/material.dart';

import './model/meeting.dart';
import './component/meeting-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Reuniões",
      home: ListMeetings(),
    );
  }
}

class ListMeetings extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListMeetingsState();
  }  
}

class ListMeetingsState extends State<ListMeetings> {

  final _listAllMeetings = generateRandomMeetings();

  Widget _buildMeetingList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return _buildRow(_listAllMeetings[i]);
      },
      itemCount: _listAllMeetings.length,
    );
  }

  Widget _buildRow(Meeting meeting) {
    return MeetingTile(context, meeting).build();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings no Flutter'),
      ),
      body: _buildMeetingList(),
    );
  }
}