import 'package:ez/core/ApiClient/ApiService.dart';
import 'package:ez/features/workflow/repository/repo_impl.dart';
import 'package:ez/features/workflow/repository/repository.dart';
import 'package:ez/features/workflow/view/workflow.dart';
import 'package:ez/features/workflow/view_model/viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.asNewInstance();

setupLazySingleton() {
  //Workflow Component
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<FileManager>(() => FileManager(sl()));
  sl.registerLazySingleton<WorkflowRepo>(() => WorkflowRepoImpl(sl()));
  sl.registerLazySingleton<WorkflowViewModel>(() => WorkflowViewModel(sl()));
}
