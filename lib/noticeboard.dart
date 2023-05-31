import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class NoticeBoard extends StatefulWidget {
  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  late BuildContext ctx;

  List<dynamic> noticeList = [];

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
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 8,
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
                        offset: Offset(4, 2), // changes position of shadow
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
                        child: Column(
                          children: [
                            Image.asset('assets/gzod2.png'),
                            SizedBox(
                              height: Dim().d8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/pin.png',
                                  height: 22,
                                  width: 22,
                                ),
                                SizedBox(
                                  width: Dim().d4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Important notice on Exam',
                                    style: Sty().smallText.copyWith(
                                        height: 1.3,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dim().d4,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '12 Apr 2023',
                                style: Sty().microText.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontFamily: '',
                                    ),
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
    );
  }
}
