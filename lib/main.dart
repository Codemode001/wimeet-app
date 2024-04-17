import 'package:flutter/material.dart';
import 'package:wimeet/screens/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// void main() {
//   runApp(const MyApp());
// }
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://jwttosbyanejoxjfhnns.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3dHRvc2J5YW5lam94amZobm5zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAxNDEwNTIsImV4cCI6MjAyNTcxNzA1Mn0._OEa951Ft1NITsVMCZ9oBUqq_Pw7KtdHrD_cZ7Ht2no',
    );
    runApp(MyApp());
  }

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
