import 'package:flutter/material.dart';
import 'package:wimeet/screens/home.dart';
import 'package:wimeet/screens/meeting.dart';

class JoinMeetingPage extends StatefulWidget {
  @override
  _JoinMeetingPageState createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  TextEditingController _meetingIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Join a Meeting',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _meetingIdController,
              decoration: InputDecoration(
                labelText: 'Meeting ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your join meeting logic here
                String meetingId = _meetingIdController.text;

                // Example: Print meeting ID
                print('Meeting ID: $meetingId');
                Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingPage()));
              },
              child: Text('Join Meeting'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _meetingIdController.dispose();
    super.dispose();
  }
}
