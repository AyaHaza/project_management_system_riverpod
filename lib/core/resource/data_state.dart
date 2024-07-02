

import '../../features/mangement_project/data_layer/models/get_project.dart';
import '../../features/mangement_task/data_layer/models/get_task.dart';

abstract class DataState{}

class SuccessState extends DataState{
  GetProjectMosel getdata;
  SuccessState({required this.getdata});
}

class SuccessStateList extends DataState{
  List<GetTasktMosel> getdata;
  SuccessStateList({required this.getdata});
}


class ErrorState extends DataState{
  String error;
  ErrorState({required this.error});
}