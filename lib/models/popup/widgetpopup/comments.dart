import 'dart:convert';
import 'dart:math';

import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/auth_repo.dart';
import '../../../utils/file_fns.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../comments.dart';
import '../controllers/commentcontroller.dart';

class CommenttList extends StatefulWidget {
  @override //
  _CommenttListState createState() => _CommenttListState();
}

class _CommenttListState extends State<CommenttList> {
  double safeAreaHeight = 0;
  TextEditingController commentController = TextEditingController();
  //SharedPreferences pre=null;
  final controller = Get.put(CommentController());
  ScrollController _scrollController = ScrollController();
  bool _needsScroll = false;
  int iSelectedFileCount = 0;

  @override
  void initState() {
    super.initState();

    getCommentsDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrolldown());
  }

  void getCommentsDetails() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    print('1ccccccccccccccccccccccccccc');
    final responses = await AuthRepo.getCommentsList('7', '1082');
    print('2ccccccccccccccccccccccccccc');
    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    print('31ccccccccccccccccccccccccccc');
    print(dec);
    print('31wwwwccccccccccccccccccccccccccc');
    print(pre.getString('username'));

    var tagObjsJson = jsonDecode(dec) as List;
    List<commentsdatas> tagObjs = tagObjsJson
        .map((tagJson) => commentsdatas.fromJson(tagJson, pre.getInt('id')))
        .toList();
    setState(() {
      controller.dataMessageList = tagObjs;
    });

    debugPrint('678ccccccccccccccccccccccccccc');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: safeAreaHeight == 716 ? 330 : 380,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: PageView(children: [
              Column(
                children: [
                  Flexible(
                      flex: 8,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: controller.dataMessageList.length,
                        itemBuilder: (context, index) {
                          commentsdatas item =
                              controller.dataMessageList.elementAt(index);
                          return ListTile(
                              //contentPadding: EdgeInsets.only(left: 30.0, right: 0.0),
                              title: Container(
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Row(children: [
                              Expanded(
                                  child: Container(
                                      child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  item.bIsMe
                                      ? Row(
                                          children: [
                                            Expanded(
                                                flex: 8,
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.black87,
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10.0))),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              item.sComments,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              '19-Jul-2023 03.35PM',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .white54,
                                                                  fontSize: 10),
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  width: double.infinity,
                                                ))
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  width: double.infinity,
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.teal,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0))),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                item.sComments,
                                                                // maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              Wrap(
                                                                  alignment:
                                                                      WrapAlignment
                                                                          .start,
                                                                  children: [
                                                                    //
                                                                    Text(
                                                                      item.sCreatedAt,
//                                                                      '20-Jul-2023 03.35PM',ew
                                                                      maxLines:
                                                                          1,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: Colors
                                                                              .white54,
                                                                          fontSize:
                                                                              10),
                                                                    )
                                                                  ])
                                                            ],
                                                          ))),
                                                )),
                                          ],
                                        ),
                                  //               SizedBox(height: 10),
                                ],
                              ))),
                            ]),
                          ));
                        },
                      )),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 32.0),
                        controller: commentController,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 4,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            suffixIcon: IconButton(
                              icon: Icon(
                                MdiIcons.send,
                                color: Colors.black54,
                              ),
                              onPressed: () {
/*                                commentsdatas(
                                    {required this.sProcessId,
                                      required this.sTransactionId,
                                      required this.sComments,
                                      required this.sExternalCommentsby,
                                      required this.sCreatedAt,
                                      required this.sCreatedByEmail,
                                      required this.bIsDeleted});*/

                                if (commentController.text.trim().length > 0) {
                                  commentsdatas items = commentsdatas(
                                      sComments: commentController.text.trim(),
                                      sCreatedAt: '',
                                      sCreatedByEmail: '',
                                      sExternalCommentsby: '',
                                      sProcessId: '',
                                      sTransactionId: '',
                                      bIsDeletes: false);
                                  /*commentsdatas items = commentsdatas(
                                      commentController.text.trim(), false);*/
                                  setState(() {
                                    controller.dataMessageList.add(items);
                                    commentController.text = '';
                                    scrolldown();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                }
                              },
                            ),
                            hintText: "Enter Remarks",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue)))),
                  )
                ],
              )
            ])));
  }

  scrolldown() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });
  }
}
