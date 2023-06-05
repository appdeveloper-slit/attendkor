import 'package:attend_kor_teacher/values/colors.dart';
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'home.dart';
import 'manage/static_method.dart';
import 'sign_in.dart';
import 'values/styles.dart';

class StudentProfile2 extends StatefulWidget {
  final String sUsertype;

  const StudentProfile2({super.key, required this.sUsertype});

  @override
  State<StudentProfile2> createState() => _StudentProfile2State();
}

class _StudentProfile2State extends State<StudentProfile2> {
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
            Padding(
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
                                  fontSize: 16,
                                  fontFamily: ''
                              ),
                            ),
                            SizedBox(width: Dim().d4,),
                            Expanded(
                              child: Text(
                                'Thakur College Of Engineering',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Sty().largeText.copyWith(
                                    color: Clr().textcolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dim().d12,),
                        Row(
                          children: [
                            Text(
                              'Unique ID :',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  fontFamily: ''
                              ),
                            ),
                            SizedBox(width: Dim().d4,),
                            Text(
                              ' 8903247343',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dim().d12,),
                        Row(
                          children: [
                            Text(
                              'Stream :',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  fontFamily: ''
                              ),
                            ),
                            SizedBox(width: Dim().d4,),
                            Text(
                              ' EXTC',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dim().d12,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Class (Year) :',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  fontFamily: ''
                              ),
                            ),
                            SizedBox(width: Dim().d4,),
                            Expanded(
                              child: Text(
                                '1st Year',
                                style: Sty().largeText.copyWith(
                                    color: Clr().textcolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dim().d12,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Division :',
                              style: Sty().largeText.copyWith(
                                  color: Clr().textcolor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  fontFamily: ''
                              ),
                            ),
                            SizedBox(width: Dim().d4,),
                            Expanded(
                              child: Text(
                                'B',
                                style: Sty().largeText.copyWith(
                                    color: Clr().textcolor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: Dim().d12,),
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
                                    fontSize: 16,
                                    fontFamily: ''
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' C5',
                                    style: Sty().largeText.copyWith(
                                        color: Clr().textcolor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 35,
                              width: 100,
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
                  )
              ),
            ),
            SizedBox(
              height: Dim().d32,
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
                onTap: (){
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
      width: double.infinity,

      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(

        padding: EdgeInsets.all(Dim().d4),
        child: Column(
          children: [
            SizedBox(height: Dim().d8,),
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
                        style:
                        TextStyle(color: Clr().textcolor, fontSize: 14),
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
              height:  Dim().d20,
            ),
            TextFormField(
              // controller: mobileCtrl,
                cursorColor: Clr().textcolor,
                keyboardType: TextInputType.number,
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    hintText: 'Enter Institution Code',
                    hintStyle: Sty().mediumText.copyWith(
                      color: Clr().hintColor,
                      fontSize: 14,
                    ))),
            SizedBox(height: Dim().d20,),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // permissionHandle();
                    // STM().redirect2page(ctx, ResetPassword1());
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
            SizedBox(height: Dim().d28,),
          ],
        ),
      ),
    ).show();
  }
}
