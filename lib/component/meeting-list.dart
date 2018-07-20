import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../model/meeting.dart';
import './meeting-edition.dart';

class MeetingTile {

  BuildContext _context;
  Meeting _meeting;

  final _biggerFont = const TextStyle(fontSize: 18.0); 

  MeetingTile(BuildContext context, Meeting meeting){
    _context = context;
    _meeting = meeting;
  }

  Widget build(){
    return InkWell(
      onTap: (){
        Navigator.push(_context, MaterialPageRoute(builder: (context) => MeetingEdition(_meeting)));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _meeting.name, 
                      style: _biggerFont,
                    ),
                  ),
                  Text(
                    formatDate(_meeting.dateTime, [d, '/', m, '/', yy]),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _meeting.todoList.length.toString() + " TODO", 
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _meeting.doingList.length.toString() + " DOING", 
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _meeting.doneList.length.toString() + " DONE", 
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _meeting.obsList.length.toString() + " OBS", 
                      style: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
          border: new Border(bottom: new BorderSide(color: Theme.of(_context).dividerColor))
        ),
      )
    );
  }
}