import 'dart:convert';
import 'dart:io';
import 'package:attend_kor_teacher/get_report.dart';
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
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late BuildContext ctx;

  /// For Teacher variables
  var data;
  String? TeacherToken, profile, pic;
  File? imageFile;
  List allAlertDialog = [];

  /// update password alert dialog
  bool ishidden = true;
  bool ishidden1 = true;
  bool again = false;
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController conPassCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? '';
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getProfile();
        print(TeacherToken);
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

    return Scaffold(
      bottomNavigationBar: bottomBarLayout(ctx, 2, Color(0xff32334D)),
      backgroundColor: Clr().white,
      body: SingleChildScrollView(
        child: data == null
            ? SizedBox(
                height: MediaQuery.of(ctx).size.height / 1.5,
                child: STM().loadingPlaceHolder())
            : TeacherBoxLayout(),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Clr().textcolor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: SelectedValue,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Clr().textcolor,
                  ),
                  style: TextStyle(color: Color(0xff787882)),
                  items: selectedList.map((String string) {
                    return DropdownMenuItem<String>(
                      value: string,
                      child: Text(
                        string,
                        style: TextStyle(color: Clr().textcolor, fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (t) {
                    // STM().redirect2page(ctx, Home());
                    setState(() {
                      SelectedValue = t!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            TextFormField(
                // controller: mobileCtrl,
                cursorColor: Clr().textcolor,
                keyboardType: TextInputType.number,
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Clr().textcolor,
                      ),
                    ),
                    hintText: 'Enter Institution Code',
                    hintStyle: Sty().mediumText.copyWith(
                          color: Clr().textcolor,
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
                    // permissionHandle();
                    // STM().redirect2page(ctx, MyProfile2());
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
        Container(
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
                                  imageUrl: pic ??
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
                          updatePassword();
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
                    RichText(
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
                    RichText(
                      text: TextSpan(
                        text: "Qualifications:-",
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
                    color: Clr().white,
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
                  STM().redirect2page(ctx, SignIn());
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
    var result = await STM()
        .get(ctx, Str().loading, 'profile_details', TeacherToken, 'teacher/');
    var success = result['success'];
    if (success) {
      setState(() {
        data = result['data'];
      });
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
          return AlertDialog(
            title: Text(
                i == 0
                    ? 'Change Name:'
                    : i == 1
                        ? 'Bio:'
                        : 'Qualifications:',
                style: Sty().mediumBoldText),
            content: TextFormField(
              controller: i == 0
                  ? nameCtrl
                  : i == 1
                      ? bioCtrl
                      : qualCtrl,
              decoration: Sty().TextFormFieldOutlineDarkStyle.copyWith(
                    hintStyle:
                        Sty().mediumText.copyWith(color: Clr().hintColor),
                    hintText: i == 0
                        ? 'Enter Your New Name'
                        : i == 1
                            ? 'Enter Your Bio'
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
                                    : 'update_qualification',
                            body,
                            TeacherToken,
                            'teacher/');
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
                            style:
                                Sty().mediumText.copyWith(color: Clr().white)),
                      )),
                ),
              )
            ],
          );
        });
  }

  /// update password Layout for Teacher
  void updatePassword() {
    bool otpsend = false;
    AwesomeDialog(
      dialogType: DialogType.noHeader,
      context: ctx,
      body: StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.fromLTRB(
            Dim().d12,
            Dim().d4,
            Dim().d12,
            Dim().d12,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Change Password",
                    style: Sty()
                        .mediumBoldText
                        .copyWith(color: Color(0xff2C2C2C))),
                Visibility(
                  visible: !otpsend,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "New Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          cursorColor: Clr().primaryColor,
                          controller: newPassCtrl,
                          style: Sty().mediumText,
                          keyboardType: TextInputType.name,
                          obscureText: ishidden,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'(.{6,})').hasMatch(value)) {
                              return Str().invalidPassword;
                            } else {
                              return null;
                            }
                          },
                          decoration: Sty().textFieldOutlineStyle.copyWith(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      ishidden ^= true;
                                    });
                                  },
                                  child: Icon(
                                    ishidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xff36393B),
                                  ),
                                ),
                                hintStyle: Sty().smallText.copyWith(
                                      color: Clr().grey,
                                    ),
                                hintText: "New Password",
                                counterText: "",
                                // prefixIcon: Icon(
                                //   Icons.call,
                                //   color: Clr().lightGrey,
                                // ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: otpsend,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Confirm Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          cursorColor: Clr().primaryColor,
                          style: Sty().mediumText,
                          controller: conPassCtrl,
                          keyboardType: TextInputType.name,
                          obscureText: ishidden1,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (newPassCtrl.text != value) {
                              return 'Password must be match with new password';
                            }
                          },
                          decoration: Sty().textFieldOutlineStyle.copyWith(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      ishidden1 ^= true;
                                    });
                                  },
                                  child: Icon(
                                    ishidden1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xff36393B),
                                  ),
                                ),
                                hintStyle: Sty().smallText.copyWith(
                                      color: Clr().grey,
                                    ),
                                hintText: "Confirm Password",
                                counterText: "",
                                // prefixIcon: Icon(
                                //   Icons.call,
                                //   color: Clr().lightGrey,
                                // ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: !otpsend,
                      child: Expanded(
                        child: InkWell(
                          onTap: () async {
                            // API UPDATE START
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                otpsend = true;
                              });
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
                                "Next",
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
                            onTap: () {
                              UpdatePassword();
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
              ]),
        ),
      ),
    ).show();
  }

  /// update password api for Teacher
  void UpdatePassword() async {
    FormData body = FormData.fromMap({
      'mobile': data['mobile'],
      'password': newPassCtrl.text,
      'password_confirmation': conPassCtrl.text,
    });
    var result =
        await STM().post(ctx, Str().updating, 'update_password', body, '');
    var success = result['success'];
    var message = result['message'];
    if (success) {
      STM().displayToast(message);
      STM().finishAffinity(ctx, SignIn());
    } else {
      STM().errorDialog(ctx, message);
    }
  }

  /// get Profile
  void getUpdateProfile(profile) async {
    FormData body = FormData.fromMap({
      'profile_photo': profile,
    });
    var result = await STM()
        .postWithToken(ctx, Str().processing, 'update_profile_photo', body, TeacherToken,'teacher/');
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
