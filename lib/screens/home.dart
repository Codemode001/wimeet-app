import 'package:flutter/material.dart';
import 'package:wimeet/screens/join-meeting.dart';
import 'package:wimeet/screens/meeting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiMeet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WiMeet'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 10),
            Text(
              'WiMeet',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Text(
              'The place where meetings come to life!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeetingPage()),
                );
              },
              child: Text('Start a Meeting'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinMeetingPage()),
                );
              },
              child: Text('Join a Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}