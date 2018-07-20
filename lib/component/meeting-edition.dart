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
    return Scaffold(
      appBar: AppBar(
        title: Text('Meetings no Flutter'),
      ),
      body: Center(
        child: Text("Edição de reunião " + this.widget._meeting.name)
      ),
    );
  }
}