import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:flutter/material.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class SuperAdminMessage extends StatefulWidget {
  @override
  State<SuperAdminMessage> createState() => _SuperAdminMessageState();
}

class _SuperAdminMessageState extends State<SuperAdminMessage> {
  late BuildContext ctx;

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
          'Super Admin',
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return  Container(
                  margin: EdgeInsets.only(bottom: Dim().d12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Clr().borderColor.withOpacity(0.4),
                        spreadRadius: 0.5,
                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                    ),
                    color: Color(0xfffcebe3),
                    child: Padding(
                      padding:  EdgeInsets.all(Dim().d12),
                      child: Column(
                        children: [
                          Text('It helps you streamline processes and solve problems quickly. Additionally, coding skills are highly demanded in various industries, including technology, finance, and healthcare. Learning to code can open up career opportunities and advancements.',
                            style: Sty().smallText.copyWith(
                                height: 1.3,
                                fontWeight: FontWeight.w300
                            ),),
                          SizedBox(height: Dim().d12,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('12 Apr 2023',
                            style: Sty().microText.copyWith(
                              fontWeight: FontWeight.w300
                            ),),
                          )

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
}