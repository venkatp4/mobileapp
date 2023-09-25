import 'dart:convert';
import 'dart:math';

import 'package:ez/config/theme.dart';
import 'package:ez/controllers/taskmaincontroller.dart';
import 'package:ez/widgets/textsmallthin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/auth_repo.dart';
import '../layouts/auth/widgets/fab.dart';
import '../models/popup/controllers/popupfullpagecontroller.dart';
import '../models/popup/popupfullpage_inbox.dart';
import '../utils/InboxDetails.dart';

import '../utils/format_date_time.dart';

import '../utils/helper/aes_encryption.dart';
import '../utils/helper/safe_area.dart';
import 'CustomWidget.dart';
//Creating a class user to store the data;

class ListViewSearch extends StatefulWidget {
  ListViewSearchState createState() => ListViewSearchState();
}

class ListViewSearchState extends State<ListViewSearch> {
  TextEditingController controller = new TextEditingController();
  List<InboxDetails> _searchResult = [];
  List<InboxDetails> _inboxDetailss = [];
  List<InboxDetails> _inboxDetailss_temp = [];
  final String url = 'https://jsonplaceholder.typicode.com/users';
  TaskMainController controllertask = new TaskMainController();
  final controllerpopup = Get.put(PopupFullPageController());
  final isLoading = true.obs;

  var arr = [
    'assets/images/logo/user/user.png',
    'assets/images/logo/user/usertwo.png',
    'assets/images/logo/user/userthree.png',
    'assets/images/logo/user/userfour.png'
  ];

  Future<Null> getInboxDetailsNew() async {
    _inboxDetailss = [];
    String payloadenc = '{"currentPage": 1, "itemsPerPage": 20}';

    final responses = await AuthRepo.getInboxListForFolder(
        '7', jsonEncode(AaaEncryption.EncryptDatatest(payloadenc)));

    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    Map<String, dynamic> valueMap = json.decode(dec);

    valueMap['data'].forEach((item) {
      setState(() {
        _inboxDetailss = [];
      });

      print('lgggggggggggggggggggggggggtt ' + _inboxDetailss.length.toString());
      item['value'].forEach((items) {
        setState(() {
          _inboxDetailss.add(InboxDetails.fromJson(items));
        });
      });
      setState(() {
        isLoading.value = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _inboxDetailss = [];
    _inboxDetailss_temp = [];

    //getInboxDetails();
    print('lgggggggggggggggggggggggggwwwwwwwwww ');
    getInboxDetailsNew();
  }

  @override
  Widget build(BuildContext context) {
    final safeArea = calcSafeArea();
    double safeAreaHeight = safeArea['height']!;
    return Obx(() => isLoading.value
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ListTile(
                    leading: CustomWidget.circular(height: 64, width: 64),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomWidget.rectangular(
                        height: 16,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                    subtitle: CustomWidget.rectangular(height: 14),
                  ));
            },
          ) /*Center(child: Container(child: Text('Loading...')))*/
        : ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            //scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _inboxDetailss.length,
            itemBuilder: (context, index) {
              print('ccccccccccccccccccccccccccccc');
              return Container(
                  // color: Colors.yellow,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: ListTile(
                    onTap: () {
                      PopupFullPageController.iSelectedIndex = index;
                      controllerpopup.sRaisedAt =
                          _inboxDetailss.elementAt(index).raisedAt;
                      controllerpopup.srequesno =
                          _inboxDetailss.elementAt(index).requestNo;
                      /*                          Navigator.of(context)
                                      .push(PopupFullpageInbox());*/
                      Get.offAllNamed('/inboxpage');
                    },
                    title: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 12,
                            child: Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.all(2),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(15), // Image radius
                                    child: Image.asset(
                                        arr[new Random().nextInt(4)],
//                                                'assets/images/logo/user/user.png',
                                        fit: BoxFit.fill),
                                  ),
                                ))),
                        Expanded(
                            flex: 80,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    //141  55,16,16
                                    // name
                                    Text(
                                        _inboxDetailss[index].stage +
                                            ' - ' +
                                            _inboxDetailss[index].requestNo,
                                        overflow: TextOverflow.ellipsis,
                                        style: _inboxDetailss[index].bread
                                            ? TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300)
                                            : TextStyle(
                                                color: Colors.black87,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w600)),
                                    // ...
                                    //SizedBox(height: 2),
                                    // email
                                    Text(_inboxDetailss[index].raisedBy,
                                        overflow: TextOverflow.ellipsis,
                                        style: _inboxDetailss[index].bread
                                            ? TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300)
                                            : TextStyle(
                                                color: Colors.black87,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                    Text(
                                        _inboxDetailss[index]
                                                    .lastAction
                                                    .toString() ==
                                                'null'
                                            ? '-'
                                            : _inboxDetailss[index]
                                                .lastAction
                                                .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300)),
                                    // ...
                                  ],
                                ))),
                        Expanded(
                            flex: 20,
                            child: Container(
                                //color: Colors.green,
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Text(
                                    textAlign: TextAlign.end,
                                    /*getCurrentDate(),*/
                                    timeFormate(
                                        _inboxDetailss[index].raisedAt.trim()),
                                    overflow: TextOverflow.ellipsis,
                                    style: _inboxDetailss[index].bread
                                        ? TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300)
                                        : TextStyle(
                                            color: Colors.black87,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600))))
                      ],
                    ),
                  ));
            },
          ));
  }

  onTabSelected(int i) {
    debugPrint('ggggggg88888    ' + i.toString());
    //PopupFullpageInbox(C);
  }
}
