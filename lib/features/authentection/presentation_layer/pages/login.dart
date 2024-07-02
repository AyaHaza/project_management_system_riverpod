import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constantsColor.dart';
import '../../../../core/constants/constantsStringApp.dart';
import '../../../../core/widgetsApp/widget_button.dart';
import '../../data_layer/models/user.dart';
import '../provider/auth_provider.dart';
import '../widgets/build_container_body_login.dart';
import '../widgets/build_image_widget.dart';

class Login extends StatelessWidget {
  final TextEditingController _email=TextEditingController();
  final TextEditingController _pass=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final bool value = false;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> valueNotifier=ValueNotifier(this.value);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: darkBlue,
        child: Form(
          key: formKey,
          child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 118.0),
                  child: Stack(
                    children: [
                      buildContanerBody(valueNotifier,this.value,_email,_pass),
                      buildImage(),
                    ],
                  ),
                ),
                Consumer(builder: (context, ref, child) {
                  return  ButtonCustom(280, 54, ref.watch(Auth).when(
                        data:(_)=>Text(login,style: TextStyle(fontSize: 30,color: darkBlue),),
                        error: (error, _) => Text('Error: $error'),
                        loading:()=>CupertinoActivityIndicator(color: lightGreen,)
                      ),
                      lightYellow, darkBlue, () async{
                        formKey.currentState!.save();
                        UserModel user=UserModel(email: _email.text, password: _pass.text);
                        ref.read(Auth.notifier).login(user).then((value) => Navigator.pushNamed(context, '/Create&Join'));
                      }
                  );
                },),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dontHaveAccount,style: TextStyle(color: white,fontSize: 14),),
                    GestureDetector(child: Text(signUp,style: TextStyle(color: lightGreen,fontSize: 14),),onTap: (){Navigator.pushReplacementNamed(context, '/register');},)
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}


