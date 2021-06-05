import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:realtime_object_detection/screens/home_screen.dart';

class LandingPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  LandingPage(this.cameras);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // List<CameraDescription> cameras;
  //
  // fetchCameras() async {
  //   try {
  //     cameras = await availableCameras();
  //   } on CameraException catch (e) {
  //     print('Error: $e.code\nError Message: $e.message');
  //   }
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchCameras();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time Object Detection"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera,
          color: Colors.white,
        ),
        onPressed: () => HomePage(widget.cameras),
      ),
      body: Center(
        child: Container(
          height: 400.0,
          width: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/obj2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
