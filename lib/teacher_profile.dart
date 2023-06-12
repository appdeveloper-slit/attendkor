import 'package:flutter/material.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class TeacherProfile extends StatefulWidget {
  final value;

  const TeacherProfile({super.key, this.value});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        STM().back2Previous(ctx);
        return false;
      },
      child: Scaffold(
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
            'Teacher Profile',
            style: Sty()
                .largeText
                .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Dim().d12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dim().d20,
              ),
              Center(
                  child: ClipOval(
                      child: STM().imageDisplay(
                          h: Dim().d120,
                          w: Dim().d120,
                          url: widget.value['profile_photo'],
                          list: widget.value['profile_photo']))),
              SizedBox(
                height: Dim().d20,
              ),
              RichText(
                text: TextSpan(
                  text: "Institution:- :",
                  style: Sty().smallText.copyWith(
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                        color: Clr().textcolor,
                        // color: Color(0xff2D2D2D),
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${widget.value['college']['name'].toString()}',
                      style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: '',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              RichText(
                text: TextSpan(
                  text: "Name:-",
                  style: Sty().smallText.copyWith(
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                        color: Clr().textcolor,
                        // color: Color(0xff2D2D2D),
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${widget.value['name']}',
                      style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: '',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              RichText(
                text: TextSpan(
                  text: "Bio:-",
                  style: Sty().smallText.copyWith(
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                        color: Clr().textcolor,
                        // color: Color(0xff2D2D2D),
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.value['bio'] == null ? '' :' ${widget.value['bio']}',
                      style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: '',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dim().d16,
              ),
              RichText(
                text: TextSpan(
                  text: "Qualifications:-",
                  style: Sty().smallText.copyWith(
                        fontFamily: '',
                        fontWeight: FontWeight.w300,
                        color: Clr().textcolor,
                        // color: Color(0xff2D2D2D),
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.value['qualification'] == null ? '' : ' ${widget.value['qualification']}',
                      style: Sty().smallText.copyWith(
                          color: Clr().textcolor,
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
            ],
          ),
        ),
      ),
    );
  }
}
