import 'package:flutter/material.dart';
import 'package:wimeet/screens/join-meeting.dart';
import 'package:wimeet/screens/meeting.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userEmail = '';
  late String userName = '';
  bool toggleProfile = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await supabase.auth.currentUser;
      if (response == null) {
        throw 'User not authenticated';
      }
      final user = response;
      final userMetadata = response.userMetadata;
      if (user != null) {
        setState(() {
          userEmail = user.email!;
          userName = userMetadata != null ? userMetadata['displayName'] : ''; // Handle nullable user metadata
        });
      }
      print(userName);
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> signOut() async {
    try {
      final response = await supabase.auth.signOut();
      Navigator.pushNamed(context, '/');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User Signed Out!'),
        ),
      );
    } catch (error) {
      print('Sign out error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign out failed. Please try again.'),
        ),
      );
    }
  }

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
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(userName.isEmpty ? userEmail : userName, style: TextStyle(
                      color: Colors.black,
                    ),),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggleProfile = !toggleProfile;
                            });
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.britannica.com/49/182849-050-4C7FE34F/scene-Iron-Man.jpg',
                            ),
                            radius: 20,
                          ),
                        ),
                        if (toggleProfile)
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              // Set background color to white
                              primary: Colors.white,
                              // Add shadow
                              elevation: 5,
                              // Set shadow color
                              shadowColor: Colors.grey,
                            ),
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                // Set text color to red
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}