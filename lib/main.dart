import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: '',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// FirebaseFirestore firestore = FirebaseFirestore.instance;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    Firebase.initializeApp().then((value) => {
          FirebaseFirestore.instance.collection("users").add({
            "address": {"city": "hanoi", "location": "viet nam"},
            "name": "bitch",
            "age": "50"
          }).then((value) {
            print(value);
          })
        });

    _controller = AnimationController(
      duration: const Duration(seconds: 45),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          // shape: BoxShape.circle,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.white60.withOpacity(0.9), BlendMode.dstATop),
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.1),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.4),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child:
                              Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.2),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.5),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.2),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.1),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.4),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: height * 0.3),
                        width: 50,
                        height: 50,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            // print(_controller.value);
                            return new Transform(
                              alignment: FractionalOffset.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(_controller.value * 45.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tuilixi.png"),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),

                              ),
                            );
                          },
                        )),
                  ),
                ),

              ]),
            ),
            Container(
              height: 50,
              width: double.infinity,
              // color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
