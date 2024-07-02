import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constantsColor.dart';
import '../../../../core/constants/constantsStringApp.dart';
import '../../../../core/widgetsApp/TextFiledCustom.dart';
import '../../../../core/widgetsApp/widget_button.dart';
import '../../data_layer/models/project.dart';
import '../provider/project.dart';

class CreateProject extends StatelessWidget {
final TextEditingController _projectNameController=TextEditingController();
final TextEditingController _projectScriptController=TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: darkBlue,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10,),
              Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  width: 100,
                  child: Image.asset("images/bigBear.png")
              ),
              TextFiledCustom(30,projectName,white ,white,2,_projectNameController),
              const SizedBox(height: 50,),
              TextFiledCustom(30,projectScript,white,white,28,_projectScriptController),
              Consumer(
                builder: (context, ref, child) {
                return  ButtonCustom(280, 54, ref.watch(project).when(
                  data:(_)=> Text(createProject,style: TextStyle(fontSize: 30,color: darkBlue),),
                  error: (error, _) => Text('Error: $error'),
                  loading:()=>CupertinoActivityIndicator(color: lightGreen,)),
                   lightYellow, darkBlue, () async{
                    formKey.currentState!.save();
                    ProjectModel createProject=ProjectModel(projectName:_projectNameController.text ,projectDescription:_projectScriptController.text ,projectStatus: "");
                    ref.read(project.notifier).createProject(createProject).then((value) => Navigator.pushNamed(context, '/AddTask'));
                  }
                 );
               },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
