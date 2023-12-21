import 'package:ez/features/workflow/repository/repository.dart';
import 'package:ez/features/workflowinitiate/repository/repository.dart';

import '../../../core/ApiClient/ApiService.dart';
import '../../workflow/model/Panel.dart';

class WorkflowInitiateRepoImpl implements WorkflowInitiateRepo {
  final FileManager apiService;

  WorkflowInitiateRepoImpl(this.apiService);

  @override
  Future<dynamic> getData() async {
    try {
      // Call the getUsers() method from the ApiService to fetch user data from the API.
      final data = await apiService.getData('assets/workflow_initiate1.json');
      // Map the API response data to a List of data objects using the User.fromJson() constructor.
      final result = Panel.fromJson(data);

      return result;
    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch users');
    }
  }
}
