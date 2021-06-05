import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:realtime_object_detection/helpers/binding_box.dart';
import 'package:realtime_object_detection/helpers/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class HomePage extends StatefulWidget {
  // static String id = 'home';

  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!");
    return true;
  }

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String res;
    res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time Object Detection AI"),
      ),
      floatingActionButton: _model == ""
          ? FloatingActionButton(
              child: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onPressed: () {
                // setState(() {
                //   Future.delayed(
                //       Duration(seconds: 3), () => CircularProgressIndicator());
                // });
                onSelect(ssd);
              },
            )
          : FloatingActionButton(
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _model = "";
                });
              }),
      body: _model == ""
          ? Center(
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
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),
    );
  }
}
