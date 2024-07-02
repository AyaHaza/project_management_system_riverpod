import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constantsColor.dart';
import '../../../../core/constants/constantsStringApp.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../core/widgetsApp/TextFiledCustom.dart';
import '../../../../core/widgetsApp/widget_button.dart';
import '../../data_layer/models/task.dart';
import '../riverpod/list_task_riverpod.dart';
import '../riverpod/mangement_task_riverpod.dart';


class AddTask extends StatelessWidget {
  final TextEditingController _nameTaskController=TextEditingController();
  final ValueNotifier<dynamic> addTasks=ValueNotifier(SizedBox());
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(idProject);
    return Scaffold(
      body: Consumer(
        builder: (context,ref,_) {
          final listReadRiverpod=ref.read(ListTaskProvider);
          final listWatchRiverpod = ref.watch(ListTaskProvider);
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: darkBlue,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          alignment: Alignment.topLeft,
                          height: 100,
                          width: 100,
                          child: Image.asset("images/bigBear.png")
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0,top: 12),
                        child: Text(taskss,style: TextStyle(color: white,fontSize: 26,),),
                      ),
                      Center(
                        child: Container(
                          width: 400,
                          height: 618,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 618,
                                width: 310,
                                child:
                                  ListView.builder(
                                    itemCount: listWatchRiverpod.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key: GlobalKey(),
                                        onDismissed: (direction){

                                          listReadRiverpod.removeAt(index);
                                          ref.watch(ListTaskProvider.notifier).state=[...listReadRiverpod];
                                          print(listReadRiverpod);
                                        },
                                        background: Container(
                                          decoration: BoxDecoration(
                                            color: red,
                                            borderRadius: BorderRadius.circular(10)
                                        ),),
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          width: 310,
                                          height: 86,
                                          decoration: BoxDecoration(
                                              color: lightPurple,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10,left: 20,right: 20,top: 20),
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Align(alignment:Alignment.centerLeft,child: Text(listWatchRiverpod[index])),
                                          ),
                                        ),
                                      );
                                    },
                                  ),),
                              ValueListenableBuilder(
                                valueListenable: addTasks,
                                builder: (context, value, child) {
                                  return
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: white
                                    ),
                                    child: IconButton(
                                        onPressed: (){
                                          addTasks.value=showDialog(context: context, builder: (m) {
                                            return AlertDialog(
                                              backgroundColor: lightPurple,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:BorderRadius.circular(20) ,),
                                              title: TextFiledCustom(10, taskDescription, white, darkBlue, 3, _nameTaskController),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(m).pop();
                                                }, child: Text(cancel,style:TextStyle(color: darkBlue),),),
                                               TextButton(onPressed: ()async{
                                                 listReadRiverpod.add(_nameTaskController.text);
                                                 print(listReadRiverpod);
                                                  ref.watch(ListTaskProvider.notifier).state=[...listReadRiverpod];
                                                 Navigator.of(m).pop();
                                               }, child: Text(add,style:TextStyle(color: darkBlue),))
                                              ],
                                            );
                                          },);
                                        },
                                        icon: Icon(Icons.add,size: 26,)
                                    ),
                                  ) ;
                                 },
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: darkBlue,
                              blurRadius: 40,
                              spreadRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ]
                        ),
                        child: ButtonCustom(280, 54,
                          ref.watch(task).when(
                              data:(_)=> Text(createProject,style: TextStyle(fontSize: 30,color: darkBlue),),
                              error: (error, _) => Text('Error: $error'),
                              loading:()=>CupertinoActivityIndicator(color: lightGreen,)),
                          lightYellow, darkBlue, () async{
                            formKey.currentState!.save();
                            final List taskList =List.generate(listReadRiverpod.length, (int index) {
                              return TaskMosel(taskDescription: listReadRiverpod[index], taskStatus: 'NEW',projectId:idProject!);
                            });
                            print(taskList);
                            ref.read(task.notifier).createTask(taskList).then((value) => Navigator.pushReplacementNamed(context, '/ProjectHome'));
                          }
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
