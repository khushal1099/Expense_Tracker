import 'package:get/get.dart';

class PasswordController extends GetxController{
  RxBool isShow = false.obs;

  void passwordToggle(){
    isShow.value = !isShow.value;
  }
}