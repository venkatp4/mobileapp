import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api.dart';

class AuthRepo {
  const AuthRepo();

  static Future<Response> login(Map<String, String> payload) {
    return Api().client().post<dynamic>('/authentication/login', data: payload);
  }

  static Future<Response> getUserDetails() {
    return Api().clientWithHeader().get<dynamic>(
          '/authentication/userSession',
          /*options: Options(
          headers: {
            "Authorization":
                "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsInRlbmFudElkIjoxLCJsb2dnZWRGcm9tIjoiTU9CSUxFIn0.m6mBJ8oHH21J4omkr2GXTA5yoLZ99t8Vec897NEs0cY",
          },
        )*/
        );
  }

  //// tomorrow
  //https://stackoverflow.com/questions/72269997/dio-error-http-status-error-code-405-flutter

  static Future<Response> getInboxListForFolder(
      String sWorkflowId, String payload) {
    debugPrint('hhhhhffffffffffffffffffwww');
    print('uuuuuuuuuuuupayload');
    print(payload);
    return Api().clientWithHeader().post<dynamic>(
        'workflow/inboxList/' + sWorkflowId,
        data: payload); //7  or 6
  }

  static Future<Response> getCommentsList(String sWorkflowId, String sFormId) {
    print('uuuuuuuuuuuupayload getCommentsList');
    print(sFormId);
    print(sWorkflowId);
    return Api().clientWithHeader().get<dynamic>(
        'workflow/comments/' + sWorkflowId + '/' + sFormId); //7  or 6
  }

  static Future<Response> getFileList(String sWorkflowId, String sFormId) {
    print('uuuuuuuuuuuupayload attachmentList');
    print(sFormId);
    print(sWorkflowId);
    return Api().clientWithHeader().get<dynamic>(
        'workflow/attachmentList/' + sWorkflowId + '/' + sFormId); //7  or 6
  }

  static Future<Response> getHistoryList(String sWorkflowId, String sFormId) {
    print('uuuuuuuuuuuupayload attachmentList');
    print(sFormId);
    print(sWorkflowId);
    return Api().clientWithHeader().get<dynamic>(
        'workflow/processHistory/' + sWorkflowId + '/' + sFormId); //7  or 6
  }

/*  static Future<Response> getTaskList(String sWorkflowId, String sFormId) {
    print('fffffffffffuuuuuuuuuuuupayload attachmentList');
    print(sWorkflowId + '/' + sFormId);
    print(sWorkflowId);
    return Api().clientWithHeader().get<dynamic>(
        'workflow/taskList/' + sWorkflowId + '/' + sFormId); //7  or 6
  }*/

  static Future<Response> getTaskList(
      String sWorkflowId, String sFormId, String payload) {
    print('12kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print(sWorkflowId + '/' + sFormId);
    print(payload);
    return Api().clientWithHeader().post<dynamic>(
        'workflow/taskList/' + sWorkflowId + '/' + sFormId,
        data: payload);
  }

  static Future<Response> getInboxSingleDetails(String sInboxID) {
    print('uuuuuuuuuuuu');
    print(sInboxID);
    return Api().clientWithHeader().get<dynamic>(
          'form/' + sInboxID,
        );
  }
}
