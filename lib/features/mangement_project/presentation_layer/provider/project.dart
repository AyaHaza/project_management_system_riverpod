import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../core/resource/data_state.dart';
import '../../../../injection_container.dart';
import '../../domain_layer/usecases/craete_project.dart';
import '../../domain_layer/usecases/delete_project.dart';
import '../../domain_layer/usecases/get_project.dart';

final getData = FutureProvider<DataState>((ref) {
  return ref.read(project.notifier).getProject();
});

final project=StateNotifierProvider<ProjectNotifier,AsyncValue<bool>>((ref){
  return ProjectNotifier(sl(),sl(),sl());
});

class ProjectNotifier extends StateNotifier<AsyncValue<bool>>{
  final CreateProjectUseCase _createProjectUseCase;
  final GetProjectUseCase _getProjectUseCase;
  final DeleteProjectUseCase _deleteProjectUseCase;
  ProjectNotifier(this._createProjectUseCase,this._getProjectUseCase,this._deleteProjectUseCase) : super(AsyncValue.data(false));

    Future<bool> createProject(projectModel)async{
      state=AsyncValue.loading();
      await _createProjectUseCase.call(projectModel);
      state =  AsyncValue.data(false);
      return true;
    }

    Future<DataState> getProject()async{
      var result=await _getProjectUseCase.call(idProject!);
      if(result is SuccessState){
        return result;
      }else{
        return ErrorState(error: result.toString());
      }
    }

    Future<bool> deleteProject()async{
      state=AsyncValue.loading();
      var result=await _deleteProjectUseCase.call(idProject!);
      if(result== true){
        state =  AsyncValue.data(false);
        return  true;
      }else{
        state =  AsyncValue.data(false);
        return false;
      }
    }
  }
