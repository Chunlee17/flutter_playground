import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapUtils {
  static final imageWidth = 50;
  static Future<Uint8List> getBytesFromCanvas({double width = 400, double height = 200}) async {
    final UI.PictureRecorder pictureRecorder = UI.PictureRecorder();

    //create canvas and paint
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.pink;

    //load image from asset
    final image = await loadUiImage("assets/pin.png");
    //draw RRect for background
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, width, height / 2), Radius.circular(24)), paint);
    //draw image to canvas
    canvas.drawImage(image, Offset(width / 2 - (imageWidth / 2), height - image.height), paint);
    //create textpainter object to draw text
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: "   This is my location   ",
      style: TextStyle(fontSize: 32.0, color: Colors.white),
    );
    painter.layout();
    //draw textpainter to canvas
    painter.paint(canvas, Offset(width / 2 - (painter.width / 2), 32));

    //convert canvas to Uint8List
    UI.Image img = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
    ByteData data = await img.toByteData(format: UI.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  static Future<UI.Image> loadUiImage(String imageAssetPath) async {
    //load image form asset
    final ByteData data = await rootBundle.load(imageAssetPath);
    //resize image
    UI.Codec codec = await UI.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: imageWidth);
    UI.FrameInfo fi = await codec.getNextFrame();
    //convert image back to bytedata
    final ByteData newImageData = await fi.image.toByteData(format: UI.ImageByteFormat.png);
    //convert bytedata to UI.Image
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(newImageData.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}
