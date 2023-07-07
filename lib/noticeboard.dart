import 'package:attend_kor_teacher/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';
import 'zoompicture.dart';

class NoticeBoard extends StatefulWidget {
  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  late BuildContext ctx;
  List<dynamic> noticeList = [];
  bool check = false;
  String? TeacherToken, StudentToken;

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      TeacherToken = sp.getString('teacherToken') ?? null;
      StudentToken = sp.getString('studenttoken') ?? null;
    });
    STM().checkInternet(context, widget).then((value) {
      if (value) {
        getNotice();
        print(StudentToken);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

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
            'Noticeboard',
            style: Sty()
                .largeText
                .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dim().d12),
          child: Column(
            children: [
              check
                  ? SizedBox(
                      height: MediaQuery.of(ctx).size.height / 1.5,
                      child: Center(
                        child: Text(
                          'No Notice',
                          style: Sty().largeText,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: noticeList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Clr().white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Clr().borderColor),
                            boxShadow: [
                              BoxShadow(
                                color: Clr().borderColor,
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset:
                                    Offset(4, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 0,
                              color: Clr().white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dim().d4,
                                  vertical: Dim().d4,
                                ),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/pin.png',
                                      height: 22,
                                      width: 22,
                                    ),
                                    SizedBox(width: Dim().d4),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          noticeList[index]['image'] == ""
                                              ? Container()
                                              : InkWell(
                                                  onTap: () {
                                                    noticeList[index]['image'] != null
                                                        ? STM().redirect2page(
                                                            ctx,
                                                            ZoomingPic(
                                                                img: noticeList[index]
                                                                    ['image']))
                                                        : null;
                                                  },
                                                  child: Container(
                                                    child: STM().imageDisplay(
                                                        list: noticeList[index]
                                                            ['image'],
                                                        url: noticeList[index]
                                                            ['image']),
                                                  )),
                                          SizedBox(
                                            height: Dim().d8,
                                          ),
                                          Text(
                                            '${noticeList[index]['notice'].toString()}',
                                            style: Sty().smallText.copyWith(
                                                height: 1.3,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: Dim().d4,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '${DateFormat('d MMM yyyy').format(DateTime.parse(noticeList[index]['created_at'].toString()))}',
                                              style: Sty().microText.copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: '',
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void getNotice() async {
    var result = await STM().get(
        ctx,
        Str().loading,
        'get_notice',
        TeacherToken ?? StudentToken,
        TeacherToken != null ? 'teacher/' : 'student/');
    var success = result['success'];
    if (success) {
      setState(() {
        noticeList = result['data'];
        noticeList.isEmpty ? check = true : null;
      });
    }
  }
}
