// import 'dart:io';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'package:image_picker/image_picker.dart';
// import 'package:toast/toast.dart';

// class FirebaseFaceDetectionDemo extends StatefulWidget {
//   @override
//   _FirebaseFaceDetectionDemoState createState() => _FirebaseFaceDetectionDemoState();
// }

// class _FirebaseFaceDetectionDemoState extends State<FirebaseFaceDetectionDemo> {
//   File _image;
//   List<Face> faces;
//   ui.Image img;
//   final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();

//   _pickImage() async {
//     _image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     _detectFace();
//   }

//   _detectFace() async {
//     if (_image == null) {
//       print('No image');
//       return;
//     }
//     final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
//     faces = await faceDetector.processImage(visionImage);
//     img = await loadImageFromFile(_image);
//     if (faces.isEmpty) Toast.show("No face found", context, duration: 3);
//     setState(() {});
//   }

//   Future<ui.Image> loadImageFromFile(File file) async {
//     var data = await file.readAsBytes();
//     return decodeImageFromList(data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Face detection"),
//         actions: <Widget>[
//           IconButton(
//             onPressed: _detectFace,
//             icon: Icon(Icons.settings_overscan),
//           )
//         ],
//       ),
//       body: img != null
//           ? Center(
//               child: FittedBox(
//                 child: SizedBox(
//                   width: img.width.toDouble(),
//                   height: img.height.toDouble(),
//                   child: CustomPaint(
//                     painter: FacePainter(img, faces),
//                   ),
//                 ),
//               ),
//             )
//           : Container(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _pickImage,
//         child: Icon(Icons.add_a_photo),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   final ui.Image image;
//   final List<Face> faces;
//   final List<Rect> rects = [];

//   FacePainter(this.image, this.faces) {
//     for (var i = 0; i < faces.length; i++) {
//       rects.add(faces[i].boundingBox);
//     }
//   }

//   @override
//   void paint(ui.Canvas canvas, ui.Size size) {
//     final Paint paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..color = Colors.yellow;

//     canvas.drawImage(image, Offset.zero, Paint());
//     for (var i = 0; i < faces.length; i++) {
//       canvas.drawRect(rects[i], paint);
//     }
//   }

//   @override
//   bool shouldRepaint(FacePainter oldDelegate) {
//     return true;
//   }
// }
