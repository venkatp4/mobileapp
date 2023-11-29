import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../form/components/MultiSelectMain.dart';

class PopupFullPageController extends GetxController {
  final isLoading = false.obs;
  final error = ''.obs;
  //late RxList<InboxDetails> idSelected;
  static int iSelectedIndex = 0;
  String sRaisedAt = '';
  String transaction_createdAt = '';
  String srequesno = '';
  String sFormId = '';
  String repositoryId = '';
  String sFormEntryId = '';
  String sProcessId = '';
  String sWorkFlowId = '';
  String sActivityId = '';
  String sFormJSon = '';
  String sSelectedFormID = '';
  String sTransactionId = '';
  Map<String, dynamic> mFormJSon = Map();
  List<Widget> wButtons = [];

  int iFilecount = 0;
  int iMsgCount = 0;
  int iTaskCount = 0;

  String sSelectedButtonOperation = '';

  bool bFab = false;
  List<Map<String, dynamic>> folderDatas = [
/*    {
      'Foldername': 'My Task',
      'details': {
        'Buttons': 'ReOpen,Low',
        'task owner': 'thanaselve@ezofis.com',
        'task assign': '[sangili@ezofis.com,raja@ezofis.com,raja2@ezofis.com]',
        'start date': '2023-03-02',
        'end date': '2023-03-22'
      }
    },
    {
      'Foldername': 'Signoid',
      'details': {
        'Buttons': 'Open,Medium',
        'task owner': 'raja@gmail.com',
        'task assign': '[arun@ezofis.com]',
        'start date': '2023-03-02',
        'end date': '2023-05-02'
      }
    }*/
  ];

  List<Map<String, dynamic>> InboxDataewew = [
    /*{
      'details': {
        'Reques No': 'SNo - 10',
        'Stage': 'Production Entry',
        'Rised At': '10-03-2023',
        'Rised BY': 'thanaselve@ezofis.com',
        'Last Action': 'Product Entry'
      }
    },
    {
      'details': {
        'Reques No': 'SNo - 11',
        'Stage': 'Production ',
        'Rised At': '10-06-2023',
        'Rised BY': 'raja@ezofis.com',
        'Last Action': 'Product Entry'
      }
    }*/
  ];

  List<Map<String, dynamic>> InboxDataNew = [
    /*{
      'requesno': 'SN - 10',
      'stage': 'Production Entry',
      'raisedat': '12-Apr-2023 01:55 AM',
      'raisedby': 'thanaselve@ezofis.com',
      'lastaction': 'Product Entry'
    },
    {
      'requesno': 'SN - 11',
      'stage': 'Production ',
      'raisedat': '14-Jun-2023 06:55 AM',
      'raisedby': 'raja@ezofis.com',
      'lastaction': 'Product Entrys'
    },
    {
      'requesno': 'SN - 10',
      'stage': 'Production Entry',
      'raisedat': '21-Apr-2023 01:55 AM',
      'raisedby': 'thanaselve@ezofis.com',
      'lastaction': 'Product Entry'
    },
    {
      'requesno': 'SN - 11',
      'stage': 'Production ',
      'raisedat': '11-Jun-2023 06:55 AM',
      'raisedby': 'raja@ezofis.com',
      'lastaction': 'Product Entrys'
    },
    {
      'requesno': 'SN - 10',
      'stage': 'Production Entry',
      'raisedat': '01-Apr-2023 01:55 AM',
      'raisedby': 'thanaselve@ezofis.com',
      'lastaction': 'Product Entry'
    },
    {
      'requesno': 'SN - 11',
      'stage': 'Production ',
      'raisedat': '23-Jun-2023 06:55 AM',
      'raisedby': 'raja@ezofis.com',
      'lastaction': 'Product Entrys'
    }*/
  ];

  void roundbtngeneral() {
    debugPrint('roundbtngeneral onFabPlus in Task');
  }

  getButtonlist() {
    wButtons = [];
    print('getButtonlist--123');
    for (int i = 0; i < mFormJSon['rules'].length; i++) {
      // print(mFormJSon['rules'][i]['fromBlockId'] + '  kkkk ' + sActivityId);
      if (mFormJSon['rules'][i]['fromBlockId'] == sActivityId) {
        wButtons.add(createIcons(mFormJSon['rules'][i]['proceedAction'].toString()));
      }
    }

    print('dsd12');
    print('dsd');

    for (int i = 0; i < mFormJSon['blocks'].length; i++) {
      // print(mFormJSon['rules'][i]['fromBlockId'] + '  kkkk ' + sActivityId);
      if (mFormJSon['blocks'][i]['id'] == sActivityId) {
        if (mFormJSon['blocks'][i]['settings']['internalForward']) {
          wButtons.add(MultiSelectMain());
        }
      }
    }
  }

  Widget createIcons(String sButtintext) {
    switch (sButtintext) {
      case 'Submit':
      case 'Forward':
      case 'Ignore':
        return buttonGenerate(
            sButtintext,
            Colors.orange,
            Icon(
              MdiIcons.arrowRight,
              color: Colors.orange,
            ));
      case 'Rightsize':
      case 'Complete':
        return buttonGenerate(
            sButtintext,
            Colors.green,
            Icon(
              MdiIcons.check,
              color: Colors.green,
            ));
      case 'Terminate':
      case 'Close':
        return buttonGenerate(
            sButtintext,
            Colors.redAccent,
            Icon(
              MdiIcons.close,
              color: Colors.redAccent,
            ));
      default:
        return buttonGenerate(
            sButtintext,
            Colors.purple,
            Icon(
              MdiIcons.arrowRight,
              color: Colors.purple,
            ));
    }
  }

  buttonGenerate(String sname, Color clr, Icon icn) {
    return Container(
        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            textStyle: TextStyle(color: clr),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0), side: BorderSide(width: 2, color: clr)),
          ),
          onPressed: () => {sSelectedButtonOperation = sname, buttonAction()},
          icon: icn,
          label: Text(
            sname,
            style: TextStyle(color: clr),
          ),
        ));
  }

  Future buttonAction() async {
    isLoading.value = true;
    if (sSelectedButtonOperation.toLowerCase() == 'forward') {
      print('forward4441 ' + sSelectedButtonOperation);
      print('fffff444');
    } else {
      print('!Other444 ' + sSelectedButtonOperation);
    }
  }
}
