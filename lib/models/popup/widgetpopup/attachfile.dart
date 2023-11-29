import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/auth_repo.dart';
import '../../../utils/file_fns.dart';
import '../../../utils/format_date_time.dart';
import '../../../utils/helper/aes_encryption.dart';
import '../../../widgets/MotionToastWidget.dart';
import '../controllers/attachfilecontroller.dart';
import 'package:get/get.dart';

import '../controllers/popupfullpagecontroller.dart';
import '../models/selectedFileUpload.dart';
import '../models/selected_file.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
//import '../utils/format_date_time.dart';

class AttachFiles extends StatefulWidget {
  @override //
  _AttachFilesState createState() => _AttachFilesState();
}

class _AttachFilesState extends State<AttachFiles> {
  final controller = Get.put(AttcaheFileController());
  final controllerpopup = Get.put(PopupFullPageController());
  int iSelectedFileCount = 0;

/*  @override
  void initState() {
    super.initState();
    getFileDetails();
    //controller.
  }*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getFileDetails();
  }

  void getFileDetails() async {
    final responses =
        await AuthRepo.getFileList(controllerpopup.sWorkFlowId, controllerpopup.sProcessId);
    String dec = AaaEncryption.decryptAESaaa(responses.toString());
    var tagObjsJson = jsonDecode(dec) as List;
    List<filedatas> tagObjs = tagObjsJson.map((tagJson) => filedatas.fromJson(tagJson)).toList();
    setState(() {
      controller.dataFileListNew = tagObjs;

      //dataFileListNew
      //https://stackoverflow.com/questions/44841729/how-to-upload-images-to-server-in-flutter
    });
  }

  @override
  Widget build(BuildContext context) {
    //var sTextdatadesc = sReturnStatus();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: ListView.builder(
            itemCount: controller.dataFileListNew.length,
            itemBuilder: (context, index) {
              filedatas item = controller.dataFileListNew.elementAt(index);
              return ListTile(
                  title: GestureDetector(
                      onTap: () {
                        setState(() {
                          item.selected = !item.selected;
                          if (item.selected) controller.dataFileListNew[index] = item;

                          controller.iSelecteFileCount =
                              controller.getSelectedFileCount(controller.dataFileListNew);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          //list[index].isSelected = true;
                          controller.iSelecteFileCount = 0;
                          item.selected = true;
                          controller.iSelecteFileCount =
                              controller.getSelectedFileCount(controller.dataFileListNew);
                        });
                      },
                      /*fnLongPress(item.selected, index)*/
                      child: Container(
                          key: UniqueKey(),
                          padding: EdgeInsets.all(5),
                          decoration: !item.selected
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)))
                              : BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Column(children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 10,
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.all(2),
                                        child: Image.asset(
                                          fileIcon(item.name),
                                          height: 20,
                                          width: 20,
                                          /*  color:
                                              sTextdatadesc.contains('MODIFIED')
                                                  ? Colors.blueAccent
                                                  : Colors.red,*/
                                        ))),
                                Expanded(
                                    flex: 65,
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // name
                                            Text(item.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500)),
                                            // ...
                                            SizedBox(height: 2),
                                            // email
                                            Text(item.description,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300)),
                                            RichText(
                                              text: TextSpan(
                                                text: item.createdByEmail + ' ',
                                                style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: item.Status,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: sReturnColor(item.Status))),
                                                ],
                                              ),
                                            ),
                                            // ...
                                          ],
                                        ))),
                                Expanded(
                                    flex: 15,
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: Text(
                                            textAlign: TextAlign.end,
                                            timeFormate(item.createdAt.trim()),

                                            /*   timeFormate(
                                                _inboxDetailss[index]
                                                    .raisedat
                                                    .trim())*/
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300))))
                              ],
                            ),
                          ]))));
            },
          ),
          floatingActionButton: Wrap(
            //will break to another line on overflow
            direction: Axis.vertical, //use vertical to show  on vertical axis
            children: <Widget>[
              controller.iSelecteFileCount > 0
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(color: Colors.white, Icons.delete_outline),
                        onPressed: () => {deleteFiles()},
                      ))
                  : SizedBox(), //button first

              controller.iSelecteFileCount > 1
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(color: Colors.white, Icons.merge),
                        onPressed: () => {},
                      ))
                  : SizedBox(), // button second

              controller.iSelecteFileCount == 0
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.blueAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7.0))),
                        child: Icon(color: Colors.white, Icons.file_upload_outlined),
                        onPressed: () => {onUpload()},
                      ))
                  : SizedBox(), // button third

              // Add more buttons here
            ],
          ),
        ));
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

  void onUpload() async {
    if (await controller.selectedUploadedFiles()) {
      print('sssssssssssssss');
      MotionToastWidget().displaySuccessMotionToast('File Uploaded Sucessfully.', context);
      getFileDetailsCount();
      getFileDetails();
    } else {
      print('sssssssssssssssveee');
      MotionToastWidget().displayErrorMotionToast('File Not Uploaded.', context);
    }
    debugPrint('onFabPlus onUpload');
  }

/*  void selectedUploadedFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      this.selectedFiles.clear();

      selectedFiles.value = result.files
          .map((file) => SelectedFileUpload(
              name: file.name,
              size: formatFileSize(file.size),
              type: file.extension ?? '',
              file: file.path,
              workflowId: controllerpopup.sWorkFlowId,
              repositoryId: controllerpopup.repositoryId,
              processId: controllerpopup.sProcessId,
              transactionId: controllerpopup.sTransactionId,
              fields: ''))
          .toList();

      showSelectedFiles.value = true;

      dii.FormData formData = new dii.FormData.fromMap({
        'name': selectedFiles[0].name,
        'size': selectedFiles[0].size,
        'type': selectedFiles[0].type,
        'file': await dii.MultipartFile.fromFile(selectedFiles[0].file),
        'workflowId': controllerpopup.sWorkFlowId,
        'repositoryId': controllerpopup.repositoryId,
        'processId': controllerpopup.sProcessId,
        'transactionId': controllerpopup.sTransactionId,
        'fields': ''
      });

      final responses = await AuthRepo.postAttachment(formData);
      String dec = AaaEncryption.decryptAESaaa(responses.toString());

      final statusCode = responses.statusCode;

      if (statusCode != 200) {
        return true;
      }
      return false;
    }
  }*/

  Future<void> deleteFiles() async {
    bool res = await controller.DeleteMultipleFiles(context);
    if (res) {
      controller.iSelecteFileCount = 0;
      getFileDetails();
      getFileDetailsCount();
    }
  }

  void getFileDetailsCount() async {
    final responses =
        await AuthRepo.getFileList(controllerpopup.sWorkFlowId, controllerpopup.sProcessId);
    List lFiles = jsonDecode(AaaEncryption.decryptAESaaa(responses.toString())) as List;
    setState(() {
      controllerpopup.iFilecount = lFiles.length;
    });
  }

/*  Future selectFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      controller.selectedFiles.clear();

      controller.selectedFiles.value = result.files
          .map((file) => SelectedFile(
                name: file.name,
                size: formatFileSize(file.size),
                type: file.extension ?? '',
                file: file,
              ))
          .toList();
      controller.showSelectedFiles.value = true;

*/ /*      for (var file in selectedFiles) {
        void setUploadProgress(int uploaded, int total) {
          uploadProgress[file.name] = uploaded / total;
        }

        await uploadFile(
          file.name,
          file.file.path ?? '',
          file.size,
          setUploadProgress,
        );
      }*/ /*
      //selectedFiles.clear();
    }
  }*/

  String formatFileSize(int size) {
    return filesize(size);
  }

  void _displayErrorMotionToast() {
    MotionToast.error(
      title: const Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('Please enter your name'),
      position: MotionToastPosition.top,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300,
      height: 80,
      dismissable: false,
    ).show(context);
  }

  void _displaySuccessMotionToast(String Msgs, BuildContext ctx) {
    MotionToast toast = MotionToast.success(
        title: const Text(
          'Sucess',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        description: Text(
          Msgs,
          style: TextStyle(fontSize: 12),
        ),
        layoutOrientation: ToastOrientation.rtl,
        animationType: AnimationType.fromRight,
        borderRadius: 5,
        dismissable: true,
        height: 50,
        width: 300);

    toast.show(ctx);
    Future.delayed(Duration(seconds: 4)).then((value) {
      toast.dismiss();
    });
  }
}
