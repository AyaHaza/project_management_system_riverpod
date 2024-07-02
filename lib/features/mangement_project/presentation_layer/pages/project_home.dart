import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constantsColor.dart';
import '../../../../core/constants/constantsStringApp.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../core/resource/data_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../authentection/presentation_layer/provider/auth_provider.dart';
import '../../../mangement_task/presentation_layer/riverpod/mangement_task_riverpod.dart';
import '../provider/project.dart';


class ProjectHome extends StatelessWidget {
  final ValueNotifier<dynamic> deleteProject=ValueNotifier(SizedBox());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: lightGreen,
        child: Icon(Icons.dataset_linked_outlined,color: darkBlue,),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('project name'),
        backgroundColor: lightGreen,
        actions: [
          DropdownButtonHideUnderline(
            child: StatefulBuilder(
              builder: (context, setState) {
                return  ValueListenableBuilder(
                    valueListenable: deleteProject,
                    builder: (context, value, child) {
                      return DropdownButton2<String>(
                        // isExpanded: true,
                        items: options
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selected = value;
                          });print(selected);
                          if(selected=="Delete"){
                            deleteProject.value=showDialog(context: context, builder: (m) {
                              return AlertDialog(
                                backgroundColor: red,
                                shape: RoundedRectangleBorder(
                                  borderRadius:BorderRadius.circular(20) ,),
                                title: Container(
                                  height: 140,
                                  width: 180,
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(alignment:Alignment.centerLeft,child: Text(sureDelete)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 33.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Consumer(builder: (context, ref, child) {
                                              return TextButton(onPressed: (){
                                                ref.read(project.notifier).deleteProject().then((value) => Navigator.pushNamed(context, '/Create&Join'));
                                              },style:TextButton.styleFrom(
                                                  backgroundColor: grey,
                                                  fixedSize: Size(90, 30),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(6))), child:
                                              ref.watch(project).when(
                                                  data:(_)=>Text(iAmSure,style:TextStyle(color: white),),
                                                  error: (error, _) => Text('Error: $error'),
                                                  loading:()=>CupertinoActivityIndicator(color: red,))

                                              );
                                            },),
                                            TextButton(onPressed: (){
                                              Navigator.of(m).pop();
                                            }, child: Text(cancel,style:TextStyle(color: Colors.black),)),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            );
                          }
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 90,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(Icons.settings,color: darkBlue,),
                          iconSize: 22,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color:white,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      );
                    }
                );
              },
            ),
          )
        ],
        iconTheme: IconThemeData(color:darkBlue),
      ),
      drawer: Drawer(backgroundColor: lightGreen,child:
      Consumer(
        builder: (context, ref, child) {
          return ref.watch(Auth).when(
              data: (_)=>IconButton(onPressed: (){
                 ref.read(Auth.notifier).logout().then((value) => Navigator.pushNamed(context, '/register'));
                },
              icon: Icon(Icons.logout_outlined)),
              error: (error, _) => Text('Error: $error'),
              loading:()=>CupertinoActivityIndicator());
        },
      )
        ,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: darkBlue,
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              height: 280,
              width: 360,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lightYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child:Consumer(
                builder: (context, ref, _) {
                  return ref.watch(getData).when(
                    data: (data) {
                      if(data is SuccessState){
                        return Text(data.getdata.description,style: TextStyle(color: darkBlue,fontSize: 18),);
                      }return SizedBox();
                    },
                    error: (error, stackTrace) {
                      return Text("There is An Error");
                    },
                    loading: () {
                      return Center(
                        child: CupertinoActivityIndicator(color: lightGreen,),
                      );
                    },
                  );
                },
              ),
            ),
              SizedBox(height: 40,),
            Container(
              height: 450,
              width: 400,
              child:
              Consumer(
               builder: (context, ref, child) {
                 return ref.watch(getTaskData).when(
                   data: (data) {
                     if(data is SuccessStateList){
                       return   ListView.builder(
                         itemCount: data.getdata.length,
                         itemBuilder:(context, index) {
                           return Container(
                             margin: EdgeInsets.only(bottom: 10,right: 270,left: 26),
                             height: 96,
                             decoration: BoxDecoration(
                                 color: lightPurple,
                                 borderRadius: BorderRadius.circular(10)
                             ),
                             child: Container(
                               margin: EdgeInsets.only(left: 6,right: 6,top: 26,bottom: 6),
                               padding: EdgeInsets.symmetric(horizontal: 10),
                               decoration: BoxDecoration(
                                   color: white,
                                   borderRadius: BorderRadius.circular(10)
                               ),
                               child: Align(alignment:Alignment.centerLeft,child: Text(data.getdata[index].taskDescription)),
                             ),
                           );
                         },
                       );
                       ;
                     }return SizedBox();
                   },
                   error: (error, _) {
                     return Text('Error: $error');
                   },
                   loading: () {
                     return Center(
                       child: CupertinoActivityIndicator(color: lightGreen,),
                     );
                   },
                 );},
              )
            )
          ],
        )
      ),
    );
  }
}
