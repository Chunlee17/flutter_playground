import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapUtils {
  static int index = 1;
  static Future<Uint8List> getBytesFromCanvas({double width = 190, double height = 220, String imageUrl = "https://picsum.photos/150"}) async {
    final UI.PictureRecorder pictureRecorder = UI.PictureRecorder();
    final path = Path();
    final shadowPath = Path();
    final bottomArrowHeight = height - width;
    final markerRealHeight = height - bottomArrowHeight;
    final markerImageMargin = 32;
    final markerImageBottomMargin = 64;
    final imageHeight = markerRealHeight - markerImageBottomMargin;
    //create canvas and paint
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint();
    paint.color = Colors.pink;

    path.lineTo(0, markerRealHeight);
    path.lineTo(width * 0.5 - 20, markerRealHeight);
    path.lineTo(width / 2, height);
    path.lineTo(width * 0.5 + 20, markerRealHeight);
    path.lineTo(0, markerRealHeight);
    //path.lineTo(width, 0);

    shadowPath.lineTo(0, markerRealHeight);
    shadowPath.lineTo(width, markerRealHeight);
    shadowPath.lineTo(width, 0);

    //load image from asset
    UI.Image image = await loadUIImageFromNetwork(imageUrl, width: width - markerImageMargin, height: imageHeight);
    //draw RRect for background
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, width, markerRealHeight), Radius.circular(24)), paint);
    canvas.drawPath(path, paint);

    //draw image to canvas
    canvas.drawImage(image, Offset(width / 2 - (image.width / 2), markerImageMargin / 2), paint);
    //create textpainter object to draw text
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);

    painter.text = TextSpan(
      text: "US\$155",
      style: TextStyle(fontSize: 26.0, color: Colors.white),
    );
    painter.layout();
    //draw textpainter to canvas
    painter.paint(canvas, Offset(width / 2 - (painter.width / 2), imageHeight + 24));

    //convert canvas to Uint8List
    UI.Image img = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
    ByteData data = await img.toByteData(format: UI.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  static Future<UI.Image> loadUIImageFromAsset(String imageAssetPath) async {
    int imageWidth = 150;
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

  static Future<UI.Image> loadUIImageFromNetwork(String path, {double width, double height}) async {
    print("$index: Decode image from $path");
    index++;
    Completer<ImageInfo> imageNetworkCompleter = Completer();
    ImageProvider img = NetworkImage(path + "?quality=10&compression=1&width=$width");
    img.resolve(ImageConfiguration()).addListener(ImageStreamListener((ImageInfo info, bool _) {
      imageNetworkCompleter.complete(info);
    }));
    ImageInfo imageInfo = await imageNetworkCompleter.future;
    //return imageInfo.image;
    ByteData imageByedData = await imageInfo.image.toByteData(format: UI.ImageByteFormat.png);
    //resize image
    UI.Codec codec = await UI.instantiateImageCodec(imageByedData.buffer.asUint8List(), targetWidth: width.toInt(), targetHeight: height.toInt());
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
