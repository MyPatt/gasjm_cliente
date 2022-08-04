import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gasjm/app/modules/request_permission/request_permission.dart';
import 'package:gasjm/app/modules/request_permission/request_permission_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatelessWidget {
 const RequestPermissionPage({Key? key}) : super(key: key);
//
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<RequestPermissionController>(
      builder: (_) => 
       Scaffold(
        body: SafeArea(child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child:ElevatedButton(child: 
           const Text("Permitir"),
           onPressed: (){
            _.controller.request();
           },)
           
        )),
      ),
    );
  }
}
