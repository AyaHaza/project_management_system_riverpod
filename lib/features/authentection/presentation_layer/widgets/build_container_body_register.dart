import 'package:flutter/material.dart';
import '../../../../core/constants/constantsColor.dart';
import '../../../../core/constants/constantsStringApp.dart';
import '../../../../core/constants/contantsVarApp.dart';
import '../../../../core/widgetsApp/TextFiledCustom.dart';
import 'drop_down.dart';

Widget  buildContanerBody(valueNotifier,valuee,_firstName,_lastName,_email,_pass,_role){
  return  Padding(
    padding: const EdgeInsets.only(top: 120.0),
    child: Center(
      child: Container(
        height: 600,
        width: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            TextFiledCustom(28,firstname,lightGreen,darkBlue,1,_firstName ),
            TextFiledCustom(28,lastname,lightGreen,darkBlue,1,_lastName ),
            TextFiledCustom(28,email,lightGreen,darkBlue,1,_email ),
            TextFiledCustom(28,password,lightGreen,darkBlue,1,_pass ),
            DropDown(selectRole ,_role),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context,value,_) {
                      return Checkbox(checkColor: lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        fillColor:  MaterialStateProperty.resolveWith((states) {
                          return darkBlue;
                        }),
                        value: valuee,
                        onChanged:(value) {
                          valuee = !valuee;
                          valueNotifier.value=valuee;
                          print(valueNotifier.value);
                          if(valueNotifier.value==true){
                            saveToken=true;
                          }else{
                            saveToken=false;
                          }
                        }, );
                    },
                  ),
                  Text(rememberMe,style: TextStyle(color: darkBlue),)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
