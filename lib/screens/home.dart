import 'package:flutter/material.dart';
import 'package:wimeet/screens/join-meeting.dart';
// import 'package:wimeet/screens/meeting.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wimeet/api_call.dart';
import 'room.dart';

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
  late String userId = '';
  bool toggleProfile = false;

    void onCreateButtonPressed(BuildContext context) async {
      await createMeeting().then((meetingId) {
        if (!context.mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MeetingScreen(
              meetingId: meetingId,
              token: token,
            ),
          ),
        );
      });
    }

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
          userName = userMetadata != null ? userMetadata['displayName'] : '';
          userId = user.id!;
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
      body: FutureBuilder<void>(
        future: fetchUserData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://cdn.britannica.com/49/182849-050-4C7FE34F/scene-Iron-Man.jpg',
                            ),
                            radius: 20,
                          ),
                          SizedBox(height: 5,),
                          Text(userName.isEmpty ? userEmail : userName, style: TextStyle(
                              color: Color(0xFF15A9FF),
                              fontFamily: "poppins",
                              letterSpacing: 1
                          ),),
                        ],
                      ),
                       IconButton(
                           onPressed: () {
                             signOut();
                       },
                           icon: Icon(Icons.exit_to_app, color: Colors.red,)
                       )
                    ],
                  ),
                ),
                SizedBox(height: 120),
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
                  // onPressed: () {
                  //   createMeeting();
                  // },
                  onPressed: () => onCreateButtonPressed(context),
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
            );
          }
        // },
      ),
    );
  }
}
