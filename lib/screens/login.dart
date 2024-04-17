import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wimeet/screens/home.dart';
import 'package:wimeet/screens/signup.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 50),
              Image.network(
                'https://res.cloudinary.com/dhhamkkue/image/upload/v1713230931/WiMeet/small_a7je1b.png',
                height: 100,
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final sm = ScaffoldMessenger.of(context);
                  try {
                    final authResponse = await supabase.auth.signInWithPassword(
                      password: passwordController.text,
                      email: emailController.text,
                    );
                    sm.showSnackBar(SnackBar(content: Text("Account Signed in ${authResponse.user?.email}")));
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (context) => HomePage(),), (route) => false);
                  } catch (e) {
                    if (e is AuthException) {
                      sm.showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
                    } else {
                      sm.showSnackBar(SnackBar(content: Text("Unexpected error occurred")));
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Implement forgot password functionality
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => SignUpPage(),), (route) => false);
                },
                child: Text('CREATE ACCOUNT'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
