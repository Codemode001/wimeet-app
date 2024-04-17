import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:wimeet/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class MeetingPage extends StatefulWidget {
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraOpen = false;
  bool _isMicOpen = false;
  late String userEmail = '';
  late String userName = '';

  @override
  void initState() {
    super.initState();
    _initializeCameraController();
    fetchUserData();
  }

  Future<void> _initializeCameraController() async {
    final cameras = await availableCameras();
    CameraDescription? frontCamera;
    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }
    if (frontCamera == null) {
      throw Exception('No front camera found!');
    }
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          userName = userMetadata != null ? userMetadata['displayName'] ?? '' : '';
        });
      }
      print(userName);
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userName);
    return Scaffold(
      appBar: AppBar(
        title: Text('WiMeet - Video Meeting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isCameraOpen)
              Expanded(
                child: Stack(
                  children: [
                    FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return CameraPreview(_controller);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              )
            else
              Image.network(
                'https://cdn.britannica.com/49/182849-050-4C7FE34F/scene-Iron-Man.jpg',
                height: 300,
              ),
            Container(
              child: Text(userName.isEmpty ? userEmail : userName, style: TextStyle(
                color: Colors.black,
              ),),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _toggleMic,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Icon(
                        _isMicOpen ? Icons.mic : Icons.mic_off,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: _toggleCamera,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Icon(
                        _isCameraOpen ? Icons.videocam : Icons.videocam_off,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFd93025), // Use the web background color
                  ),
                  child: Text('Leave Meeting'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleCamera() {
    setState(() {
      _isCameraOpen = !_isCameraOpen;
    });
  }

  void _toggleMic() {
    setState(() {
      _isMicOpen = !_isMicOpen;
    });
  }
}
