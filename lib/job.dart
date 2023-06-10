import 'package:attend_kor_teacher/home.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Job extends StatefulWidget {
  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  late BuildContext ctx;

  List<dynamic> jobList = [
    {
      'btn' : 'Applied',
      'tclr' : Clr().textcolor,
      'btnclr' : Color(0xfffcebe3),
      'clr' : Color(0xfff4f4f5),
      'shadow' : Clr().borderColor.withOpacity(0),
    },
    {
      'btn' : 'Apply',
      'tclr' : Color(0xfffcebe3),
      'btnclr' : Clr().textcolor,
      'clr' : Clr().white,
      'shadow' : Clr().borderColor.withOpacity(0.5),
      // 'shadow' : Clr().borderColor.withOpacity(1),
    },
    {
      'btn' : 'Apply',
      'tclr' : Color(0xfffcebe3),
      'btnclr' : Clr().textcolor,
      'clr' : Clr().white,
      'shadow' : Clr().borderColor.withOpacity(0.5),
      // 'shadow' : Clr().borderColor.withOpacity(1),
    },
    {
      'btn' : 'Applied',
      'tclr' : Clr().textcolor,
      'btnclr' : Color(0xfffcebe3),
      'clr' : Color(0xfff4f4f5),
      'shadow' : Clr().borderColor.withOpacity(0),
    },
    {
      'btn' : 'Apply',
      'tclr' : Color(0xfffcebe3),
      'btnclr' : Clr().textcolor,
      'clr' : Clr().white,
      'shadow' : Clr().borderColor.withOpacity(0.5),
      // 'shadow' : Clr().borderColor.withOpacity(1),
    },
    {
      'btn' : 'Apply',
      'tclr' : Color(0xfffcebe3),
      'btnclr' : Clr().textcolor,
      'clr' : Clr().white,
      'shadow' : Clr().borderColor.withOpacity(0.5),
      // 'shadow' : Clr().borderColor.withOpacity(1),
    },
    {
      'btn' : 'Applied',
      'tclr' : Clr().textcolor,
      'btnclr' : Color(0xfffcebe3),
      'clr' : Color(0xfff4f4f5),
      'shadow' : Clr().borderColor.withOpacity(0),
    },
    {
      'btn' : 'Apply',
      'tclr' : Color(0xfffcebe3),
      'btnclr' : Clr().textcolor,
      'clr' : Clr().white,
      'shadow' : Clr().borderColor.withOpacity(0.5),
      // 'shadow' : Clr().borderColor.withOpacity(1),
    },


  ];

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
          onTap: (){
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff131A29),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Jobs',
          style: Sty().largeText.copyWith(
            color: Clr().textcolor,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d12),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: jobList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: jobList[index]['clr'],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Clr().borderColor
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: jobList[index]['shadow'],
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: Offset(4, 2), // changes position of shadow
                      ),
                    ],

                  ),
                  child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      elevation: 0,
                      color: jobList[index]['clr'],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dim().d4,
                          vertical: Dim().d4,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Full Stack Developer',
                                  style: Sty().largeText.copyWith(
                                      color: Clr().textcolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          // backgroundColor: Clr().accentColor,
                                          backgroundColor: jobList[index]['btnclr'],
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(color: Color(0xfff4f4f5)),
                                              borderRadius: BorderRadius.circular(5)
                                          )
                                      ),
                                      onPressed: () {
                                        // STM().redirect2page(ctx, Job());
                                        _showDetailsDialog(ctx);
                                      },
                                      child: Text(jobList[index]['btn'],style: Sty().largeText.copyWith(
                                          color: jobList[index]['tclr'],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400
                                      ),)),
                                )
                              ],
                            ),
                            SizedBox(height: Dim().d4,),
                            Row(
                              children: [
                                Text(
                                  'Company :-',
                                  style: Sty().largeText.copyWith(
                                      color: Clr().textcolor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      fontFamily: ''
                                  ),
                                ),
                                SizedBox(width: Dim().d8,),
                                Text(
                                  'TCS Infotech',
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
                                  'Job Type :-',
                                  style: Sty().largeText.copyWith(
                                      color: Clr().textcolor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      fontFamily: ''
                                  ),
                                ),
                                SizedBox(width: Dim().d8,),
                                Text(
                                  'Full Time',
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
                                  'Location:-',
                                  style: Sty().largeText.copyWith(
                                      color: Clr().textcolor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      fontFamily: ''
                                  ),
                                ),
                                SizedBox(width: Dim().d8,),
                                Text(
                                  'Mahape, NewMumbai',
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
                                  'Brief:-',
                                  style: Sty().largeText.copyWith(
                                      color: Clr().textcolor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      fontFamily: ''
                                  ),
                                ),
                                SizedBox(width: Dim().d8,),
                                Expanded(
                                  child: Text(
                                    'Lorem ipsum dolor sit amet consectetur. Sed eu viverra morbi non egestas facilisi id luctus nam.',
                                    style: Sty().largeText.copyWith(
                                        color: Clr().textcolor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                );


              },
            ),
          ],
        ),
      ),

    );
  }


  _showDetailsDialog(ctx) {
    AwesomeDialog(
      width: double.infinity,
      padding: EdgeInsets.zero,
      isDense: true,
      context: ctx,
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      alignment: Alignment.centerLeft,
      body: Container(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Upload Your Resume and Elevate Your Chances of Getting Hired!',
                style: Sty().smallText.copyWith(
                color: Clr().textcolor,
                fontWeight: FontWeight.w400,
                fontFamily: '',
                fontSize: 16),),
            SizedBox(height: Dim().d12,),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: DottedBorder(
                color: Clr().textcolor, //color of dotted/dash line
                strokeWidth: 0.5, //thickness of dash/dots
                dashPattern: [6, 4],
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/upload_resume.svg'),
                      SizedBox(width: Dim().d12,),
                      Text(
                        'Upload Resume',
                        style: Sty().largeText.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Clr().textcolor),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Dim().d24,
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    // _showCodeDialog(ctx);
                    STM().redirect2page(ctx, Job());
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
              height: Dim().d12,
            ),
          ],
        ),
      ),
    ).show();
  }


}