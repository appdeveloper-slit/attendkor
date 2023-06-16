import 'dart:convert';
import 'dart:io';
import 'package:attend_kor_teacher/get_report.dart';
import 'package:attend_kor_teacher/reset_password.dart';
import 'package:attend_kor_teacher/sign_in.dart';
import 'package:attend_kor_teacher/values/strings.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation/bottom_navigation.dart';
import 'home.dart';
import 'manage/static_method.dart';
import 'publish_notice.dart';
import 'timetable.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyProfile extends StatefulWidget {
  final loop;

  const MyProfile({super.key, this.loop});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late BuildContext ctx;

  /// For Teacher variables
  var data, instituteData;
  String? TeacherToken, profile, pic, StudentToken;
  File? imageFile;
  List allAlertDialog = [];

  /// update password alert dialog
  bool ishidden = true;
  bool ishidden1 = true;
  bool again = false;
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController currentPassCtrl = TextEditingController();
  TextEditingController conPassCtrl = TextEditingController();
  TextEditingController institutionCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final passkey = GlobalKey<FormState>();

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? null;
      StudentToken = sp.getString('studenttoken') ?? null;
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        print(TeacherToken ?? StudentToken);
        getProfile();
      }
    });
  }

  @override
  void initState() {
    getSession();
  }

  String SelectedValue = 'Select Institution Type';
  List<String> selectedList = [
    'Select Institution Type',
    'Institution 1',
    'Institution 2',
    'Institution 3',
    'Institution 4',
  ];
  String t = "0";

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        if (widget.loop == 'timetable') {
          STM().replacePage(ctx, TimeTable(loop: 'profile'));
        } else {
          STM().back2Previous(ctx);
        }
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: bottomBarLayout(ctx, 2, Color(0xff32334D)),
        backgroundColor: Clr().white,
        body: SingleChildScrollView(
          child:  TeacherToken != null
                  ? TeacherBoxLayout()
                  : StudentboxLayout(),
        ),
      ),
    );
  }

  //Pop Up
  _showSuccessDialog(ctx) {
    AwesomeDialog(
      isDense: true,
      width: double.infinity,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d12),
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       border: Border.all(color: Clr().textcolor)),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton<String>(
            //       value: SelectedValue,
            //       isExpanded: true,
            //       icon: Icon(
            //         Icons.keyboard_arrow_down,
            //         size: 28,
            //         color: Clr().textcolor,
            //       ),
            //       style: TextStyle(color: Color(0xff787882)),
            //       items: selectedList.map((String string) {
            //         return DropdownMenuItem<String>(
            //           value: string,
            //           child: Text(
            //             string,
            //             style: TextStyle(color: Clr().textcolor, fontSize: 14),
            //           ),
            //         );
            //       }).toList(),
            //       onChanged: (t) {
            //         // STM().redirect2page(ctx, Home());
            //         setState(() {
            //           SelectedValue = t!;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: Dim().d20,
            ),
            TextFormField(
                controller: institutionCtrl,
                cursorColor: Clr().textcolor,
                keyboardType: TextInputType.text,
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Clr().textcolor,
                      ),
                    ),
                    hintText: 'Enter Institution Code',
                    hintStyle: Sty().mediumText.copyWith(
                          color: Clr().hintColor,
                          fontSize: 14,
                        ))),
            SizedBox(
              height: Dim().d20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    addClg();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().textcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Dim().d14),
              //   child: SizedBox(
              //     height: Dim().d56,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xff991404),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //       onPressed: () {
              //         if (formkey.currentState!.validate()) {
              //           // updateUser();
              //           widget.sType == 'addAddress'? getaddAddress():getUpdateAddress();
              //         }
              //       },
              //       child: Center(
              //         child: Text(
              //           'Save address',
              //           style: Sty().mediumText.copyWith(color: Clr().white),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            SizedBox(
              height: Dim().d28,
            ),
          ],
        ),
      ),
    ).show();
  }

  /// Teacher Screen Layout
  Widget TeacherBoxLayout() {
    return Column(
      children: [
        data == null
            ? SizedBox(
            height: MediaQuery.of(ctx).size.height / 1.5,
            child: STM().loadingPlaceHolder())
            : Container(
          decoration: BoxDecoration(
              color: Color(0xff20213f),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              )),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d40,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: Dim().d120,
                        width: Dim().d120,
                        decoration: BoxDecoration(
                          color: Clr().lightGrey,
                          border: Border.all(
                            color: Clr().grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dim().d100),
                          ),
                        ),
                        child: ClipOval(
                          child: imageFile == null
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: data['profile_photo'] ??
                                      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                                  placeholder: (context, url) =>
                                      STM().loadingPlaceHolder(),
                                )
                              : Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Clr().background1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dim().d14),
                                            topRight:
                                                Radius.circular(Dim().d14))),
                                    builder: (index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dim().d12,
                                                vertical: Dim().d20),
                                            child: Text('Profile Photo',
                                                style: Sty().mediumBoldText),
                                          ),
                                          SizedBox(height: Dim().d28),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _getProfile(
                                                      ImageSource.camera,
                                                      CropStyle.circle);
                                                },
                                                child: SvgPicture.asset(
                                                    'assets/camera.svg'),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _getProfile(
                                                      ImageSource.gallery,
                                                      CropStyle.circle);
                                                },
                                                child: SvgPicture.asset(
                                                    'assets/gallery.svg'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Dim().d40),
                                        ],
                                      );
                                    });
                              },
                              child: SvgPicture.asset('assets/cam.svg')),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                RichText(
                  text: TextSpan(
                    text: "Institution:- ",
                    style: Sty().smallText.copyWith(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          color: Clr().accentColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${data['college_name'].toString()}',
                        style: Sty().smallText.copyWith(
                            color: Color(0xffFCEBE3),
                            fontWeight: FontWeight.w300,
                            fontFamily: '',
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         text: "Stream:-",
                //         style: Sty().smallText.copyWith(
                //               fontFamily: '',
                //               fontWeight: FontWeight.w300,
                //               color: Clr().accentColor,
                //               // color: Color(0xff2D2D2D),
                //             ),
                //         children: <TextSpan>[
                //           TextSpan(
                //             text: ' Electronics & Telecommunications',
                //             style: Sty().smallText.copyWith(
                //                   color: Color(0xffFCEBE3),
                //                   fontWeight: FontWeight.w300,
                //                   fontFamily: '',
                //                 ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     SvgPicture.asset('assets/edit.svg'),
                //   ],
                // ),
                // SizedBox(
                //   height: Dim().d12,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Name:-",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Clr().accentColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${data['name'].toString()}',
                              style: Sty().smallText.copyWith(
                                    color: Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 0);
                        },
                        child: SvgPicture.asset('assets/edit.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                RichText(
                  text: TextSpan(
                    text: "Email Address:-",
                    style: Sty().smallText.copyWith(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          color: Clr().accentColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${data['email'].toString()}',
                        style: Sty().smallText.copyWith(
                              color: Color(0xffFCEBE3),
                              fontWeight: FontWeight.w300,
                              fontFamily: '',
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                RichText(
                  text: TextSpan(
                    text: "Gender:- ",
                    style: Sty().smallText.copyWith(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          color: Clr().accentColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${data['gender'].toString()}',
                        style: Sty().smallText.copyWith(
                              color: Color(0xffFCEBE3),
                              fontWeight: FontWeight.w300,
                              fontFamily: '',
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Password:- ",
                        style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().accentColor,
                              // color: Color(0xff2D2D2D),
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *************',
                            style: Sty().smallText.copyWith(
                                  color: Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: '',
                                ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 3);
                        },
                        child: SvgPicture.asset('assets/edit pencil.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Bio:- ",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Clr().accentColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${data['bio'] ?? '-'}',
                              style: Sty().smallText.copyWith(
                                    color: Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 1);
                        },
                        child: SvgPicture.asset('assets/edit pencil.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Qualification:-",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Clr().accentColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${data['qualification'] ?? '-'}',
                              style: Sty().smallText.copyWith(
                                    color: Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox();
                        },
                        child: SvgPicture.asset('assets/edit pencil.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dim().d28,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                // permissionHandle();
                STM().redirect2page(ctx, GetReports());
                // if (formKey.currentState!.validate()) {
                //   STM().checkInternet(context, widget).then((value) {
                //     if (value) {
                //       sendOTP();
                //     }
                //   });
                // }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Clr().textcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/reports.svg',
                    color: Color(0xffFCEBE3),
                  ),
                  SizedBox(
                    width: Dim().d8,
                  ),
                  Text(
                    'Get Reports',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xffFCEBE3),
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: Dim().d20,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: Clr().accentColor,
                  backgroundColor: Clr().white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Clr().textcolor),
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                STM().redirect2page(ctx, PublishNotice());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/pin.svg'),
                  SizedBox(
                    width: Dim().d8,
                  ),
                  Text(
                    'Publish Notice',
                    style: TextStyle(
                      color: Clr().textcolor,
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: Dim().d40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Color(0xfffdf0ea))),
            child: Padding(
              padding: EdgeInsets.all(Dim().d8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      SvgPicture.asset('assets/chat.svg'),
                      SizedBox(
                        width: Dim().d12,
                      ),
                      Text(
                        'Admin Chat',
                        style: Sty().mediumText.copyWith(
                              color: Clr().textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Clr().textcolor,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        InkWell(onTap: (){
          STM().openWeb('https://sonibro.com/attentkor/api/privacy_policy');
        },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d12),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color(0xfffdf0ea))),
              child: Padding(
                padding: EdgeInsets.all(Dim().d8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/privacy_policy.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Text(
                          'Privacy Policy',
                          style: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Clr().textcolor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: InkWell(
            onTap: () {
              // STM().redirect2page(ctx, SuperAdminMessage());
              STM().openWeb('https://sonibro.com/attentkor/api/term_condition');
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color(0xfffdf0ea))),
              child: Padding(
                padding: EdgeInsets.all(Dim().d8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/t&c.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Text(
                          'Terms & Conditions',
                          style: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Clr().textcolor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Color(0xfffdf0ea))),
            child: Padding(
              padding: EdgeInsets.all(Dim().d8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      SvgPicture.asset('assets/rate.svg'),
                      SizedBox(
                        width: Dim().d12,
                      ),
                      Text(
                        'Rate My App',
                        style: Sty().mediumText.copyWith(
                              color: Clr().textcolor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Clr().textcolor,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d32,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Clr().borderColor.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
            height: 45,
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: Clr().accentColor,
                  backgroundColor: Clr().white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Clr().borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.clear();
                  STM().finishAffinity(ctx, SignIn());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/log_out.svg'),
                    SizedBox(width: Dim().d12),
                    Text(
                      'Log Out',
                      style: Sty().smallText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          height: Dim().d40,
        ),
      ],
    );
  }

  /// student screen Layout
  Widget StudentboxLayout() {
    return Column(
      children: [
        data == null
            ? SizedBox(
            height: MediaQuery.of(ctx).size.height / 1.5,
            child: STM().loadingPlaceHolder())
            : Container(
          decoration: BoxDecoration(
              color: Color(0xff20213f),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              )),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d40,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: Dim().d120,
                        width: Dim().d120,
                        decoration: BoxDecoration(
                          color: Clr().lightGrey,
                          border: Border.all(
                            color: Clr().grey,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dim().d100),
                          ),
                        ),
                        child: ClipOval(
                          child: imageFile == null
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: data['profile_photo'] ??
                                      'https://t4.ftcdn.net/jpg/00/64/67/27/360_F_64672736_U5kpdGs9keUll8CRQ3p3YaEv2M6qkVY5.jpg',
                                  placeholder: (context, url) =>
                                      STM().loadingPlaceHolder(),
                                )
                              : Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Clr().background1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dim().d14),
                                            topRight:
                                                Radius.circular(Dim().d14))),
                                    builder: (index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dim().d12,
                                                vertical: Dim().d20),
                                            child: Text('Profile Photo',
                                                style: Sty().mediumBoldText),
                                          ),
                                          SizedBox(height: Dim().d28),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _getProfile(
                                                      ImageSource.camera,
                                                      CropStyle.circle);
                                                },
                                                child: SvgPicture.asset(
                                                    'assets/camera.svg'),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _getProfile(
                                                      ImageSource.gallery,
                                                      CropStyle.circle);
                                                },
                                                child: SvgPicture.asset(
                                                    'assets/gallery.svg'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: Dim().d40),
                                        ],
                                      );
                                    });
                              },
                              child: SvgPicture.asset('assets/cam.svg')),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Name:-",
                        style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().accentColor,
                              // color: Color(0xff2D2D2D),
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${data['name'].toString()}',
                            style: Sty().smallText.copyWith(
                                  color: Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: '',
                                ),
                          ),
                        ],
                      ),
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       AlertBox(i: 0);
                    //     },
                    //     child: SvgPicture.asset('assets/edit.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Mobile No.:-",
                        style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().accentColor,
                              // color: Color(0xff2D2D2D),
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${data['mobile'].toString()}',
                            style: Sty().smallText.copyWith(
                                  color: Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: '',
                                ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          updateMobileNumber();
                        },
                        child: SvgPicture.asset('assets/edit.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Email Address:-",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Clr().accentColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${data['email'].toString()}',
                              style: Sty().smallText.copyWith(
                                    color: Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 2);
                        },
                        child: SvgPicture.asset('assets/edit.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                RichText(
                  text: TextSpan(
                    text: "Date Of Birth:- ",
                    style: Sty().smallText.copyWith(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          color: Clr().accentColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${data['dob'].toString()}',
                        style: Sty().smallText.copyWith(
                              color: Color(0xffFCEBE3),
                              fontWeight: FontWeight.w300,
                              fontFamily: '',
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                RichText(
                  text: TextSpan(
                    text: "Gender:- ",
                    style: Sty().smallText.copyWith(
                          fontFamily: '',
                          fontWeight: FontWeight.w300,
                          color: Clr().accentColor,
                          // color: Color(0xff2D2D2D),
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${data['gender'].toString()}',
                        style: Sty().smallText.copyWith(
                              color: Color(0xffFCEBE3),
                              fontWeight: FontWeight.w300,
                              fontFamily: '',
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Password:- ",
                        style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().accentColor,
                              // color: Color(0xff2D2D2D),
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' *************',
                            style: Sty().smallText.copyWith(
                                  color: Color(0xffFCEBE3),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: '',
                                ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 3);
                        },
                        child: SvgPicture.asset('assets/edit pencil.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Bio:- ",
                          style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Clr().accentColor,
                                // color: Color(0xff2D2D2D),
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${data['bio'] ?? '-'}',
                              style: Sty().smallText.copyWith(
                                    color: Color(0xffFCEBE3),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: '',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          AlertBox(i: 1);
                        },
                        child: SvgPicture.asset('assets/edit pencil.svg')),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dim().d28,
        ),
        instituteData == false
            ? SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        // backgroundColor: Clr().accentColor,
                        backgroundColor: Clr().white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Clr().textcolor),
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      _showSuccessDialog(ctx);
                    },
                    child: Text(
                      '+ Add Institution/College',
                      style: Sty().smallText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w500,
                          ),
                    )),
              )
            : instituteData == null ?  Container() :
        instistuteDetails(details: instituteData[0]),
        SizedBox(
          height: Dim().d40,
        ),
        InkWell(onTap: (){
          STM().openWeb('https://sonibro.com/attentkor/api/privacy_policy');
        },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d12),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color(0xfffdf0ea))),
              child: Padding(
                padding: EdgeInsets.all(Dim().d8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/privacy_policy.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Text(
                          'Privacy Policy',
                          style: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Clr().textcolor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        InkWell(onTap: (){
          STM().openWeb('https://sonibro.com/attentkor/api/term_condition');
        },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d12),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color(0xfffdf0ea))),
              child: Padding(
                padding: EdgeInsets.all(Dim().d8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/t&c.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Text(
                          'Terms & Conditions',
                          style: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Clr().textcolor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: InkWell(
            onTap: () {
              // STM().redirect2page(ctx, SuperAdminMessage());
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Color(0xfffdf0ea))),
              child: Padding(
                padding: EdgeInsets.all(Dim().d8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        SvgPicture.asset('assets/super_admin.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        Text(
                          'Super Admin Messages',
                          style: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Clr().textcolor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Color(0xfffdf0ea))),
            child: Padding(
              padding: EdgeInsets.all(Dim().d8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      SvgPicture.asset('assets/rate.svg'),
                      SizedBox(
                        width: Dim().d12,
                      ),
                      Text(
                        'Rate My App',
                        style: Sty().mediumText.copyWith(
                              color: Clr().textcolor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Clr().textcolor,
                    size: 18,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dim().d32,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Clr().borderColor.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
            height: 45,
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: Clr().accentColor,
                  backgroundColor: Clr().white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Clr().borderColor,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.clear();
                  STM().finishAffinity(ctx, SignIn());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/log_out.svg'),
                    SizedBox(width: Dim().d12),
                    Text(
                      'Log Out',
                      style: Sty().smallText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          height: Dim().d40,
        ),
      ],
    );
  }

  /// get profile api for Teacher
  void getProfile() async {
    var result = await STM().get(
        ctx,
        Str().loading,
        'profile_details',
        TeacherToken ?? StudentToken,
        TeacherToken != null ? 'teacher/' : 'student/');
    var success = result['success'];
    if (success) {
      setState(() {
        data = result['data'];
        instituteData = result['student_college_details'];
      });
    }
  }

  /// add colleage
  void addClg() async {
    FormData body = FormData.fromMap({
      'institution_code': institutionCtrl.text,
    });
    var result = await STM().postWithToken(
        ctx, Str().processing, 'add_college', body, StudentToken, 'student/');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().back2Previous(ctx);
      STM().displayToast(message);
      getProfile();
    } else {
      STM().back2Previous(ctx);
      STM().errorDialog(ctx, message);
    }
  }

  /// get profile photo for Teacher
  _getProfile(source, cropstyle) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      CroppedFile? file = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: cropstyle);
      setState(() {
        imageFile = File(file!.path.toString());
        STM().back2Previous(ctx);
        var image = imageFile!.readAsBytesSync();
        profile = base64Encode(image);
      });
      getUpdateProfile(profile);
    }
  }

  /// Alert dailog Teacher profile
  AlertBox({i}) {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController bioCtrl = TextEditingController();
    TextEditingController qualCtrl = TextEditingController();
    return showDialog(
        context: context,
        builder: (index) {
          return i == 3
              ? AlertDialog(
                  content: Form(
                    key: passkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Password:- ',
                          style: Sty().smallText,
                        ),
                        TextFormField(
                          controller: currentPassCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Current Password is required';
                            }
                            return null;
                          },
                          decoration:
                              Sty().TextFormFieldOutlineDarkStyle.copyWith(
                                    hintStyle: Sty()
                                        .smallText
                                        .copyWith(color: Clr().hintColor),
                                    hintText: 'Enter Your Current Password',
                                  ),
                        ),
                        SizedBox(height: Dim().d12),
                        Text(
                          'New Password:- ',
                          style: Sty().smallText,
                        ),
                        TextFormField(
                          controller: newPassCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must contains minimum 6 characters';
                            }
                            return null;
                          },
                          decoration:
                              Sty().TextFormFieldOutlineDarkStyle.copyWith(
                                    hintStyle: Sty()
                                        .smallText
                                        .copyWith(color: Clr().hintColor),
                                    hintText: 'Enter Your New Password',
                                  ),
                        ),
                        SizedBox(height: Dim().d12),
                        Text(
                          'Confirm Password:- ',
                          style: Sty().smallText,
                        ),
                        TextFormField(
                          controller: conPassCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if (newPassCtrl.text != value) {
                              return 'Confirm password must be same as new password';
                            }
                            return null;
                          },
                          decoration:
                              Sty().TextFormFieldOutlineDarkStyle.copyWith(
                                    hintStyle: Sty().smallText.copyWith(
                                          color: Clr().hintColor,
                                        ),
                                    hintText: 'Enter Confirm Password',
                                  ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (passkey.currentState!.validate()) {
                                UpdatePassword();
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Clr().primaryColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                        ),
                        SizedBox(width: Dim().d12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              STM().back2Previous(ctx);
                              conPassCtrl.clear();
                              newPassCtrl.clear();
                              currentPassCtrl.clear();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Clr().primaryColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ))),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : AlertDialog(
                  title: Text(
                      i == 0
                          ? 'Change Name:'
                          : i == 1
                              ? 'Bio:'
                              : i == 2
                                  ? 'Change Email'
                                  : 'Qualifications:',
                      style: Sty().mediumBoldText),
                  content: TextFormField(
                    controller: i == 0
                        ? nameCtrl
                        : i == 1
                            ? bioCtrl
                            : i == 2
                                ? emailCtrl
                                : qualCtrl,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                          hintStyle:
                              Sty().mediumText.copyWith(color: Clr().hintColor),
                          hintText: i == 0
                              ? 'Enter Your New Name'
                              : i == 1
                                  ? 'Enter Your Bio'
                                  : i == 2
                                      ? 'Enter your new email'
                                      : 'Enter Your Qualifications',
                        ),
                  ),
                  actions: [
                    Center(
                      child: SizedBox(
                        height: Dim().d52,
                        width: Dim().d280,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Clr().primaryColor,
                            ),
                            onPressed: () async {
                              FormData body = FormData.fromMap(i == 0
                                  ? {
                                      'name': nameCtrl.text,
                                    }
                                  : i == 1
                                      ? {
                                          'bio': bioCtrl.text,
                                        }
                                      : i == 2
                                          ? {
                                              'email': emailCtrl.text,
                                            }
                                          : {
                                              'qualification': qualCtrl.text,
                                            });
                              var result = await STM().postWithToken(
                                  ctx,
                                  Str().updating,
                                  i == 0
                                      ? 'update_name'
                                      : i == 1
                                          ? 'update_bio'
                                          : i == 2
                                              ? 'update_email'
                                              : 'update_qualification',
                                  body,
                                  TeacherToken ?? StudentToken,
                                  TeacherToken != null
                                      ? 'teacher/'
                                      : 'student/');
                              var success = result['success'];
                              var message = result['message'];
                              if (success) {
                                STM().back2Previous(ctx);
                                getProfile();
                                STM().displayToast(message);
                              } else {
                                STM().back2Previous(ctx);
                                STM().errorDialog(ctx, message);
                              }
                            },
                            child: Center(
                              child: Text('Submit',
                                  style: Sty()
                                      .mediumText
                                      .copyWith(color: Clr().white)),
                            )),
                      ),
                    )
                  ],
                );
        });
  }

  /// student instituate details
  instistuteDetails({details}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dim().d12),
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Clr().textcolor,
              ),
              borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          color: Clr().white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dim().d20,
              vertical: Dim().d16,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Institution :',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: ''),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    Expanded(
                      child: Text(
                        '${details['college_name'].toString()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Sty().largeText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  children: [
                    Text(
                      'Unique ID :',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: ''),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    Text(
                        details['unique_id'] == null ? '' :  '  ${details['unique_id'].toString()}',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  children: [
                    Text(
                      'Stream :',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: ''),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    Text(
                      '  ${details['stream_name'].toString()}',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class (Year) :',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: ''),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    Expanded(
                      child: Text(
                        '  ${details['year_name'].toString()}',
                        style: Sty().largeText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Division :',
                      style: Sty().largeText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                          fontFamily: ''),
                    ),
                    SizedBox(
                      width: Dim().d4,
                    ),
                    Expanded(
                      child: Text(
                        '  ${details['division_name'].toString()}',
                        style: Sty().largeText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dim().d4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Labs group :",
                        style: Sty().largeText.copyWith(
                            color: Clr().textcolor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            fontFamily: ''),
                        children: <TextSpan>[
                          TextSpan(
                            text: details['lab_group'] == null ? '' : '  ${details['lab_group'].toString()}',
                            style: Sty().largeText.copyWith(
                                color: Clr().textcolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Clr().textcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            // STM().redirect2page(ctx, MyProfile());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/admin_msg.svg'),
                              SizedBox(
                                width: Dim().d8,
                              ),
                              Text(
                                'Admin',
                                style: Sty().smallText.copyWith(
                                      color: Color(0xfffcebe3),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

//Update mobile pop up
  /// use funtion for update student mobile number
  void updateMobileNumber() {
    bool otpsend = false;
    // var updateUserMobileNumberController;
    // updateUserMobileNumberController.text = "";
    // updateUserOtpController.text = "";
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (context) {
          TextEditingController updateUserMobileNumberController =
              TextEditingController();
          TextEditingController updateUserOtpController =
              TextEditingController();
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: Text("Change Mobile Number",
                  style:
                      Sty().mediumBoldText.copyWith(color: Color(0xff2C2C2C))),
              content: SizedBox(
                height: 130,
                width: MediaQuery.of(ctx).size.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                            visible: !otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "New Mobile Number",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller:
                                        updateUserMobileNumberController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Mobile filed is required';
                                      }
                                      if (value.length != 10) {
                                        return 'Mobile digits must be 10';
                                      }
                                    },
                                    maxLength: 10,
                                    decoration: Sty()
                                        .TextFormFieldOutlineStyle
                                        .copyWith(
                                          counterText: "",
                                          hintText: "Enter Mobile Number",
                                          prefixIconConstraints: BoxConstraints(
                                              minWidth: 50, minHeight: 0),
                                          suffixIconConstraints: BoxConstraints(
                                              minWidth: 10, minHeight: 2),
                                          border: InputBorder.none,
                                          // prefixIcon: Icon(
                                          //   Icons.phone,
                                          //   size: iconSizeNormal(),
                                          //   color: primary(),
                                          // ),
                                        ),
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                            visible: otpsend,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "One Time Password",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: TextFormField(
                                    controller: updateUserOtpController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "Enter OTP",
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 50, minHeight: 0),
                                      suffixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 10, minHeight: 2),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Color(0xff2C2C2C),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Dim().d8,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: Dim().d8,
                                        ),
                                        Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Visibility(
                                                visible: !again,
                                                child: TweenAnimationBuilder<
                                                        Duration>(
                                                    duration: const Duration(
                                                        seconds: 60),
                                                    tween: Tween(
                                                        begin: const Duration(
                                                            seconds: 60),
                                                        end: Duration.zero),
                                                    onEnd: () {
                                                      // ignore: avoid_print
                                                      // print('Timer ended');
                                                      setState(() {
                                                        again = true;
                                                      });
                                                    },
                                                    builder:
                                                        (BuildContext context,
                                                            Duration value,
                                                            Widget? child) {
                                                      final minutes =
                                                          value.inMinutes;
                                                      final seconds =
                                                          value.inSeconds % 60;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text:
                                                                "Resend code in ",
                                                            style: Sty()
                                                                .smallText
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Clr()
                                                                        .accentColor,
                                                                    fontFamily:
                                                                        ''),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    '$minutes:$seconds',
                                                                style: Sty().mediumText.copyWith(
                                                                    color: Clr()
                                                                        .textcolor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        ''),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Visibility(
                                            visible: again,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  again = false;
                                                });
                                                resendOtp(
                                                    updateUserMobileNumberController
                                                        .text);
                                                // STM.checkInternet().then((value) {
                                                //   if (value) {
                                                //     sendOTP();
                                                //   } else {
                                                //     STM.internetAlert(ctx, widget);
                                                //   }
                                                // });
                                              },
                                              child: Center(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        "Didn’t received code? ",
                                                    style: Sty()
                                                        .smallText
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Clr()
                                                                .accentColor,
                                                            fontFamily: ''),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: 'Request again',
                                                        style: Sty()
                                                            .mediumText
                                                            .copyWith(
                                                                color: Clr()
                                                                    .textcolor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                fontFamily: ''),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ]),
                ),
              ),
              elevation: 0,
              actions: [
                Row(
                  children: [
                    Visibility(
                      visible: !otpsend,
                      child: Expanded(
                        child: InkWell(
                          onTap: () async {
                            // API UPDATE START
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              FormData body = FormData.fromMap({
                                'page_type': 'update_number',
                                'mobile': updateUserMobileNumberController.text,
                              });
                              var result = await STM().postWithToken(
                                  ctx,
                                  Str().sendingOtp,
                                  'update_number',
                                  body,
                                  StudentToken,
                                  'student/');
                              var success = result['success'];
                              var message = result['message'];
                              if (success) {
                                setState(() {
                                  otpsend = true;
                                });
                              } else {
                                STM().errorDialog(context, message);
                              }
                            }
                            // API UPDATE END
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Clr().primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Send OTP",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: otpsend,
                      child: Expanded(
                        child: InkWell(
                            onTap: () async {
                              // API UPDATE START
                              SharedPreferences sp =
                                  await SharedPreferences.getInstance();
                              FormData body = FormData.fromMap({
                                'otp': updateUserOtpController.text,
                                'mobile': updateUserMobileNumberController.text,
                              });
                              var result = await STM().postWithToken(
                                  ctx,
                                  Str().updating,
                                  'verify_otp',
                                  body,
                                  StudentToken,
                                  'student/');
                              var success = result['success'];
                              var message = result['message'];
                              if (success) {
                                Navigator.pop(ctx);
                                getProfile();
                              } else {
                                STM().errorDialog(context, message);
                              }
                              setState(() {
                                otpsend = true;
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Clr().primaryColor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                )))),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Clr().primaryColor,
                              ),
                              child: const Center(
                                  child: Text("Cancel",
                                      style: TextStyle(color: Colors.white))))),
                    ),
                  ],
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        });
  }

  /// use for student mobile resend otp
  void resendOtp(mobile) async {
    FormData body = FormData.fromMap({'mobile': mobile, 'type': 'student'});
    var result =
        await STM().post(ctx, Str().sendingOtp, 'resent_otp', body, '');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      setState(() {
        again = false;
      });
      STM().displayToast(message);
    }
  }

  // /// update password Layout for Teacher
  // void updatePassword() {
  //   bool otpsend = false;
  //   AwesomeDialog(
  //     dialogType: DialogType.noHeader,
  //     context: ctx,
  //     body: StatefulBuilder(
  //       builder: (context, setState) => Padding(
  //         padding: EdgeInsets.fromLTRB(
  //           Dim().d12,
  //           Dim().d4,
  //           Dim().d12,
  //           Dim().d12,
  //         ),
  //         child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text("Change Password",
  //                   style: Sty()
  //                       .mediumBoldText
  //                       .copyWith(color: Color(0xff2C2C2C))),
  //               Visibility(
  //                 visible: !otpsend,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     const Text(
  //                       "New Password",
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Form(
  //                       key: passkey,
  //                       child: TextFormField(
  //                         cursorColor: Clr().primaryColor,
  //                         controller: newPassCtrl,
  //                         style: Sty().mediumText,
  //                         keyboardType: TextInputType.name,
  //                         obscureText: ishidden,
  //                         textInputAction: TextInputAction.done,
  //                         validator: (value) {
  //                           if (value!.isEmpty ||
  //                               !RegExp(r'(.{6,})').hasMatch(value)) {
  //                             return Str().invalidPassword;
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                         decoration: Sty().textFieldOutlineStyle.copyWith(
  //                               suffixIcon: InkWell(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     ishidden ^= true;
  //                                   });
  //                                 },
  //                                 child: Icon(
  //                                   ishidden
  //                                       ? Icons.visibility
  //                                       : Icons.visibility_off,
  //                                   color: Color(0xff36393B),
  //                                 ),
  //                               ),
  //                               hintStyle: Sty().smallText.copyWith(
  //                                     color: Clr().grey,
  //                                   ),
  //                               hintText: "New Password",
  //                               counterText: "",
  //                               // prefixIcon: Icon(
  //                               //   Icons.call,
  //                               //   color: Clr().lightGrey,
  //                               // ),
  //                             ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Visibility(
  //                 visible: otpsend,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     const Text(
  //                       "Confirm Password",
  //                     ),
  //                     const SizedBox(
  //                       height: 10,
  //                     ),
  //                     Form(
  //                       key: passkey,
  //                       child: TextFormField(
  //                         cursorColor: Clr().primaryColor,
  //                         style: Sty().mediumText,
  //                         controller: conPassCtrl,
  //                         keyboardType: TextInputType.name,
  //                         obscureText: ishidden1,
  //                         textInputAction: TextInputAction.done,
  //                         validator: (value) {
  //                           if (newPassCtrl.text != value) {
  //                             return 'Password must be match with new password';
  //                           }
  //                         },
  //                         decoration: Sty().textFieldOutlineStyle.copyWith(
  //                               suffixIcon: InkWell(
  //                                 onTap: () {
  //                                   setState(() {
  //                                     ishidden1 ^= true;
  //                                   });
  //                                 },
  //                                 child: Icon(
  //                                   ishidden1
  //                                       ? Icons.visibility
  //                                       : Icons.visibility_off,
  //                                   color: Color(0xff36393B),
  //                                 ),
  //                               ),
  //                               hintStyle: Sty().smallText.copyWith(
  //                                     color: Clr().grey,
  //                                   ),
  //                               hintText: "Confirm Password",
  //                               counterText: "",
  //                               // prefixIcon: Icon(
  //                               //   Icons.call,
  //                               //   color: Clr().lightGrey,
  //                               // ),
  //                             ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 children: [
  //                   Visibility(
  //                     visible: !otpsend,
  //                     child: Expanded(
  //                       child: InkWell(
  //                         onTap: () async {
  //                           // API UPDATE START
  //                           if (passkey.currentState!.validate()) {
  //                             setState(() {
  //                               otpsend = true;
  //                             });
  //                           }
  //                           // API UPDATE END
  //                         },
  //                         child: Container(
  //                           padding: const EdgeInsets.all(15),
  //                           decoration: BoxDecoration(
  //                             color: Clr().primaryColor,
  //                           ),
  //                           child: const Center(
  //                             child: Text(
  //                               "Next",
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Visibility(
  //                     visible: otpsend,
  //                     child: Expanded(
  //                       child: InkWell(
  //                           onTap: () {
  //                             UpdatePassword();
  //                           },
  //                           child: Container(
  //                               padding: const EdgeInsets.all(15),
  //                               decoration: BoxDecoration(
  //                                 color: Clr().primaryColor,
  //                               ),
  //                               child: const Center(
  //                                   child: Text(
  //                                 "Update",
  //                                 style: TextStyle(color: Colors.white),
  //                               )))),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 5,
  //                   ),
  //                   Expanded(
  //                     child: InkWell(
  //                         onTap: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Container(
  //                             padding: const EdgeInsets.all(15),
  //                             decoration: BoxDecoration(
  //                               color: Clr().primaryColor,
  //                             ),
  //                             child: const Center(
  //                                 child: Text("Cancel",
  //                                     style: TextStyle(color: Colors.white))))),
  //                   ),
  //                 ],
  //               ),
  //             ]),
  //       ),
  //     ),
  //   ).show();
  // }

  /// update password api for Teacher
  void UpdatePassword() async {
    FormData body = FormData.fromMap({
      'current_password': currentPassCtrl.text,
      'new_password': newPassCtrl.text,
      'confirm_password': conPassCtrl.text,
    });
    var result = await STM().postWithToken(
        ctx,
        Str().updating,
        'update_password',
        body,
        TeacherToken ?? StudentToken,
        TeacherToken != null ? 'teacher/' : 'student/');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      STM().back2Previous(ctx);
      setState(() {
        currentPassCtrl.clear();
        newPassCtrl.clear();
        conPassCtrl.clear();
      });
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  /// get Profile
  void getUpdateProfile(profile) async {
    FormData body = FormData.fromMap({
      'profile_photo': profile,
    });
    var result = await STM().postWithToken(
        ctx,
        Str().processing,
        'update_profile_photo',
        body,
        TeacherToken ?? StudentToken,
        TeacherToken != null ? 'teacher/' : 'student/');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      getProfile();
    } else {
      STM().errorDialog(ctx, message);
    }
  }
}
