import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'values/colors.dart';
import 'values/dimens.dart';
import 'values/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext ctx;

  int selected1 = -1;
  int selected2 = -1;
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
          centerTitle: true,
          leadingWidth: 40,
          leading: SvgPicture.asset('assets/appbar.svg'),
          title: InkWell(onTap: ()async{
            SharedPreferences sp = await SharedPreferences.getInstance();
            sp.clear();
          },
            child: Text(
              'GZOD',
              style: Sty().mediumText.copyWith(
                  color: Color(0xff32334D),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          )),
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
                                                  isLike = false;
                                                });
                                              } else {
                                                setState(
                                                  () {
                                                    isLike = true;
                                                    likeList.add(index);
                                                    dislikeList.remove(index);
                                                  },
                                                );
                                              }
                                            },
                                            // child: SvgPicture.asset(
                                            //     likeList.contains(index)
                                            //         ? 'assets/likefill.svg'
                                            //         : 'assets/like.svg'),
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
                                                        'assets/like.svg')),
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
                                                child:
                                                    dislikeList.contains(index)
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
