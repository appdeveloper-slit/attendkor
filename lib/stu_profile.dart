import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'home.dart';
import 'manage/static_method.dart';
import 'sign_in.dart';
import 'stu_profile2.dart';
import 'super_admin.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class StudentProfile extends StatefulWidget {
  final String sUsertype;

  const StudentProfile({super.key, required this.sUsertype});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late BuildContext ctx;



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
      bottomNavigationBar: bottomBarLayout(ctx, 2,Color(0xff32334D)),
      backgroundColor: Clr().white,
      // appBar: AppBar(
      //   elevation: 0,
      //   shadowColor: Color(0xfff7f7f8),
      //   // shadowColor: Clr().borderColor,
      //   toolbarHeight: 60,
      //   backgroundColor: Clr().white,
      // ),
      body: SingleChildScrollView(
        child: Column(
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
                    Center(child: Image.asset('assets/add_profile_img.png')),
                    SizedBox(
                      height: Dim().d20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Name:- ",
                        style: Sty().smallText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Clr().accentColor,
                              // color: Color(0xff2D2D2D),
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Darshan Jadhav',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Mobile No.:- ",
                            style: Sty().smallText.copyWith(
                                  fontFamily: '',
                                  fontWeight: FontWeight.w300,
                                  color: Clr().accentColor,
                                  // color: Color(0xff2D2D2D),
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 82893272024',
                                style: Sty().smallText.copyWith(
                                      color: Color(0xffFCEBE3),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: '',
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset('assets/edit.svg'),
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
                            text: "Email Address:- ",
                            style: Sty().smallText.copyWith(
                                  fontFamily: '',
                                  fontWeight: FontWeight.w300,
                                  color: Clr().accentColor,
                                  // color: Color(0xff2D2D2D),
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Dj@gmail.com',
                                style: Sty().smallText.copyWith(
                                      color: Color(0xffFCEBE3),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: '',
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset('assets/edit.svg'),
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
                            text: ' 5/5/1995',
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
                            text: ' Male',
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
                        SvgPicture.asset('assets/edit.svg'),
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
                                text: ' -',
                                style: Sty().smallText.copyWith(
                                      color: Color(0xffFCEBE3),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: '',
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset('assets/edit.svg'),
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
              height: 45,
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // backgroundColor: Clr().accentColor,
                      backgroundColor: Clr().white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Clr().textcolor),
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
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
            SizedBox(
              height: Dim().d8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: InkWell(
                onTap: () {
                  STM().redirect2page(ctx, SuperAdminMessage());
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
                    onPressed: () {
                      STM().redirect2page(ctx, SignIn());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/log_out.svg'),
                        SizedBox(
                          width: Dim().d12,
                        ),
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
                    STM().redirect2page(ctx, StudentProfile2(sUsertype: '',));
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
}
