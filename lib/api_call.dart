import 'dart:convert';
import 'package:http/http.dart' as http;

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIwMDllMzRiOC00YmRlLTRlYzUtOTQzZi05Y2FiMmQ0ZDY5MzAiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNTY5NTc1NywiZXhwIjoxNzE2MzAwNTU3fQ.CAoueercCXz2fhCh0UnVK62uvkFE8WuPEugwO0mazmA";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}