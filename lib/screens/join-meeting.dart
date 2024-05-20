import 'package:flutter/material.dart';
import 'package:wimeet/screens/meeting.dart';
import 'room.dart';
import 'package:wimeet/api_call.dart';

class JoinMeetingPage extends StatefulWidget {
  @override
  _JoinMeetingPageState createState() => _JoinMeetingPageState();
}

class _JoinMeetingPageState extends State<JoinMeetingPage> {
  TextEditingController _meetingIdController = TextEditingController();

  void onJoinButtonPressed(BuildContext context) {
    String meetingId = _meetingIdController.text;
    var re = RegExp("\\w{4}\\-\\w{4}\\-\\w{4}");
    if (meetingId.isNotEmpty && re.hasMatch(meetingId)) {
      _meetingIdController.clear();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeetingScreen(
            meetingId: meetingId,
            token: token,
            participantName: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter valid meeting id"),
      ));
    }
  }

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
              onPressed: () => onJoinButtonPressed(context),
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
