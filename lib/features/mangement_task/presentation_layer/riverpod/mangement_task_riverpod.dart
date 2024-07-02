import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../injection_container.dart';
import '../../domain_layer/usecases/add_task.dart';
import '../../domain_layer/usecases/get_task.dart';

final getTaskData = FutureProvider<DataState>((ref) {
  return ref.read(task.notifier).getTask();
});

final task=StateNotifierProvider<MangementTaskNotifier,AsyncValue<bool>>((ref){
  return MangementTaskNotifier(sl(),sl());
});

class MangementTaskNotifier extends StateNotifier<AsyncValue<bool>>{
  final AddTaskUseCase _addTask;
  final GetTaskUseCase _getTask;
  MangementTaskNotifier(this._getTask,this._addTask) : super(AsyncValue.data(false));

  Future<bool> createTask(taskModel)async{
    state=AsyncValue.loading();
    await _addTask.call(taskModel);
    state =  AsyncValue.data(false);
    return true;
  }

  Future<DataState> getTask()async{
    var result=await _getTask.call(idProject!);
    if(result is SuccessStateList){
      return  result;
    }else{
      return ErrorState(error: result.toString());
    }
  }
}
