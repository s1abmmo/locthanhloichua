import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';
import 'main.dart';
import 'dart:math';
// import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

class Popup extends StatefulWidget {
  final String text;
  Popup({Key key, @required this.text}) : super(key: key);
  @override
  _Popup createState() => _Popup();
}

Random rd = new Random();

class _Popup extends State<Popup> {
  TextEditingController nameController = new TextEditingController();
  String content = listregards == null
      ? ""
      : listregards[rd.nextInt(listregards.length)].content;

  String imagepath;
  bool _visible = false;
  // bool saveload = false;
  // bool loading = false;
  var soundclick = new AudioPlayer();
  bool soundclickloaded=false;

  static final GlobalKey<FormState> previewContainer =
      new GlobalKey<FormState>(debugLabel: 'test');

  // Future<String> _saveScreen() async {
  //   RenderRepaintBoundary boundary =
  //       previewContainer.currentContext.findRenderObject();
  //   ui.Image image = await boundary.toImage();
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   File imgFile = new File('$directory/screenshot.png');
  //   // print(pngBytes);
  //   // print(imgFile.uri);
  //   // print(await File('$directory/screenshot.png').readAsBytes());
  //   imgFile.writeAsBytes(pngBytes);
  //   return '$directory/screenshot.png';
  // }

  // Future<String> _saveScreen() async {
  //   RenderRepaintBoundary boundary =
  //       previewContainer.currentContext.findRenderObject();
  //   ui.Image image = await boundary.toImage(pixelRatio: 2.0);
  //   final directory = '/storage/emulated/0';
  //   // final directory = (await getExternalStorageDirectory()).path;
  //   final path = directory+'/'+DateTime.now().toUtc().millisecondsSinceEpoch.toString()+'.png';
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   File imgFile = new File(path);
  //   // print(pngBytes);
  //   print(imgFile.uri);
  //   // print(await File('$directory/screenshot.png').readAsBytes());
  //   imgFile.writeAsBytes(pngBytes);
  //   imagepath=path;
  //   return imagepath;
  // }

  Future<String> _saveScreen() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 80);
    // print((await getApplicationDocumentsDirectory()).path+'_'+result['filePath']);
    // print(result['filePath']);
    print(result['filePath']);
    imagepath = (result['filePath'].replaceAll(RegExp(r'file:\/\/'), ''))
        .replaceAll(
            RegExp(r'L%E1%BB%99c%20Th%C3%A1nh%20L%E1%BB%9Di%20Ch%C3%BAa'),
            'Lộc Thánh Lời Chúa');
    print(imagepath);
    return imagepath;
  }

  Future<bool> saveImage() async {
    bool success = false;
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      PermissionStatus statuses = await Permission.storage.request();
      if (statuses.isGranted)
        await _saveScreen()
            .then((value) => {imagepath = value, success = true});
    } else if (status.isGranted) {
      await _saveScreen().then((value) => {imagepath = value, success = true});
    }
    return success;
  }

  OpenBag() async {
    await soundclick.setAsset('assets/ring.mp3');
    soundclickloaded = true;
  }

  void initState() {
    super.initState();
    OpenBag();
  }

    @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      content: RepaintBoundary(
        key: previewContainer,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          // width: MediaQuery.of(context).size.width * 0.6,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: Stack(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                      image: nenpopup,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // color: Colors.red,
                  child: Hero(
                    tag: widget.text,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 72,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 35,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // padding: EdgeInsets.only(
                                    //     left: width * 0.42, top: height * 0.05),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: height * 0.02),
                                      child: Text(name,
                                          style: TextStyle(
                                              fontFamily: 'tahomabd',
                                              fontSize: height * 0.04,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            // color: Colors.green,
                            padding: EdgeInsets.fromLTRB(
                                width * 0.18, 0, width * 0.1, 0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontFamily: 'tahomabd',
                                      fontSize: height * 0.06,
                                      color: Colors.red)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.003),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: Container(
                                      // padding: EdgeInsets.all(height * 0.02),
                                      child: InkWell(
                                        onTap: () {
                                          // setState(() {
                                          //   saveload = true;
                                          // });
                                          HapticFeedback.vibrate();
                                          if (soundclickloaded && !mute)
                                          {
                                            soundclick.load();
                                            soundclick.play();
                                          }
                                          saveImage().then((value) => {
                                                // setState(() {
                                                //   saveload = false;
                                                // }),
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500), () {
                                                  setState(() {
                                                    _visible = true;
                                                  });
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 1000),
                                                      () {
                                                    setState(() {
                                                      _visible = false;
                                                    });
                                                  });
                                                })
                                              });
                                        },
                                        child: Image.asset('assets/save.png'),
                                        // child: Container(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: height * 0.02),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: Container(
                                      // padding: EdgeInsets.all(height * 0.02),
                                      child: InkWell(
                                        onTap: () {
                                          // setState(() {
                                          //   loading = true;
                                          // });
                                          HapticFeedback.vibrate();
                                          if (soundclickloaded && !mute)
                                          {
                                            soundclick.load();
                                            soundclick.play();
                                          }
                                          imagepath == null
                                                  ? saveImage()
                                                      .then((value) => {
                                                            if (value)
                                                              SocialShare
                                                                  .shareOptions(
                                                                      "",
                                                                      imagePath:
                                                                          imagepath)
                                                            // .then((value) =>
                                                            //     setState(() {
                                                            //       loading = false;
                                                            //     }))
                                                          })
                                                  : SocialShare.shareOptions("",
                                                      imagePath: imagepath)
                                              // .then((value) => setState(() {
                                              //       loading = false;
                                              //     }))
                                              ;
                                        },
                                        child: Image.asset('assets/share.png'),

                                        // Container(
                                        //     padding: EdgeInsets.all(height * 0.02),
                                        //   )
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    flightShuttleBuilder: (flightContext, animation, direction,
                        fromContext, toContext) {
                      return Container(
                        height: height * 0.4,
                        width: width * 0.4,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/tuilixi.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    // If the widget is visible, animate to 0.0 (invisible).
                    // If the widget is hidden, animate to 1.0 (fully visible).
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1000),
                    // The green box must be a child of the AnimatedOpacity widget.
                    child: Container(
                      height: height * 0.1,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey,
                        // border: Border(
                        //   left: BorderSide(
                        //     color: Colors.green,
                        //     width: 3,
                        //   ),
                        // ),
                      ),
                      child: Center(
                        child: Text(
                          "Đã lưu",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.04),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
