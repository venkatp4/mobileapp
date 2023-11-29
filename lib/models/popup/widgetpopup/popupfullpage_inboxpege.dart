import 'dart:convert';
//import 'dart:ffi';

import 'package:ez/models/popup/tabmainscreen.dart';
import 'package:ez/models/popup/textnormal.dart';
import 'package:ez/models/popup/textsmalll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../api/auth_repo.dart';
import '../../../layouts/process/ProcessLayout.dart';
import '../../../layouts/process/ProcessLayoutTab.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../../widgets/buttonroundednoaction.dart';
import '../controllers/gridviewhomecontroller.dart';
import '../controllers/popupfullpagecontroller.dart';

import 'package:dio/dio.dart';

class PopupFullpageInboxPage extends StatefulWidget {
  @override
  _PopupFullpageInboxPageState createState() => _PopupFullpageInboxPageState();
}

class _PopupFullpageInboxPageState extends State<PopupFullpageInboxPage> {
  final controllerpopup = Get.put(PopupFullPageController());
  final controller = Get.put(GridViewHomeController());
  final isLoading = false.obs;
  final error = ''.obs;

  // workflowjson->blocks ->internalforward  21-11-23 continue
  //sdsd

  @override
  void initState() {
    super.initState();
    getInboxDetails().then((value) => {controllerpopup.getButtonlist()});
  }

  Future<Null> getInboxDetails() async {
    String payloadenc = '{"currentPage": 1, "itemsPerPage": 20}';
    //payloadenc = '{"itemsPerPage":20,"currentPage":1}';

    final responses = await AuthRepo.getInboxListForFolder(
        controllerpopup.sWorkFlowId,
        jsonEncode(AaaEncryption.EncryptDatatest(payloadenc)),
        ''); //       timeFormate(_inboxDetailss[index].raisedAt.trim()),

    String dec = AaaEncryption.decryptAESaaa(responses.toString());

    Map<String, dynamic> valueMap = json.decode(dec);

    setState(() {
      controller.filedsnew = {};
    });

    valueMap['data'].forEach((item) {
      item['value'].forEach((items) {
/*        print('llllllllllllllllllllll1---');
        print(controller.filedsnew.length);*/
        if (controller.filedsnew.length == 0) {
          getInboxSingleDetails(
              items['formData']['formId'].toString(), items['formData']['fields']);
        } /*else {
          print('llllllllllllllllllllll1--- else');
          getInboxSingleDetails(controllerpopup.sFormId, items['formData']['fields']);
        }*/
      });
    });
  }

  Future getInboxSingleDetails(String formId, Map<String, dynamic> mdata) async {
    isLoading.value = true;
    Map mdataGenerate = Map<String, dynamic>();
    error.value = '';
    try {
      final response = await AuthRepo.getInboxSingleDetails(formId); //23 formid
      Map<String, dynamic> data = jsonDecode(AaaEncryption.decryptAESaaa(response.data));
      isLoading.value = false;
      Map<String, dynamic> datas = json.decode(data['formJson']);

      datas['panels'].forEach((item) {
        for (var entry in mdata.entries) {
          item['fields'].forEach((field) {
            if (entry.key.toString() == field['id']) {
              mdataGenerate.putIfAbsent(field['label'].toString(), () => checkIsArray(entry.value));
            }
            //controller.filedsnew.
          });
        }
      });
      debugPrint('r11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      setState(() {
        isLoading.value = false;
        controller.filedsnew = mdataGenerate;
      });

      if (response.statusCode == 200) {
      } else {
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        error.value = 'Unauthorized Login';
      }
      if (statusCode == 402) {
        error.value = 'license expired';
      } else if (statusCode == 404) {
        error.value = 'email not found';
      } else if (statusCode == 409) {
        error.value = 'incorrect password';
      } else {
        rethrow;
      }
    } catch (e) {
      print(e);
      error.value = 'error logging in';
    } finally {
      isLoading.value = false;
    }
  }

  String checkIsArray(dynamic dVal) {
/*    if (dVal is List) print('ttttttttttttttttt List');
    if (dVal is Array) print('ttttttttttttttttt array');*/
    String stemp = dVal.toString().replaceAll('\n', '').replaceAll('\r', '');
    return stemp.trim().length > 0 ? stemp : '-';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final mediaQuery = MediaQuery.of(context);
    return ProcessLayoutTab(children: [
      Container(
          width: mediaQuery.size.width,
          height: mediaQuery.size.height * .9,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 15,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))*/
                      ),
                      width: double.infinity,
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 4,
                                child: DefaultTextStyle(
                                    maxLines: 2,
                                    style: TextStyle(decoration: TextDecoration.none),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextNormalPop(
                                            sLabel: controllerpopup
                                                .srequesno /*'+ They are not necessarily opaque, however; for example, a pop-up menu uses a ModalRoute'*/)))),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(children: <Widget>[
                                  Icon(
                                    size: 17,
                                    MdiIcons.clockOutline,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  DefaultTextStyle(
                                      maxLines: 2,
                                      style: TextStyle(decoration: TextDecoration.none),
                                      child: TextSmallPop(sLabel: controllerpopup.sRaisedAt)),
                                  SizedBox(
                                    width: 15,
                                  )
                                ])),
                          ])
                      // color: Colors.blue, /*child: TextNormal(sLabel: 'dsd')*/
                      )),
              Expanded(
                  flex: 80,
                  child: Material(
                      child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
                    /*margin: EdgeInsets.fromLTRB(10, 0, 10, 0),*/
                    child: TabMianScreen(),
                  ))),
            ],
          )),
    ]);
  }

/*  Future<bool> _onWillPop() async {
    //final cont = Get.put(BrowseViewController());
    Get.offAndToNamed("/home");
    return true;
  }*/

  buttonGenerate(String sname, Color clr, Icon icn) {
    return Container(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: clr),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0), side: BorderSide(width: 2, color: clr)),
          ),
          onPressed: () => {},
          icon: icn,
          label: Text(
            sname,
            style: TextStyle(color: clr),
          ),
        ));
  }
}
