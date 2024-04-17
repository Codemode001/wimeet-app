import 'package:flutter/material.dart';
import 'package:wimeet/screens/home.dart';
import 'package:wimeet/screens/meeting.dart';

class CreateMeetingPage extends StatefulWidget {
  @override
  _CreateMeetingPageState createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  TextEditingController _meetingNameController = TextEditingController();
  TextEditingController _meetingPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create a New Meeting',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _meetingNameController,
              decoration: InputDecoration(
                labelText: 'Meeting Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _meetingPasswordController,
              decoration: InputDecoration(
                labelText: 'Meeting Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String meetingName = _meetingNameController.text;
                String meetingDescription = _meetingPasswordController.text;
                print('Meeting Name: $meetingName');
                print('Meeting Description: $meetingDescription');
                Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingPage()));
              },
              child: Text('Create Meeting'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _meetingNameController.dispose();
    _meetingPasswordController.dispose();
    super.dispose();
  }
}