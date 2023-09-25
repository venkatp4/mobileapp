import 'dart:convert';
import 'dart:math';

import 'package:ez/models/popup/widgetpopup/tasklist.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/auth_repo.dart';
import '../../../utils/file_fns.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../../widgets/connectItemtaskcomplete.dart';
import '../controllers/tasktabcontroller.dart';
import 'package:dio/dio.dart';

class TaskTab extends StatefulWidget {
  @override //
  _TaskTabState createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  final controller = Get.put(TaskTabController());
  int iSelectedFileCount = 0;

  void getTaskList() async {
    SharedPreferences pre = await SharedPreferences.getInstance();

    //final responses = await AuthRepo.getTaskList('7', '1082');

    String payloadenc =
        '{"filterBy":[{"filters":[{"criteria":"createdBy","condition":"IS_EQUALS_TO","value":8}]}]}';
    //payloadenc = '{"itemsPerPage":20,"currentPage":1}';

    final responses = await AuthRepo.getTaskList(
        '7', '1082', jsonEncode(AaaEncryption.EncryptDatatest(payloadenc)));

    String dec = AaaEncryption.decryptAESaaa(responses.toString());

    print(dec);
    print('31ttwwwwccccccccccccccccccccccccccc');
    print(pre.getString('username'));
    List tagObjsJson = jsonDecode(dec) as List;
    print('wwt31ttwwwwccccccccccccccccccccccccccc');
    Map<String, dynamic> valueMape = tagObjsJson.elementAt(0);
    print(valueMape['processId']);
    print('tr31ttwwwwccccccccccccccccccccccccccc');
    print(valueMape['entryInfo']);
    print('t31ttwwwwccccccccccccccccccccccccccc');
    // getFieldValues('19', valueMape['entryInfo']);
    List entryInfo = valueMape['entryInfo'] as List;

    controller.fieldkeys.toList().forEach((element) {
      Map<String, dynamic> tmap = new Map<String, dynamic>();

      entryInfo.forEach((elementEntry) {
        print(
            'wttttterr31ttwwwwccccccccccccccccccccccccccc'); // not completed tomorrow 12-09-2023
        print(elementEntry[element]);

        tmap["Assign to"] = elementEntry[element];
        tmap["start date"] = elementEntry[element];
        tmap["end date"] = elementEntry[element];
        tmap["Buttons"] = elementEntry[element];
        print('wttttterr31ttwwwwccccccccccccccccccccccccccc');
        // same for xpos and ypos
      });
    });
    //var tagObjsJson = jsonDecode(dec) as List;
/*    List<filedatas> tagObjs =
    tagObjsJson.map((tagJson) => filedatas.fromJson(tagJson)).toList();
    setState(() {
      controller.dataFileListNew = tagObjs;
    });*/
    debugPrint('678ccccccccccccccccccccccccccc');
  }

  Future getFieldValues(String formId, Map<String, dynamic> mdata) async {
    Map mdataGenerate = Map<String, dynamic>();

    try {
      debugPrint('dd678ccccccccccccccccccccccccccc111');
      final response = await AuthRepo.getInboxSingleDetails(formId); //23 formid
      Map<String, dynamic> data =
          jsonDecode(AaaEncryption.decryptAESaaa(response.data));

      //Map<String, dynamic> datas = json.decode(data['formJson']);
      Map<String, dynamic> datasControl = json.decode(data['controllist']);
      debugPrint('dd678ccccccccccccccccccccccccccc111');

      datasControl['panels'].forEach((item) {
        for (var entry in mdata.entries) {
          item['fields'].forEach((field) {
            if (entry.key.toString() == field['id']) {
              /*        mdataGenerate.putIfAbsent(
                  field['label'].toString(), () => checkIsArray(entry.value));*/
            }
            //controller.filedsnew.
          });
        }
      });
      debugPrint('r11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
/*      setState(() {
        isLoading.value = false;
        controller.filedsnew = mdataGenerate;
      });*/

      if (response.statusCode == 200) {
      } else {
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {}
      if (statusCode == 402) {
        // error.value = 'license expired';
      } else if (statusCode == 404) {
        // error.value = 'email not found';
      } else if (statusCode == 409) {
        // error.value = 'incorrect password';
      } else {
        rethrow;
      }
    } catch (e) {
      print(e);
      //error.value = 'error logging in';
    } finally {
      //isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getTaskList();
    //controller.
  }

  @override
  Widget build(BuildContext context) {
    var sTextdatadesc = sReturnStatus();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
            itemCount: controller.folderDatas.length,
            itemBuilder: (context, index) {
              // filedatas item = controller.folderDatas.elementAt(index);
              return TaskList(
                cMenu: controller.folderDatas[index],
                iPosition: index,
              );
              // return Text(
              //     controller.folderDatas[index]['Foldername'].toString());
            },
          ),
          floatingActionButton: Wrap(
            //will break to another line on overflow
            direction: Axis.vertical, //use vertical to show  on vertical axis
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton.small(
                    backgroundColor: Colors.blueAccent.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    child: Icon(color: Colors.white, Icons.add),
                    onPressed: () => {},
                  )), // button third

              // Add more buttons here
            ],
          ),
        ));
  }

  String sReturnVal() {
    var arr = [
      "Inversments1 \u2022 DATE:12-Apr-2023 \u2022 sangilimurugan.nezofis.com \u2022 ",
      "Inversments2 \u2022 DATE:02-Jun-2023  \u2022 raja@ezofis.com \u2022 ",
      "Inversments3 \u2022 DATE:23-May-2023  \u2022 arun.ezofis.com \u2022 "
    ];
    return arr[randomgrn()];
  }

  int randomgrn() {
    Random r = new Random();
    return r.nextInt(3);
  }

  String sReturnStatus() {
    var arrStatus = ["UPLOADED", "MODIFIED", "ESIGN_REQUIRED"];
    return arrStatus[randomgrn()];
  }

  Color sReturnColor(String sStutus) {
    switch (sStutus) {
      case 'UPLOADED':
        return Colors.grey;
      case 'MODIFIED':
        return Colors.green;
      case 'ESIGN_REQUIRED':
        return Colors.deepOrangeAccent;
    }
    return Colors.grey;
  }

  String fileIcon(String fileName) {
    final fileType = fileName.split('.').last.toLowerCase();
    final validTypes = validFileTypes();

    if (validTypes.contains(fileType)) {
      return '$path/$fileType.png';
    } else {
      return '$path/file.png';
    }
  }

  String formatFileSize(int size) {
    return filesize(size);
  }
}
