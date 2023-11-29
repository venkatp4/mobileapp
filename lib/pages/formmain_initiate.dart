import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../api/auth_repo.dart';
import '../../../controllers/browse_view_controller.dart';
import '../../../utils/helper/aes_encryption.dart';

import '../models/popup/controllers/popupfullpagecontroller.dart';
import '../models/popup/form/controllers/panel_controller.dart';
import '../models/popup/form/components/Labels.dart';
import '../models/popup/form/components/bottomup_table.dart';
import '../models/popup/form/components/check_box_input.dart';
import '../models/popup/form/components/date_input.dart';
import '../models/popup/form/components/datetime_input.dart';
import '../models/popup/form/components/divider.dart';
import '../models/popup/form/components/dropdown_main.dart';
import '../models/popup/form/components/dropdown_main_api.dart';
import '../models/popup/form/components/formbutton.dart';
import '../models/popup/form/components/number_increment.dart';
import '../models/popup/form/components/panel.dart';
import '../models/popup/form/components/text_input.dart';
import '../models/popup/form/components/textbold.dart';
import '../models/popup/form/components/textnormal.dart';
import '../models/popup/form/components/time_input.dart';

class FormMainInitiate extends StatefulWidget {
  FormMainInitiateState createState() => FormMainInitiateState();
}

class FormMainInitiateState extends State<FormMainInitiate> {
  final isLoading = false.obs;
  final error = ''.obs;

  Widget child = Container();

  Map mdataGenerate = Map<String, dynamic>();
  Map datas = Map<String, dynamic>();
  final controller = Get.put(PanelController());
  final controllerpopup = Get.put(PopupFullPageController());

//479
/*  List<dynamic> datadrop =List.empty();
  List<String> datadropString =List.empty();*/
  // String sFormId = '2039'; //3061-card 23  27s 3065 4071-CLASSIC 3042-card 3043 -card  3044 -table

  @override
  void initState() {
    print('888iiiiiiiiiiiiiiiiiiiiiiiiiiiii888 initiate');
    super.initState();
    print('fffffff ' + controller.sFormId);
    print('fffffff2 ' + controller.formbuttonList.toString());
    getComponentDetails(controller.sFormId); //3061 23  27s 3065  3040-table
  }

  Future getComponentDetails(String formId) async {
    print('getComponentDetails 888iiiiiiiiiiiiiiiiiiiiiiiiiiiii888ffff');
    isLoading.value = true;

    error.value = '';
    try {
      final response = await AuthRepo.getInboxSingleDetails(formId); //23 formids

      Map<String, dynamic> data = jsonDecode(AaaEncryption.decryptAESaaa(response.data));
      setState(() {
        isLoading.value = false;
        mdataGenerate = data;
        datas = json.decode(data['formJson']);
        /*print('99999999999999999999999999999999999999999991');
        print(mdataGenerate['layout'].toString());*/
      });

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
    print('888iiiiiiiiiiiiiiiiiiiiiiiiiiiii888bbbbwe');
    return isLoading.isFalse
        ? /*mdataGenerate['layout'].toString() == 'CLASSIC'
            ?*/
        Scaffold(
            body: Container(
              color: Color.fromRGBO(240, 245, 249, 1), //rgb(240 245 249)
              // margin: EdgeInsets.all(5),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      backgroundColor: Colors.white,
                      pinned: true,
                      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Textbold(sLabel: mdataGenerate['name'].toString()),
                        /*   mdataGenerate['description'].toString().length > 0
                          ? TextNormal(sLabel: mdataGenerate['description'].toString())
                          : Container(),*/
                      ])),
                  //Container(child: TabMain()),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                                          sVisible: true,
                                          sHeading: '${datas['panels'][index]['settings']['title']}'
                                                  .toString() +
                                              "  " +
                                              mdataGenerate['layout'].toString(),
                                          sDescription:
                                              '${datas['panels'][index]['settings']['description']}'
                                                  .toString()))
                                  : Container(),
                              content: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Container(
                                      // margin: EdgeInsets.only(bottom: 10),
                                      //  color: Colors.lightBlueAccent,
                                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      margin: EdgeInsets.only(top: 0, bottom: 10),
                                      child: Expanded(
                                          child: MediaQuery.removePadding(
                                              context: context,
                                              removeTop: true,
                                              child: GridView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: datas['panels'][index]['fields'].length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisSpacing: 1.0,
                                                        crossAxisCount:
                                                            (MediaQuery.of(context)
                                                                        .orientation ==
                                                                    Orientation.portrait)
                                                                ? 1
                                                                : 2,
                                                        childAspectRatio: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            (MediaQuery.of(context).size.height /
                                                                8)),
                                                itemBuilder:
                                                    (BuildContext context, int indexwidget) {
                                                  return Container(
                                                      // color: Colors.yellow, 3750 tif unproce
                                                      //margin: EdgeInsets.all(1),
                                                      child: ListView(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    // 126 111 103  63.2/57    25/22.5
                                                    children: [
                                                      loadWidgets(
                                                          index,
                                                          indexwidget,
                                                          datas['panels'][index]['fields']
                                                              [indexwidget]['type']),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ));
                                                },
                                              ))),
                                    ),
/*                                    mdataGenerate['layout'].toString() == 'CLASSIC'
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(0, 1, 10, 1),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () => {},
                                                    child: new Text('Previous',
                                                        style: const TextStyle(
                                                            color: Color(0xFF643094),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context).pop(false),
                                                    child: FormButton(
                                                      isRounded: false,
                                                      isFullWidth: true,
                                                      label: 'Next',
                                                      isLoading: controller.isLoading.value,
                                                      onPressed: controller.login,
                                                    ),
                                                  )
                                                ]))
                                        : Container()*/
                                  ]))),
                      childCount: datas['panels']
                          .length, //item['settings']['title'] // Replace with your desired item count
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
                padding: EdgeInsets.fromLTRB(0, 1, 10, 1),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: FormButton(
                      isRounded: false,
                      isFullWidth: true,
                      label: 'Submit',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.login,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: FormButton(
                      isRounded: false,
                      isFullWidth: true,
                      label: 'Save',
                      isLoading: controller.isLoading.value,
                      onPressed: controller.login,
                    ),
                  ),
                ])))
        : Container(
            //
            height: 200,
            color: Colors.white,
            alignment: Alignment.center,
            child: DefaultTextStyle(
                style: TextStyle(decoration: TextDecoration.none),
                child: Text('Loading',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))));
  }

  Widget loadWidgets(int iPanel, int indexwidget, String widgetType) {
    print(datas['panels'][iPanel]['fields'][indexwidget]['label'] + " ==  " + widgetType);
/*    print(datas['panels'][iPanel]['fields'][indexwidget]['settings']
        ['validation']['fieldRule']);
    print(datas['panels'][iPanel]['fields'][indexwidget]['settings']
        ['validation']['contentRule']);
    print('-------------------------------------');*/
    Widget child = Container();
    switch (widgetType) {
      case 'LABEL':
        child = Container(
            //color: Colors.red,
            child: Labels(
                sLabel: datas['panels'][iPanel]['fields'][indexwidget]['label'], bRequired: false));
        break;
      case 'DIVIDER':
//        child = Divider(color: Colors.grey.shade300);s
        child = Dividers(
            sType: datas['panels'][iPanel]['fields'][indexwidget] //26 - 11,
                ['settings']['general']['dividerType']);
        break;
      case 'SHORT_TEXT':
        child = TextInput(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          hasError: controller.hasTextError.value,
          icon: null,
          keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
              ['validation']['contentRule']),
          onChanged: controller.onTextChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
        );
        break;
      case 'COUNTER':
        child = NumberInput(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          hasError: controller.hasNumberError.value,
          icon: null,
          keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
              ['validation']['contentRule']),
          onChanged: controller.onNumberChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
        );
        break;
      case 'NUMBER': // 'NUMBER'
        child = TextInput(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          hasError: controller.hasNumberError.value,
          icon: null,
          keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
              ['validation']['contentRule']),
          onChanged: controller.onNumberChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
        );
        break;
      case 'LONG_TEXT':
        child = TextInput(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          hasError: controller.hasMultiLineError.value,
          icon: null,
          keyboardType: TextInputType.multiline,
          onChanged: controller.onMultilineChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
          maxLines: 2,
        );
        break;

      //Date Time Components
      case 'DATE':
        child = DateTimeInput(
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          isDisabled: true,
          onChangedDate: (value) => controller.ondateandtime_DateChanged,
          onChangedTime: (value) => controller.ondateandtime_TimeChanged,
          placeholder: datas['panels'][iPanel]['fields'][indexwidget] //26 - 11,
              ['settings']['general']['placeholder'],
          // datas['panels'][iPanel]['fields'][indexwidget]['general']            ['placeholder']
        );
        break;
      case 'DATETIME':
        child = DateInput(
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          isDisabled: true,
          onChanged: (value) => controller.onDateChanged,
          placeholder: datas['panels'][iPanel]['fields'][indexwidget]['settings']['general']
              ['placeholder'],
          // datas['panels'][iPanel]['fields'][indexwidget]['general']            ['placeholder']
        );
        break;

      case 'TIME':
        child = TimeInput(
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          isDisabled: true,
          onChanged: (value) => controller.onDateChanged,
          placeholder: datas['panels'][iPanel]['fields'][indexwidget]['settings']['general']
              ['placeholder'],
          // datas['panels'][iPanel]['fields'][indexwidget]['general']            ['placeholder']
        );
        break;
      // Option - DropDown
      case 'SINGLE_SELECT':
        print('sssssssssssssssssssssssss');
        print(
            datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']['optionsType']);
        child = DropdownOptions(iPanel, indexwidget);
        break;
      case 'MULTIPLE_CHOICE':
        print('MULTIPLE_CHOICE');
        child = CheckBoxInput(
          initialValue: '',
          //controller.formFieldsModel[field.name],
          isDisabled: false,
          // controller.activeTab != 'Inbox',
          options: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                  ['customOptions']
              .toString()
              .split(','),
          //field.options.split(','),
          slabel: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] !=
              'REQUIRED',
          onChanged: (value) => controller.onFormFieldChanged(
              value.join(','), datas['panels'][iPanel]['fields'][indexwidget]['label']),
        );
        break;
      case 'TABLE':
        child = BottomUpTable();
        break;

      default:
        child = Container(
            child: Labels(
                sLabel: widgetType + ' ' + datas['panels'][iPanel]['fields'][indexwidget]['label'],
                bRequired: false));
        break;
    }
    return child;
  }

  //dropdown Options
  Widget DropdownOptions(
    int iPanel,
    int indexwidget,
  ) {
    //finny
    child = Container();
/*    print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    print(datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
        ['optionsType']);
    print(datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
        ['allowToAddNewOptions']);*/

    if (datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']['optionsType'] ==
        'CUSTOM') {
      child = DropDownMain(
        borderColor: const Color(0xFFE0E0E0),
        initialValue: '',
        label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
        sColumnName: datas['panels'][iPanel]['fields'][indexwidget]['id'],
        hasError: controller.hasNumberError.value,
        icon: null,
        keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
            ['validation']['contentRule']),
        onChanged: controller.onNumberChanged,
        bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                ['fieldRule'] ==
            'REQUIRED',
        placeholder: '',
        sInputs: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
            ['customOptions'],
        sInputSeperator: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
            ['separateOptionsUsing'],
        sDropDownType: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
            ['optionsType'],
      );
    }

    if (datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']['optionsType'] ==
            'EXISTING' &&
        !datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
            ['allowToAddNewOptions']) {
      controller.getDropDownValues(controller.sFormId,
          datas['panels'][iPanel]['fields'][indexwidget]['id'], iPanel, indexwidget, false);
      child = DropDownMainAPI(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          sColumnName: datas['panels'][iPanel]['fields'][indexwidget]['id'],
          hasError: controller.hasNumberError.value,
          icon: null,
          keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
              ['validation']['contentRule']),
          onChanged: controller.onNumberChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
          /*  sInputs: datas['panels'][iPanel]['fields'][indexwidget]['settings']
            ['specific']['customOptions'],*/
          sInputs: controller.datadropString,
          sInputSeperator: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
              ['separateOptionsUsing'],
          sDropDownType: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
              ['optionsType']); //125 110 102 332
    }
/////////////////////////// with textfield
    if (datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']['optionsType'] ==
            'EXISTING' &&
        datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
            ['allowToAddNewOptions']) {
/*      controller.getDropDownValues(sFormId,datas['panels'][iPanel]['fields'][indexwidget]['id'],
          iPanel, indexwidget, true);*/
      child = DropDownMainAPI(
          borderColor: const Color(0xFFE0E0E0),
          initialValue: '',
          label: datas['panels'][iPanel]['fields'][indexwidget]['label'],
          sColumnName: datas['panels'][iPanel]['fields'][indexwidget]['id'],
          hasError: controller.hasNumberError.value,
          icon: null,
          keyboardType: getInputType(datas['panels'][iPanel]['fields'][indexwidget]['settings']
              ['validation']['contentRule']),
          onChanged: controller.onNumberChanged,
          bOptional: datas['panels'][iPanel]['fields'][indexwidget]['settings']['validation']
                  ['fieldRule'] ==
              'REQUIRED',
          placeholder: '',
          sInputs: controller.datadropString,
          sInputSeperator: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
              ['separateOptionsUsing'],
          sDropDownType: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
              ['optionsType']);
    }
    return child;
  }

/*  Future getDropDownValues(
      String columnId, int iPanel, int indexwidget, bool bTextField) async {
    try {
      // columnId = 'JghKAtOm3pRdVcOJp0bZt';
      final payload = {
        'column': columnId,
        'keyword': '',
        'rowFrom': 0,
        'rowTo': 0
      };

      final response = await TaskFormRepo.getDropDownValues(
          sFormId,
          jsonEncode(
              AaaEncryption.EncryptDatatest(jsonEncode(payload)))); //23 formid
      var temp = jsonDecode(AaaEncryption.decryptAESaaa(response.data))
          as List<dynamic>;
     // setState(() {
        if (temp.length > 0) {
          controller.temp.clear();
          controller.datadropString.clear();
          // For show Textfield
          if (bTextField) {
            controller.temp.add('');//tbx152015
          }
          // add data from api call
          for (int i = 0; i < temp.length; i++) {
            controller.temp.add(temp[i].toString());
          }
          controller.datadropString = controller.temp;
        }
        setState(() {
          controller.datadropString = controller.temp;
        });
    //  });
      print(controller.datadropString.toString());
      print(controller.datadropString.length);
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
    } finally {}
  }*/

/*  Future<List<String>> getDropDownValues(
      String columnId, int iPanel, int indexwidget, bool bTextField) async {
    try {
      // columnId = 'JghKAtOm3pRdVcOJp0bZt';
      final payload = {
        'column': columnId,
        'keyword': '',
        'rowFrom': 0,
        'rowTo': 0
      };

      final response = await TaskFormRepo.getDropDownValues(
          sFormId,
          jsonEncode(
              AaaEncryption.EncryptDatatest(jsonEncode(payload)))); //23 formid
      var temp = jsonDecode(AaaEncryption.decryptAESaaa(response.data))
      as List<dynamic>;
      // setState(() {
      if (temp.length > 0) {
        controller.temp.clear();
        controller.datadropString.clear();
        // For show Textfield
        if (bTextField) {
          controller.temp.add('');//tbx152015
        }
        // add data from api call
        for (int i = 0; i < temp.length; i++) {
          controller.temp.add(temp[i].toString());
        }
        controller.datadropString = controller.temp;

       // final data = jsonDecode(response.body);
        return List<String>.from(temp);
      }
      setState(() {
        controller.datadropString = controller.temp;
      });
      //  });
      print(controller.datadropString.toString());
      print(controller.datadropString.length);
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load data from API 1');
        throw 'invalid status code';
      }
    } on DioError catch (e) {
      throw Exception('Failed to load data from API 1');
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
      throw Exception('Failed to load data from API 1');
    } finally { throw Exception('Failed to load data from API 1');}
  }*/

  //TextInputType
  TextInputType getInputType(String sKeyboardType) {
    TextInputType keyboardType = TextInputType.text;
    print('++++==================');
    print(sKeyboardType);
    switch (sKeyboardType) {
      case 'TEXT':
        keyboardType = TextInputType.text;
        break;
      case 'DECIMAL':
        keyboardType = TextInputType.number;
        break;
      case 'EMAIL':
        keyboardType = TextInputType.emailAddress;
        break;
      case 'NAME':
        keyboardType = TextInputType.name;
        break;
    }
    /* print(keyboardType);
    print('++++1==================');*/
    return keyboardType;
  }

/*  void loadvaliurofItems() {
    var items = [''];
    switch (widget.sInputSeperator) {
      case 'NEWLINE':
        items = widget.sInput.split('\n');
        break;
      case 'COMMA':
        items = widget.sInput.split(',');
        break;
    }
  }*/

  Future<bool> _onWillPop() async {
    final cont = Get.put(BrowseViewController());
/*    if (iCurrentSelect != 'Open') {
      setState(() {
        iCurrentSelect = 'Open'.obs;
      });
    } else*/
    cont.tabFunction(1);
    return true;
  }
}
