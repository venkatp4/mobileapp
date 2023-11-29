import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'api.dart';

class AuthRepo {
  const AuthRepo();

  static Future<Response> login(Map<String, String> payload, String sUserEmail) {
    print('login eeeeeeeeeeeeeeeeeeeeee ' + sUserEmail + '  ');
    print(payload);
    return Api().clientLogin(sUserEmail).post<dynamic>('/authentication/login', data: payload);
  }

  static Future<Response> getUserDetails() {
    return Api().clientWithHeader().get<dynamic>('/authentication/userSession');
  }

  //// tomorrow
  //https://stackoverflow.com/questions/72269997/dio-error-http-status-error-code-405-flutter

  static Future<Response> getInboxListForFolder(String sWorkflowId, String payload, String sType) {
    // debugPrint('getInboxListForFolder');
    // print(payload);

    switch (sType) {
      case '0':
        return Api()
            .clientWithHeader()
            .post<dynamic>('workflow/inboxList/' + sWorkflowId, data: payload);
        break;
      case '1':
        return Api()
            .clientWithHeader()
            .post<dynamic>('workflow/processList/' + sWorkflowId, data: payload);
        break;
      case '2':
        return Api()
            .clientWithHeader()
            .post<dynamic>('workflow/staredList/' + sWorkflowId, data: payload);
        break;
      case '3':
        return Api()
            .clientWithHeader()
            .post<dynamic>('workflow/completedList/' + sWorkflowId, data: payload);
        break;
    }

    return Api()
        .clientWithHeader()
        .post<dynamic>('workflow/inboxList/' + sWorkflowId, data: payload); //7  or 6
  }

  static Future<Response> getCommentsList(String sWorkflowId, String sFormEntryId) {
    print(' getCommentsList333'); //236  692 3352
    print(sFormEntryId);
    print(sWorkflowId);
    return Api()
        .clientWithHeader()
        .get<dynamic>('workflow/comments/' + sWorkflowId + '/' + sFormEntryId); //7  or 6
  }

  static Future<Response> getFileList(String sWorkflowId, String sFormId) {
    print(' attachmentList 4444444444444');
    print(sFormId);
    print(sWorkflowId);
    return Api()
        .clientWithHeader()
        .get<dynamic>('workflow/attachmentList/' + sWorkflowId + '/' + sFormId); //7  or 6
  }

  static Future<Response> getHistoryList(String sWorkflowId, String sFormEntryId) {
    print('getHistoryList ');
    print(sFormEntryId);
    print(sWorkflowId);
    return Api()
        .clientWithHeader()
        .get<dynamic>('workflow/processHistory/' + sWorkflowId + '/' + sFormEntryId); //7  or 6
  }

/*  static Future<Response> getTaskList(String sWorkflowId, String sFormId) {
    print('fffffffffffuuuuuuuuuuuupayload attachmentList');
    print(sWorkflowId + '/' + sFormId);
    print(sWorkflowId);
    return Api().clientWithHeader().get<dynamic>(
        'workflow/taskList/' + sWorkflowId + '/' + sFormId); //7  or 6
  }*/

  static Future<Response> getTaskList(String sWorkflowId, String sFormId, String payload) {
    print('12kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print(sWorkflowId + '/' + sFormId);
    print(payload);
    return Api()
        .clientWithHeader()
        .post<dynamic>('workflow/taskList/' + sWorkflowId + '/' + sFormId, data: payload);
  }

  static Future<Response> postDeleteFiles(String sRepositoryId, String sFileId) {
    print('12kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print(sRepositoryId + '/' + sFileId);
    // print(payload);
    return Api()
        .clientWithHeader()
        .post<dynamic>('menu/file/delete/' + sRepositoryId + '/' + sFileId);
  }

  static Future<Response> getUserList(String payload) {
    print('getUserList');

    print(payload);

    return Api().clientWithHeader().post<dynamic>('user/list', data: payload);
  }

  static Future<Response> getInboxSingleDetails(String sInboxID) {
    print('uuuuuuuuuuuu');
    print(sInboxID);
    return Api().clientWithHeader().get<dynamic>(
          'form/' + sInboxID,
        );
  }

  static Future<Response> postComments(
      String sWorkflowId, String sProcessId, String sTransactionId, String payload) {
    print('postComments');

    print(payload);

    return Api().clientWithHeader().post<dynamic>(
        'workflow/comments/' + sWorkflowId + '/' + sProcessId + '/' + sTransactionId,
        data: payload);
  }

  static Future<Response> postAttachment(FormData payload) {
    print('postComments');

    print(payload);

    return Api()
        .clientWithHeaderFile()
        .post<dynamic>('workflow/attachmentWithProcessId', data: payload);
  }

  static Future<Response> getTotalInboxCount() {
    return Api().clientWithHeader().get<dynamic>('workflow/myInboxCount');
  }
}
