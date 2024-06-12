import 'package:expense_tracker/controller/password_controller.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:expense_tracker/utils/SizeUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class TextformField extends StatefulWidget {
  final String hinttext;
  final IconData? icon;
  final TextEditingController? textController;
  final bool isPassword;
  final bool isPadding;
  final String Function(String?) validator;

  TextformField({
    super.key,
    required this.hinttext,
    this.icon,
    this.textController,
    this.isPassword = false,
    required this.isPadding,
    required this.validator,
  });

  @override
  State<TextformField> createState() => _TextformFieldState();
}

class _TextformFieldState extends State<TextformField> {
  RxBool isValue = false.obs;

  final controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isPadding
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : EdgeInsets.zero,
      child: widget.isPassword
          ? Obx(
              () => Container(
                width: SizeUtils.width * 1,
                height: 50,
                decoration: BoxDecoration(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? ColorsUtil.lightBg
                      : ColorsUtil.darkBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: widget.textController.isNull
                      ? null
                      : widget.textController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: controller.isShow.value,
                  onChanged: (value) {
                    isValue.value = value.isNotEmpty;
                  },
                  decoration: InputDecoration(
                      prefixIcon: widget.icon.isNull ? null : Icon(widget.icon),
                      hintText: widget.hinttext,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      suffixIcon: isValue.value
                          ? InkWell(
                              onTap: () {
                                controller.passwordToggle();
                              },
                              child: controller.isShow.value
                                  ? const Icon(Icons.visibility_rounded)
                                  : const Icon(Icons.visibility_off),
                            )
                          : const SizedBox()),
                  validator: (value) {
                    return widget.validator(value);
                  },
                ),
              ),
            )
          : TextFormField(
              controller:
                  widget.textController.isNull ? null : widget.textController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: widget.icon.isNull ? null : Icon(widget.icon),
                hintText: widget.hinttext,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                fillColor: ColorsUtil.lightBg,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                filled: true,
              ),
              validator: (value) {
                return widget.validator(value);
              },
            ),
    );
  }
}
