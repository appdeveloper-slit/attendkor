import 'package:attend_kor_teacher/manage/static_method.dart';
import 'package:attend_kor_teacher/sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Home extends StatefulWidget {
  final bool b;

  const Home({super.key, this.b = false});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext ctx;

  int selected1 = -1;
  int selected2 = -1;
  List likeList = [];
  List dislikeList = [];
  List<dynamic> gzodList = [
    {'img': 'assets/gzod1.png'},
    {'img': 'assets/gzod2.png'},
    {'img': 'assets/gzod1.png'},
    {'img': 'assets/gzod2.png'},
  ];

  // biometrics auth
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = false;
  bool checkFingerPrint = false;
  String? TeacherToken, StudentToken;

  Future<bool> _authenticateWithBiometrics() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth
          .authenticate(
        localizedReason: 'Scan your fingerprint or face to authentication',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      )
          .then((value) async {
        setState(() {
          value
              ? null
              : AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  title: 'AttendCore is lock',
                  desc:
                      'Authentication is required to access the attendcore app',
                  btnOkText: 'Unlock now',
                  btnOkColor: Clr().primaryColor,
                  btnOkOnPress: () {
                    _authenticateWithBiometrics();
                  },
                ).show();
        });
        return false;
      });
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
    }
    return authenticated;
  }

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      checkFingerPrint = sp.getBool('checkFinger') ?? false;
      TeacherToken = sp.getString('teacherToken') ?? null;
      StudentToken = sp.getString('studenttoken') ?? null;
    });
    if (widget.b && StudentToken != null) {
      _authenticateWithBiometrics();
    }
    // STM().checkInternet(context, widget).then((value) {
    //
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState =
            isSupported ? _SupportState.supported : _SupportState.unsupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DoubleBack(
      message: 'Press back once again to exit!!!',
      child: Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 0, Color(0xff32334D)),
        backgroundColor: Clr().white,
        appBar: AppBar(
            toolbarHeight: 60,
            elevation: 2,
            backgroundColor: Color(0xffDA9C83),
            centerTitle: true,
            leadingWidth: 40,
            leading: SvgPicture.asset('assets/appbar.svg'),
            title: InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.clear();
              },
              child: Text(
                'GZOD',
                style: Sty().mediumText.copyWith(
                    color: Color(0xff32334D),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d12),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: gzodList.length,
                itemBuilder: (context, index) {
                  bool isLike = false;
                  bool isdisLike = false;
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        margin: EdgeInsets.only(bottom: Dim().d20),
                        decoration: BoxDecoration(
                          color: Clr().white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Clr().borderColor.withOpacity(0.8),
                              spreadRadius: 0.5,
                              blurRadius: 4,
                              offset:
                                  Offset(5, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                  child: Image.asset(gzodList[index]['img'])),
                              SizedBox(
                                height: Dim().d8,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: Dim().d12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (likeList.contains(index)) {
                                                  setState(() {
                                                    likeList.remove(index);
                                                    isLike = false;
                                                  });
                                                } else {
                                                  setState(
                                                    () {
                                                      isLike = true;
                                                      likeList.add(index);
                                                      dislikeList.remove(index);
                                                    },
                                                  );
                                                }
                                              },
                                              // child: SvgPicture.asset(
                                              //     likeList.contains(index)
                                              //         ? 'assets/likefill.svg'
                                              //         : 'assets/like.svg'),
                                              child: likeList.contains(index)
                                                  ? Lottie.asset(
                                                      'animations/like_fill.json',
                                                      height: 24,
                                                      reverse: false,
                                                      repeat: false,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : SizedBox(
                                                      height: 24,
                                                      child: SvgPicture.asset(
                                                          'assets/like.svg')),
                                            ),
                                            SizedBox(
                                              height: Dim().d2,
                                            ),
                                            Text('200')
                                          ],
                                        ),
                                        SizedBox(
                                          width: Dim().d20,
                                        ),
                                        SizedBox(
                                          width: 24,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (dislikeList
                                                      .contains(index)) {
                                                    setState(() {
                                                      dislikeList.remove(index);
                                                      isdisLike = true;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      dislikeList.add(index);
                                                      likeList.remove(index);
                                                      isdisLike = false;
                                                    });
                                                  }
                                                  // STM().redirect2page(ctx, Electronics(categoryList[index]['id'].toString()));
                                                },
                                                child: SizedBox(
                                                  height: 25,
                                                  child: dislikeList
                                                          .contains(index)
                                                      ? Lottie.asset(
                                                          'animations/dislike_fill.json',
                                                          height: 27,
                                                          reverse: false,
                                                          repeat: false,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : SizedBox(
                                                          height: 24,
                                                          child: SvgPicture.asset(
                                                              'assets/dislike.svg'),
                                                        ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dim().d2,
                                              ),
                                              Text('50')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '12 Apr 2023',
                                      style: Sty().smallText.copyWith(
                                          fontFamily: '',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dim().d8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// showFingerPrintDialog() {
//   return AwesomeDialog(
//       context: context,
//       width: double.infinity,
//       dismissOnTouchOutside: authenticated ? true : false,
//       dismissOnBackKeyPress: authenticated ? true : false,
//       dialogType: DialogType.noHeader,
//       dialogBackgroundColor: Clr().background1,
//       animType: AnimType.scale,
//       alignment: Alignment.bottomCenter,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Dim().d16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('FingerPrint is required',
//                 style: Sty().mediumText.copyWith(
//                     fontWeight: FontWeight.w500, fontSize: Dim().d20)),
//             SizedBox(height: Dim().d20),
//             IconButton(
//                 onPressed: () {},
//                 color: Clr().primaryColor,
//                 iconSize: Dim().d56,
//                 icon: Icon(Icons.fingerprint)),
//             Text('Click here!!',
//                 style: Sty().mediumText.copyWith(
//                     fontSize: Dim().d12,
//                     fontWeight: FontWeight.w300,
//                     color: Clr().hintColor)),
//             SizedBox(height: Dim().d20),
//           ],
//         ),
//       ))
//     ..show();
// }

// Session() async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   if (_supportState == _SupportState.supported) {
//     if (StudentToken != null) {
//       checkFingerPrint ? null : _authenticateWithBiometrics();
//       print('${checkFingerPrint}');
//     }
//   } else {
//     sp.clear();
//     STM().finishAffinity(ctx, SignIn());
//   }
// }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
