import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'Popup.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'ad_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

List<Regards> listregards;
SharedPreferences prefs;
AssetImage nenpopup;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // print('file:///storage/emulated/0/locthanhloichua/screenshot.jpg');
  await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  prefs = await SharedPreferences.getInstance();
  name = await prefs.getString('name') ?? null;
  mute = await prefs.getBool('mute') ?? false;
  // FirebaseFirestore.instance
  //     .collection("cauchuc")
  //     .doc("1sbF5ylM6X3z8trvOGeH")
  //     .update({
  //   "user": FieldValue.arrayUnion([
  //     {"content": "cucai 1", "date": DateTime.now()}
  //   ])
  // }),
  try {
    listregards = await getListRegards();
  } on Exception catch (_) {}

  runApp(MaterialApp(
    title: '',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future getListRegards() async {
  CollectionReference users = FirebaseFirestore.instance.collection("cauchuc");
  DocumentSnapshot doc1 = await users.doc('1sbF5ylM6X3z8trvOGeH').get();
  // print("content la" + Regards.FromData(doc1['user'][0]).content);
  List<Regards> lr = new List<Regards>();
  // print(doc1['user'][0].toString());
  // print(doc1[0]);
  doc1['user'].forEach((value) {
    lr.add(Regards.FromData(value));
  });
  return lr;
}

String name;
bool mute;

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool shownameinput = name == null ? true : false;
  TextEditingController nameController = new TextEditingController();
  var player = new AudioPlayer();
  var backgroundsound = new AudioPlayer();
  bool audioloaded = false;
  bool _visible=false;

  OpenBag() async {
    await player.setAsset('assets/ring.mp3');
    audioloaded = true;
  }

  PlayBackgroundSound() async {
    await backgroundsound.setAsset('assets/background.mp3');
    // await backgroundsound.setLoopMode(LoopMode.one);
    await backgroundsound.load();
    backgroundsound.play();
  }

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller = AnimationController(
      duration: const Duration(seconds: 45),
      vsync: this,
    )..repeat();

    OpenBag();
    if(!mute)
      PlayBackgroundSound();

    nenpopup= AssetImage("assets/nenpopup.jpg");
    // precacheImage(nenpopup,context);

    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show(horizontalCenterOffset: 0, anchorOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: new BoxDecoration(
          // shape: BoxShape.circle,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.white60.withOpacity(0.9), BlendMode.dstATop),
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                margin: EdgeInsets.only(top: height * 0.1),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                            {
                                              player.load();
                                              player.play();
                                            }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag1'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag1",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag2'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag2",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag3'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag3",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                margin: EdgeInsets.only(top: height * 0.6),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag4'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag4",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag5'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag5",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                margin: EdgeInsets.only(top: height * 0.0),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    // print(_controller.value);
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag6'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag6",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return new Transform(
                                      alignment: FractionalOffset.center,
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(_controller.value * 45.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (audioloaded && !mute)
                                          {
                                            player.load();
                                            player.play();
                                          }

                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              opaque: false,
                                              pageBuilder: (_, anim1, anim2) =>
                                                  Popup(text: 'tag7'),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: "tag7",
                                          child: AspectRatio(
                                            aspectRatio: 1 / 2,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: new BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/tuilixi.png"),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
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
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  // color: Colors.red,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding:
                EdgeInsets.only(bottom: height * 0.03, left: width * 0.01),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      mute = !mute;
                    });
                    prefs.setBool('mute', mute);
                    print('mute '+mute.toString());
                    if (mute) {
                      backgroundsound.pause();
                    }
                    // else {
                    //   backgroundsound.play();
                    // }
                  },
                  child: Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    child: mute
                        ? Image.asset('assets/sound_mute.png')
                        : Image.asset('assets/icon_sound.png'),
                  ),
                ),
              ),
            ),
            shownameinput
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: height * 0.1),
                      height: height * 0.4,
                      child: AspectRatio(
                        aspectRatio: 3 / 2,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.1,
                                child: AspectRatio(
                                  aspectRatio: 7 / 2,
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        // border: InputBorder.none,
                                        hintText: 'Nhập tên của bạn',
                                      hintStyle: TextStyle( fontSize: height*0.0375)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.125,
                                child: AspectRatio(
                                  aspectRatio: 3 / 2,
                                  child: InkWell(
                                    onTap: () {
                                      if(nameController.text==null || nameController.text==''){
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
                                      }else{
                                        name = nameController.text.toUpperCase();
                                        prefs.setString('name', name);
                                        setState(() {
                                          shownameinput = false;
                                        });
                                      }
                                    },
                                    child: Card(
                                        color: Colors.red,
                                        child: Center(
                                          child: Text('Đồng ý',
                                              style: TextStyle(
                                                color: Colors.white
                                                  ,fontSize: height*0.04)),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: height * 0.03, left: width * 0.07),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            shownameinput = true;
                          });
                        },
                        child: Container(
                          height: height * 0.07,
                          // width: height * 0.07,
                          child: Row(
                            children: [
                              Image.asset('assets/edit.png'),
                              Text('Sửa tên',
                                  style: TextStyle(
                                      fontSize: height*0.03)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding:EdgeInsets.only(top:height*0.07),
                child: AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: _visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 1000),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.5,
                    // padding: EdgeInsets.all(height*0.1),
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
                        "Vui lòng nhập tên của bạn",
                        style: TextStyle(color: Colors.white, fontSize: height*0.04),
                      ),
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Regards {
  String content;
  Timestamp date;

  Regards({this.content, this.date});
  Regards.FromData(Map<dynamic, dynamic> data)
      : content = data['content'],
        date = data['date'];
}

// public class MyFlutterFragment extends FlutterFragment {
//   @Override
//   protected SplashScreen provideSplashScreen() {
//     // Load the splash Drawable.
//     Drawable splash = getResources().getDrawable(R.drawable.my_splash);
//
//     // Construct a DrawableSplashScreen with the loaded splash
//     // Drawable and return it.
//     return new DrawableSplashScreen(splash);
//   }
// }

BannerAd _bannerAd;
const String testDevice = '7DCA8219690E3EA4C3BDA97AE3EA68C0';
// const String testDevice=null;

const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: testDevice != null ? <String>[testDevice] : null,
  keywords: <String>['foo', 'bar'],
  contentUrl: 'http://foo.com/bar.html',
  childDirected: true,
  nonPersonalizedAds: true,
);

BannerAd createBannerAd() {
  return BannerAd(
    adUnitId: AdManager.bannerAdUnitId, //BannerAd.testAdUnitId
    size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event $event");
    },
  );
}
