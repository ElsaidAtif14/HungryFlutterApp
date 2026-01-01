import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/splach.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Splach(),
    );
  }
}
