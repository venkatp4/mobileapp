import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../utils/helper/safe_area.dart';

import 'components/divider.dart';
import 'components/panel.dart';
import 'components/text_input.dart';
import 'components/textbold.dart';
import 'components/textnormal.dart';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../api/auth_repo.dart';
import 'package:dio/dio.dart';
import '../../../utils/helper/aes_encryption.dart';
import 'controllers/panel_controller.dart';

class FormMain extends StatefulWidget {
  FormMainState createState() => FormMainState();
}

class FormMainState extends State<FormMain> {
  final isLoading = false.obs;
  final error = ''.obs;

  Map mdataGenerate = Map<String, dynamic>();
  Map datas = Map<String, dynamic>();
  final controller = Get.put(PanelController());

  @override
  void initState() {
    //
    // textController.text = "${widget.defaultValue}";
    super.initState();
    getUserDetails('3061'); //3061 23
  }

  Future getUserDetails(String formId) async {
    isLoading.value = true;

    error.value = '';
    try {
      final response = await AuthRepo.getInboxSingleDetails(formId); //23 formid

      Map<String, dynamic> data =
          jsonDecode(AaaEncryption.decryptAESaaa(response.data));
      setState(() {
        isLoading.value = false;
        mdataGenerate = data;

        datas = json.decode(data['formJson']);
      });
      print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
      print(data['name'].toString());

      datas['panels'].forEach((item) {
        print(item);
        debugPrint('124ggqqewwr11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        print(datas['panels'].length);
/*        debugPrint('24ggqqewwr11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        print(item.settings.title);
        debugPrint('34ggqqewwr11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        Map<String, dynamic> datasff = json.decode(item.settings.title);
        debugPrint('wwer11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        Map<String, dynamic> ff = item.settings;
        item['fields'].forEach((field) {});*/

        print('+++++++++++++++++++++++++++++++++++++++++++++++=');
        datas['panels'].forEach((item) {
          print('----------');
          print(item['settings']['title']);
          print('----------1');
          item['fields'].forEach((field) {
            print(field['id']);
            print(field['label']);

            //controller.filedsnew.
          });
        });
        print('+++++++++++++++++++++++++++++++++++++++++++++++=');
      });
      debugPrint('r11234556eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      setState(() {
        isLoading.value = false;
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

  @override
  Widget build(BuildContext context) {
    final safeArea = calcSafeArea();
    double safeAreaHeight = safeArea['height']!;
    // TODO: implement build
    return isLoading.isFalse
        ? Scaffold(
            body: Container(
            color: Color.fromRGBO(240, 245, 249, 1), //rgb(240 245 249)
            // margin: EdgeInsets.all(5),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                    backgroundColor: Colors.white,
                    pinned: true,
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textbold(sLabel: mdataGenerate['name'].toString()),
                          mdataGenerate['description'].toString().length > 0
                              ? TextNormal(
                                  sLabel:
                                      mdataGenerate['description'].toString())
                              : Container(),
                        ])),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: StickyHeader(
                          header: '${datas['panels'][index]['settings']['title']}'
                                          .toString()
                                          .length >
                                      0 ||
                                  '${datas['panels'][index]['settings']['description']}'
                                          .toString()
                                          .length >
                                      0
                              ? Container(
                                  child: Panel(
                                      sHeading:
                                          '${datas['panels'][index]['settings']['title']}'
                                              .toString(),
                                      sDescription:
                                          '${datas['panels'][index]['settings']['description']}'
                                              .toString()))
                              : Container(),
                          content: Container(
                            // margin: EdgeInsets.only(bottom: 10),
                            //color: Colors.yellow,
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            margin: EdgeInsets.only(top: 5, bottom: 10),
                            child: Expanded(
                                child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 1.0,
                                              crossAxisSpacing: 1.0,
                                              crossAxisCount:
                                                  (MediaQuery.of(context)
                                                              .orientation ==
                                                          Orientation.portrait)
                                                      ? 1
                                                      : 2,
                                              childAspectRatio: 4.8),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          //margin: EdgeInsets.only(bottom: 10),
                                          // color: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextInput(
                                                borderColor:
                                                    const Color(0xFFE0E0E0),
                                                initialValue: '',
                                                label: 'Plant ',
                                                hasError: controller
                                                    .hasEmailError.value,
                                                icon: null,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                onChanged:
                                                    controller.onEmailChanged,
                                                bOptional: true,
                                                placeholder: '',
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ))),
                          ),
                        )),
                    childCount: datas['panels']
                        .length, //item['settings']['title'] // Replace with your desired item count
                  ),
                ),
              ],
            ),
          ))
        : Container(
            height: 200,
            color: Colors.white,
            alignment: Alignment.center,
            child: DefaultTextStyle(
                style: TextStyle(decoration: TextDecoration.none),
                child: Text('Loading',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))));
  }

  justprint() {}
}
