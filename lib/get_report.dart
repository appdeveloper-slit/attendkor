import 'package:attend_kor_teacher/values/colors.dart';
import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'manage/static_method.dart';
import 'values/styles.dart';

class GetReports extends StatefulWidget {
  @override
  State<GetReports> createState() => _GetReportsState();
}

class _GetReportsState extends State<GetReports> {
  late BuildContext ctx;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController dobCtrl1 = TextEditingController();
  TextEditingController dobteacherCtrl = TextEditingController();
  TextEditingController dobteacherCtrl1 = TextEditingController();


  Future datePicker() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl = TextEditingController(text: s);
      });
    }
  }

  Future datePicker1() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobCtrl1 = TextEditingController(text: s);
      });
    }
  }

  Future datePickerTeacher() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobteacherCtrl = TextEditingController(text: s);
      });
    }
  }

  Future datePickerTeacher1() async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      //Disabled past date
      // firstDate: DateTime.now().subtract(Duration(days: 1)),
      // Disabled future date
      // lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        String s = STM().dateFormat('dd-MM-yyyy', picked);
        dobteacherCtrl1 = TextEditingController(text: s);
      });
    }
  }

  String streamValue = 'Select Stream';
  List<String> streamList = [
    'Select Stream',
    'Science',
    'Commerce',
    'Arts',
  ];
  String t = "0";

  String classValue = 'Select Class';
  List<String> classList = [
    'Select Class',
    '10th',
    '11th',
    '12th',
  ];
  String c = "0";

  String divisionValue = 'Select Division';
  List<String> divisionList = [
    'Select Division',
    'A',
    'B',
    'C',
  ];
  String d = "0";

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
          'Reports',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Student Reports',
              style: Sty()
                  .mediumText
                  .copyWith(color: Clr().black, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'Get the detailed reports of all the students in your classroom in terms of excel sheet.',
              textAlign: TextAlign.center,
              style: Sty().smallText.copyWith(
                  color: Color(0xff58596e),
                  fontFamily: '',
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: Dim().d28,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Clr().textcolor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: streamValue,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 28,
                      color: Clr().textcolor,
                    ),
                    style: TextStyle(color: Color(0xff787882)),
                    items: streamList.map((String string) {
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
                        streamValue = t!;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: classValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: classList.map((String string) {
                            return DropdownMenuItem<String>(
                              value: string,
                              child: Text(
                                string,
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (c) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              classValue = c!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: divisionValue,
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                            color: Clr().textcolor,
                          ),
                          style: TextStyle(color: Color(0xff787882)),
                          items: divisionList.map((String string) {
                            return DropdownMenuItem<String>(
                              value: string,
                              child: Text(
                                string,
                                style: TextStyle(
                                    color: Clr().textcolor, fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (d) {
                            // STM().redirect2page(ctx, Home());
                            setState(() {
                              divisionValue = d!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: TextFormField(
                          controller: dobCtrl,
                          onTap: () {
                            datePicker();
                          },
                          readOnly: true,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'From Date',
                              hintStyle: Sty().mediumText.copyWith(
                                    color: Clr().textcolor,
                                    fontSize: 14,
                                  ))),
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: TextFormField(
                          controller: dobCtrl1,
                          onTap: () {
                            datePicker1();
                          },
                          readOnly: true,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding:
                                    EdgeInsets.symmetric(
                                        vertical: Dim().d12
                                    ),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'To Date',
                              hintStyle: Sty().mediumText.copyWith(
                                    color: Clr().textcolor,
                                    fontSize: 14,
                                  ))),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Dim().d28,),

            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // _showCodeDialog(ctx);
                    // STM().redirect2page(ctx, GetReports());
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
                    'Get Reports',
                    style: TextStyle(
                      // fontFamily: 'Merriweather',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
              ),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Attendance Report',style: Sty().mediumText.copyWith(
                color: Clr().textcolor
              ),),
              SvgPicture.asset('assets/download.svg'),
            ],),
            SizedBox(height: Dim().d20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('Blacklist Report',style: Sty().mediumText.copyWith(

                color: Clr().textcolor
              ),),
              SvgPicture.asset('assets/download.svg'),
            ],),
            SizedBox(height: Dim().d40,),
            Text('Teacher Report',style: Sty().mediumText.copyWith(

                color: Clr().textcolor
            ),),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'Get the detailed reports of all the students in your classroom in terms of excel sheet.',
              textAlign: TextAlign.center,
              style: Sty().smallText.copyWith(
                  color: Color(0xff58596e),
                  fontFamily: '',
                  fontWeight: FontWeight.w300),
            ),

            SizedBox(
              height: Dim().d16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: TextFormField(
                          controller: dobteacherCtrl,
                          onTap: () {
                            datePickerTeacher();
                          },
                          readOnly: true,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(Dim().d12),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'From Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontSize: 14,
                              ))),
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Clr().textcolor)),
                      child: TextFormField(
                          controller: dobteacherCtrl1,
                          onTap: () {
                            datePickerTeacher1();
                          },
                          readOnly: true,
                          decoration: Sty().TextFormFieldOutlineStyle.copyWith(
                              suffixIcon: Padding(
                                padding:
                                EdgeInsets.symmetric(
                                    vertical: Dim().d12
                                ),
                                child: SvgPicture.asset(
                                  'assets/calender.svg',
                                  fit: BoxFit.contain,
                                  height: 5,
                                  width: 5,
                                ),
                              ),
                              hintText: 'To Date',
                              hintStyle: Sty().mediumText.copyWith(
                                color: Clr().textcolor,
                                fontSize: 14,
                              ))),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: Dim().d28,),

            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // _showCodeDialog(ctx);
                  // STM().redirect2page(ctx, GetReports());
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
                  'Get Report',
                  style: TextStyle(
                    // fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),

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
            SizedBox(height: Dim().d32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lecture History',style: Sty().mediumText.copyWith(

                    color: Clr().textcolor
                ),),
                SvgPicture.asset('assets/download.svg'),
              ],),
            SizedBox(height: Dim().d20,),

          ],
        ),
      ),
    );
  }
}
