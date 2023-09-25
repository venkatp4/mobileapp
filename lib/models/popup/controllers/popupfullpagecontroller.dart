import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PopupFullPageController extends GetxController {
  final isLoading = false.obs;
  final error = ''.obs;
  //late RxList<InboxDetails> idSelected;
  static int iSelectedIndex = 0;
  String sRaisedAt = '';
  String srequesno = '';
  String sFormId = '';

  List<Map<String, dynamic>> folderDatas = [
    {
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
    }
  ];

  List<Map<String, dynamic>> InboxDataewew = [
    {
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
    }
  ];

  List<Map<String, dynamic>> InboxDataNew = [
    {
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
    }
  ];

  void roundbtngeneral() {
    debugPrint('roundbtngeneral onFabPlus in Task');
  }
}
