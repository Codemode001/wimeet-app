import 'package:flutter/material.dart';

class MeetingControls extends StatefulWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onLeaveButtonPressed;
  final void Function() onToggleCameraButtonPressed;

  const MeetingControls({
    super.key,
    required this.onToggleMicButtonPressed,
    required this.onLeaveButtonPressed,
    required this.onToggleCameraButtonPressed,
  });

  @override
  _MeetingControlsState createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool isCameraOpen = true;
  bool isMicOpen = true;

  void _toggleCamera() {
    setState(() {
      isCameraOpen = !isCameraOpen;
    });
    widget.onToggleCameraButtonPressed();
  }

  void _toggleMic() {
    setState(() {
      isMicOpen = !isMicOpen;
    });
    widget.onToggleMicButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: widget.onLeaveButtonPressed,
          child: const Text('Leave'),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFd93025), // Use the web background color
          ),
        ),
        ElevatedButton(
          onPressed: _toggleMic,
          // child: const Text('Toggle Mic'),
          child: Icon(
            isMicOpen ? Icons.mic : Icons.mic_off,
            color: Colors.white,
            size: 30,
          ),
        ),
        ElevatedButton(
          onPressed: _toggleCamera,
          child: Icon(
            isCameraOpen ? Icons.videocam : Icons.videocam_off,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}
