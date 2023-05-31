import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class FreeLectures extends StatefulWidget {
  @override
  State<FreeLectures> createState() => _FreeLecturesState();
}

class _FreeLecturesState extends State<FreeLectures> {
  late BuildContext ctx;

  String SubjectValue = 'Select Subject';
  List<String> selecteLlist = [
    'Select Subject',
    'English',
    'Mathematics',
    'Physics',
    'Chemistry'
  ];
  String t = "0";

  String classValue = '19D';
  List<String> classLlist = ['19D', '19A', '19C', '19'];
  String s = "0";

  List<dynamic> timetableList = [
    // {
    //   'btntclr':Color(0xfffcebe3),
    //   'tclr': Color(0xffca937c),
    //   'tclr2': Color(0xfffcebe3),
    //   'btn':'Completed',
    //   'date': '16/04/2023',
    //   'btnclr': Clr().transparent,
    //   'clr': LinearGradient(
    //     colors: [
    //       Color(0xff111233),
    //       Color(0xff32334C),
    //       //add more colors for gradient
    //     ],
    //     end: Alignment.topRight, //begin of the gradient color
    //     begin: Alignment.bottomLeft,
    //   ),
    // },//Completed Card
    {
      'tclr': Clr().textcolor,
      'btntclr': Clr().textcolor,
      'btn': 'Book',
      'date': '16/04/2023',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    }, //Enter Code Card
    {
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Book',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
    {
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Book',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
    {
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Book',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
    {
      'tclr': Clr().textcolor,
      'date': '16/04/2023',
      'btntclr': Clr().textcolor,
      'btn': 'Book',
      'btnclr': Color(0xfffcebe3),
      'clr': LinearGradient(
        colors: [
          Clr().white,
          Clr().white,
          //add more colors for gradient
        ],
        end: Alignment.topRight, //begin of the gradient color
        begin: Alignment.bottomLeft,
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
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
          'Free Lectures',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: timetableList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Clr().borderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Clr().borderColor.withOpacity(0.8),
                          spreadRadius: 0.5,
                          blurRadius: 4,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      gradient: timetableList[index]['clr']),
                  child: Card(
                    elevation: 0,
                    color: Clr().transparent,
                    child: Padding(
                      padding: EdgeInsets.all(Dim().d12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Stream :",
                                  style: Sty().smallText.copyWith(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w300,
                                        color: timetableList[index]['tclr'],
                                        // color: Color(0xff2D2D2D),
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' EXTC',
                                      style: Sty().smallText.copyWith(
                                          color: timetableList[index]['tclr2'],
                                          fontWeight: FontWeight.w400,
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
                                      color: timetableList[index]['tclr'],
                                      // color: Color(0xff2D2D2D),
                                    ),
                              ),
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
                                    color: timetableList[index]['tclr'],
                                    // color: Color(0xff2D2D2D),
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' 1st Year (A)',
                                  style: Sty().smallText.copyWith(
                                      color: timetableList[index]['tclr2'],
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
                                  color: timetableList[index]['tclr']
                                  // color: Color(0xff2D2D2D),
                                  ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '19C',
                                  style: Sty().smallText.copyWith(
                                      color: timetableList[index]['tclr2'],
                                      fontWeight: FontWeight.w400,
                                      fontFamily: '',
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dim().d4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Time : ",
                                  style: Sty().smallText.copyWith(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w300,
                                        color: timetableList[index]['tclr'],
                                        // color: Color(0xff2D2D2D),
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '9 am to 10 am',
                                      style: Sty().smallText.copyWith(
                                          color: timetableList[index]['tclr2'],
                                          fontWeight: FontWeight.w400,
                                          fontFamily: '',
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                width: 120,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        // backgroundColor: Clr().accentColor,
                                        backgroundColor: timetableList[index]
                                            ['btnclr'],
                                        shape: RoundedRectangleBorder(
                                            // side: BorderSide(color: Color(0xfff4f4f5)),
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    onPressed: () {
                                      // STM().redirect2page(ctx, Job());
                                      _showClassDialog(ctx);
                                    },
                                    child: Text(
                                      timetableList[index]['btn'],
                                      style: Sty().largeText.copyWith(
                                          color: timetableList[index]
                                              ['btntclr'],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
  _showClassDialog(ctx) {
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
            SizedBox(
              height: Dim().d8,
            ),
            TextFormField(
                cursorColor: Clr().textcolor,
                readOnly: true,
                keyboardType: TextInputType.name,
                decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                    hintText: 'EXTC',
                    hintStyle: Sty().mediumText.copyWith(
                          color: Clr().hintColor,
                          fontSize: 14,
                        ))),
            SizedBox(
              height: Dim().d20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                      cursorColor: Clr().textcolor,
                      keyboardType: TextInputType.name,
                      decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                          hintText: '1st Year',
                          hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hintColor,
                            fontSize: 14,
                          ))),
                ),
                SizedBox(width: Dim().d16,),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                      cursorColor: Clr().textcolor,
                      keyboardType: TextInputType.name,
                      decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                          hintText: 'A',
                          hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hintColor,
                            fontSize: 14,
                          ))),
                ),
              ],
            ),

            SizedBox(
              height: Dim().d20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Clr().textcolor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: SubjectValue,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Clr().textcolor,
                  ),
                  style: TextStyle(color: Color(0xff787882)),
                  items: selecteLlist.map((String string) {
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
                      SubjectValue = t!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Clr().textcolor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: SubjectValue,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                    color: Clr().textcolor,
                  ),
                  style: TextStyle(color: Color(0xff787882)),
                  items: selecteLlist.map((String string) {
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
                      SubjectValue = t!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                      cursorColor: Clr().textcolor,
                      readOnly: true,
                      keyboardType: TextInputType.name,
                      decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                          hintText: '1 am',
                          hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hintColor,
                            fontSize: 14,
                          ))),
                ),
                SizedBox(width: Dim().d16,),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                      cursorColor: Clr().textcolor,
                      keyboardType: TextInputType.name,
                      decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                          hintText: '2 am',
                          hintStyle: Sty().mediumText.copyWith(
                            color: Clr().hintColor,
                            fontSize: 14,
                          ))),
                ),
              ],
            ),
            SizedBox(height: Dim().d20,),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
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
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )),
            ),
            SizedBox(
              height: Dim().d16,
            ),
          ],
        ),
      ),
    ).show();
  }
}
