import 'package:flutter/material.dart';
import 'package:simple_todo/pages/home_page.dart';
import 'package:simple_todo/utils/notification_service.dart';

late NotificationService notificationService;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  notificationService = NotificationService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}