
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'job.dart';
import 'manage/static_method.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Home_student extends StatefulWidget {
  final String sUsertype;

  const Home_student({super.key, required this.sUsertype});

  @override
  State<Home_student> createState() => _Home_studentState();
}

class _Home_studentState extends State<Home_student> {
  late BuildContext ctx;



  List likeList = [];
  List dislikeList = [];
  List<dynamic> gzodList = [
    {'img': 'assets/gzod1.png'},
    {'img': 'assets/gzod2.png'},
    {'img': 'assets/gzod1.png'},
    {'img': 'assets/gzod2.png'},
  ];

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      bottomNavigationBar: bottomBarLayout(ctx, 0,Color(0xff32334D)),
      backgroundColor: Clr().white,
      appBar: AppBar(
        toolbarHeight: 60,

        elevation: 2,
        backgroundColor: Color(0xffDA9C83),
        leadingWidth: 40,
        leading: SvgPicture.asset('assets/appbar.svg'),
          title: Text('GZOD',
            style: Sty().mediumText.copyWith(
                color: Color(0xff32334D),
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(Dim().d8),
            child: Container(
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: Clr().borderColor.withOpacity(1),
                //     spreadRadius: 0.1,
                //     blurRadius: 12,
                //     offset: Offset(0, 0), // changes position of shadow
                //   ),
                // ],
              ),
              child: SizedBox(
                width: 95,
                height: 15,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        // backgroundColor: Clr().accentColor,
                        backgroundColor: Color(0xffFCEBE3),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xfff4f4f5)),
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      STM().redirect2page(ctx, Job());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/search.svg'),
                        SizedBox(
                          width: Dim().d8,
                        ),
                        Text(
                          'Jobs',
                          style: Sty().largeText.copyWith(
                              color: Clr().textcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dim().d12),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: gzodList.length,
              itemBuilder: (context, index) {
                bool isLike = false;
                bool isdisLike = false;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      margin: EdgeInsets.only(bottom: Dim().d20),
                      decoration: BoxDecoration(
                        color: Clr().white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Clr().borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Clr().borderColor.withOpacity(0.8),
                            spreadRadius: 0.5,
                            blurRadius: 4,
                            offset: Offset(5, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                ),
                                child: Image.asset(gzodList[index]['img'])),
                            SizedBox(
                              height: Dim().d8,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: Dim().d12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (likeList.contains(index)) {
                                                setState(() {
                                                  likeList.remove(index);
                                                  isLike = true;
                                                });
                                              } else {
                                                setState(() {
                                                  likeList.add(index);
                                                  dislikeList.remove(index);
                                                  isLike = false;
                                                });
                                              }
                                              // STM().redirect2page(ctx, Electronics(categoryList[index]['id'].toString()));
                                            },
                                            child: likeList.contains(index)
                                                ? Lottie.asset(
                                                    'animations/like_fill.json',
                                                    height: 24,
                                                    reverse: false,
                                                    repeat: false,
                                                    fit: BoxFit.cover,
                                                  )
                                                : SizedBox(
                                                    height: 24,
                                                    child: SvgPicture.asset(
                                                        'assets/like.svg'),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: Dim().d2,
                                          ),
                                          Text('200')
                                        ],
                                      ),
                                      SizedBox(
                                        width: Dim().d20,
                                      ),
                                      SizedBox(
                                        width: 24,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (dislikeList
                                                    .contains(index)) {
                                                  setState(() {
                                                    dislikeList.remove(index);
                                                    isdisLike = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    dislikeList.add(index);
                                                    likeList.remove(index);
                                                    isdisLike = false;
                                                  });
                                                }
                                                // STM().redirect2page(ctx, Electronics(categoryList[index]['id'].toString()));
                                              },
                                              child: SizedBox(
                                                height: 25,
                                                child: dislikeList.contains(index)
                                                        ? Lottie.asset(
                                                            'animations/dislike_fill.json',
                                                            height: 27,
                                                            reverse: false,
                                                            repeat: false,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : SizedBox(
                                                            height: 24,
                                                            child: SvgPicture.asset(
                                                                'assets/dislike.svg'),
                                                          ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dim().d2,
                                            ),
                                            Text('50')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '12 Apr 2023',
                                    style: Sty().smallText.copyWith(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dim().d8,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
