import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:realtime_object_detection/screens/home_screen.dart';
import 'package:realtime_object_detection/screens/landing.dart';

List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
      // routes: {
      //   HomePage.id: (context) => HomePage(cameras),
      // },
      home: HomePage(cameras),
    );
  }
}
