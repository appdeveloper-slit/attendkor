import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'get_report.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class Attendance extends StatefulWidget{
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late BuildContext ctx;


List <dynamic> studentList = [];

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return  Scaffold(
      backgroundColor: Clr().white,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Color(0xfff7f7f8),
        // shadowColor: Clr().borderColor,
        toolbarHeight: 60,
        backgroundColor: Clr().white,
        leading: InkWell(
          onTap: () {
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff131A29),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Attendance',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Clr().borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Clr().borderColor.withOpacity(0.8),
                      spreadRadius: 0.5,
                      blurRadius: 4,
                      offset: Offset(
                          3, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff111233),
                      Color(0xff32334C),
                      //add more colors for gradient
                    ],
                    end: Alignment.topRight, //begin of the gradient color
                    begin: Alignment.bottomLeft,
                  ),),
              child: Card(
                elevation: 0,
                color: Clr().transparent,
                child: Padding(
                  padding: EdgeInsets.all(Dim().d12),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Stream :",
                              style: Sty().smallText.copyWith(
                                fontFamily: '',
                                fontWeight: FontWeight.w300,
                                color: Color(0xffca937c),
                                // color: Color(0xff2D2D2D),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' EXTC',
                                  style: Sty()
                                      .smallText
                                      .copyWith(
                                      color:Color(0xfffcebe3),
                                      fontWeight:
                                      FontWeight.w400,
                                      fontFamily: '',
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '16/04/2023',
                            // timetableList[index]['date'],
                            style: Sty().microText.copyWith(
                              fontFamily: '',
                              fontWeight: FontWeight.w300,
                              color: Color(0xffca937c),
                              // color: Color(0xff2D2D2D),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Class :",
                          style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            color: Color(0xffca937c),
                            // color: Color(0xff2D2D2D),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' 1st Year (A)',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Subject :",
                          style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            color: Color(0xffca937c),
                            // color: Color(0xff2D2D2D),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Digital Electronics',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Class Room :",
                          style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            color: Color(0xffca937c),
                            // color: Color(0xff2D2D2D),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '19C',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Time : ",
                          style: Sty().smallText.copyWith(
                            fontFamily: '',
                            fontWeight: FontWeight.w300,
                            color: Color(0xffca937c),
                            // color: Color(0xff2D2D2D),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '9 am to 10 am',
                              style: Sty().smallText.copyWith(
                                  color: Color(0xfffcebe3),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: '',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Dim().d4,),
            InkWell(
              onTap: (){
                _showEnterIDDialog(ctx);
              },
              child: DottedBorder(
                color: Clr().textcolor,
                //color of dotted/dash line
                strokeWidth: 0.5,
                //thickness of dash/dots
                dashPattern: [6, 4],
                child: Padding(
                  padding: const EdgeInsets
                      .symmetric(
                      horizontal: 10,
                      vertical: 10),
                  child: Center(
                    child: Text(
                      '+  Student Attendance',
                      style: Sty()
                          .largeText
                          .copyWith(
                        fontWeight:
                        FontWeight.w300,
                        fontSize: 14,
                        color: Clr().textcolor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dim().d20,),
            Text('List Of Students',
            style: Sty().mediumText.copyWith(
              fontSize: 18
            ),),
            SizedBox(height: Dim().d16,),
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: Dim().d16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                              width: 22,
                              child: Text('${index+1}.',
                                style: Sty().smallText.copyWith(
                                    color: Clr().textcolor
                                ),)),
                          SizedBox(width: Dim().d8,),
                          Text('Darshan Jadhav',
                          style: Sty().smallText.copyWith(
                            color: Clr().textcolor
                          ),),
                        ],
                      ),
                      SvgPicture.asset('assets/delete.svg')
                    ],
                  ),
                );
              },
            ),



          ],
        ),
      ),

    );
  }


  //Pop Ups
  _showEnterIDDialog(ctx) {
    AwesomeDialog(
      width: double.infinity,
      isDense: true,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
            TextFormField(
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    hintText: 'Enter Student Unique ID',
                    hintStyle: Sty().mediumText.copyWith(
                      color: Clr().hintColor,
                      fontSize: 14,
                    )
                )
            ),
            SizedBox(
              height: Dim().d20,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    _showDetailsDialog(ctx);
                    // STM().redirect2page(ctx, TeacherProfile());
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
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    'Get Details',
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
              height: Dim().d16,
            ),
          ],
        ),
      ),
    ).show();
  }


  _showDetailsDialog(ctx) {
    AwesomeDialog(
      width: double.infinity,
      isDense: false,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Unique ID:-",
                style: Sty().mediumText.copyWith(
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                  color: Clr().textcolor
                  // color: Color(0xff2D2D2D),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' ADH643',
                    style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: '',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dim().d12,),
            RichText(
              text: TextSpan(
                text: "Name:-",
                style: Sty().mediumText.copyWith(
                  fontFamily: '',
                  fontWeight: FontWeight.w300,
                  color: Clr().textcolor
                  // color: Color(0xff2D2D2D),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Darshan Jadhav',
                    style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: '',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dim().d12,),
            RichText(
              text: TextSpan(
                text: "Stream:-",
                style: Sty().mediumText.copyWith(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    color: Clr().textcolor
                  // color: Color(0xff2D2D2D),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Extc',
                    style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: '',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dim().d12,),
            RichText(
              text: TextSpan(
                text: "Class:-",
                style: Sty().mediumText.copyWith(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    color: Clr().textcolor
                  // color: Color(0xff2D2D2D),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' 1st Year',
                    style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: '',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dim().d12,),
            RichText(
              text: TextSpan(
                text: "Division:-",
                style: Sty().mediumText.copyWith(
                    fontFamily: '',
                    fontWeight: FontWeight.w300,
                    color: Clr().textcolor
                  // color: Color(0xff2D2D2D),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' A',
                    style: Sty().smallText.copyWith(
                        color: Clr().textcolor,
                        fontWeight: FontWeight.w400,
                        fontFamily: '',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // _showCodeDialog(ctx);
                    STM().redirect2page(ctx, Attendance());
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
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    'Update',
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
              height: Dim().d12,
            ),
          ],
        ),
      ),
    ).show();
  }
}