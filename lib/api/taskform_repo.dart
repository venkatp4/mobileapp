import 'package:dio/dio.dart';

import 'api.dart';

class TaskFormRepo {
  const TaskFormRepo();

  static Future<Response> getDropDownValues(String sFormId, String payload) {
    print('getDropDownValues fffffffffffffffffffffffffffff');
    print(sFormId);
    print(payload);
    //http://52.172.32.88/eZenterpriseAPI/api/form/3065/uniqueColumnValues
    return Api().clientWithHeader().post<dynamic>(
        'form/' + sFormId + '/' + 'uniqueColumnValues',
        data: payload);
  }
}
