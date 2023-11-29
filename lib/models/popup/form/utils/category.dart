import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/Labels.dart';
import '../components/check_box_input.dart';
import '../components/date_input.dart';
import '../components/datetime_input.dart';
import '../components/divider.dart';
import '../components/dropdown_main.dart';
import '../components/dropdown_main_api.dart';
import '../components/formbutton.dart';
import '../components/number_increment.dart';
import '../components/radio_button_input.dart';
import '../components/text_input.dart';
import '../components/time_input.dart';
import '../controllers/panel_controller.dart';

class Category {
  //Map mdataGenerate = Map<String, dynamic>();
  Map datas = Map<String, dynamic>();
  Widget child = Container();
  final controller = Get.put(PanelController());
  String sFormId = '3042';

  static List<Widget> getWidget(Map<dynamic, dynamic> data) {
    List<Widget> list = [];
    try {
      Map<dynamic, dynamic> datas = json.decode(data['formJson']);
      for (int i = 0; i < datas['panels'].length; i++) {
        print(datas['panels'][i]['settings']['title'].toString());
        list.add(Container(
            // color: Color(0xFFcbd5e1),
            padding: EdgeInsets.all(10),
            child: Text(
              datas['panels'][i]['settings']['title'].toString(),
              /*style: const TextStyle(
                    color: Color(0xFF643094), fontSize: 16, fontWeight: FontWeight.bold)*/
            )));
      }
    } catch (e, _) {
      debugPrint(e.toString());
    }
    return list;
  }

  List<Widget> getContentList(Map<dynamic, dynamic> data, BuildContext context) {
    // final controller = Get.put(PanelController());
    List<Widget> list = [];
    try {
      print('bbbbbbbbbbbbbbbbb');
      datas = json.decode(data['formJson']);
      for (int i = 0; i < datas['panels'].length; i++) {
        print(datas['panels'][i]['settings']['title'].toString());
        list.add(Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: datas['panels'][i]['fields'].length + 1,
            itemBuilder: (BuildContext context, int indexwidget) {
              return Container(
                  color: Colors.yellow,
                  child: Column(
                    //physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        height: 15,
                        color: Colors.red,
                        padding: EdgeInsets.all(2),
                      ),
                      indexwidget != datas['panels'][i]['fields'].length
                          ? loadWidgets(i, indexwidget,
                              datas['panels'][i]['fields'][indexwidget]['type'], datas)
                          : Container(),
                    ],
                  ));
            },
          ),
        ));
      }
    } catch (e, _) {
      debugPrint(e.toString());
    }
    return list;
  }

  Widget loadWidgets(int iPanel, int indexwidget, String widgetType, Map<dynamic, dynamic> datas) {
    print(indexwidget);
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
      case 'NUMBER':
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
      case 'INCREMENT COUNTER': // 'NUMBER'
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
      case 'SINGLE_CHOICE':
        print('sssssssssssssssssss');
        print(datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                ['customOptions']
            .toString()
            .split(','));
        print(datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                ['customOptions']
            .toString()
            .split(',')[0]);
        print(datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                ['customOptions']
            .toString()
            .split(',')[0]);
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Labels(
                sLabel: widgetType + ' ' + datas['panels'][iPanel]['fields'][indexwidget]['label'],
                bRequired: false),
            RadioButtonInput(
              initialValue: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                      ['customOptions']
                  .toString()
                  .split(',')[0],
              isDisabled: false,
              options: datas['panels'][iPanel]['fields'][indexwidget]['settings']['specific']
                      ['customOptions']
                  .toString()
                  .split(','),
              onChanged: (value) => controller.onFormFieldChanged(value, controller.Initial),
            )
          ],
        );
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
      controller.getDropDownValues(sFormId, datas['panels'][iPanel]['fields'][indexwidget]['id'],
          iPanel, indexwidget, false);
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
}
