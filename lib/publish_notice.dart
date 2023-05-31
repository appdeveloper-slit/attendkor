import 'package:attend_kor_teacher/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/styles.dart';

class PublishNotice extends StatefulWidget {
  @override
  State<PublishNotice> createState() => _PublishNoticeState();
}

class _PublishNoticeState extends State<PublishNotice> {
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
          'Publish Notice',
          style: Sty()
              .largeText
              .copyWith(color: Clr().textcolor, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d16),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close)),
            SizedBox(height: Dim().d20,),
            TextFormField(
                cursorColor: Clr().textcolor,
                keyboardType: TextInputType.name,
                maxLines: 25,
                decoration:
                Sty().TextFormFieldOutlineStyle1.copyWith(border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'What’s Up ?',
                    hintStyle: Sty().mediumText.copyWith(
                      color: Clr().hintColor,
                      fontSize: 14,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/add_image.svg'),
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
                      'Publish',
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
              ],
            )
          ],
        ),
      ),

    );
  }
}