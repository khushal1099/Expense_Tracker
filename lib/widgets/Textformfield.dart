import 'package:expense_tracker/controller/password_controller.dart';
import 'package:expense_tracker/utils/ColorsUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextformField extends StatefulWidget {
  final String hinttext;
  final IconData? icon;
  final TextEditingController? textController;
  final bool isPassword;
  final bool isPadding;
  final FormFieldValidator<dynamic>? validator;
  final bool isNumber;

  TextformField({
    super.key,
    required this.hinttext,
    this.icon,
    this.textController,
    this.isPassword = false,
    required this.isPadding,
    required this.validator,
    this.isNumber = false,
  });

  @override
  State<TextformField> createState() => _TextformFieldState();
}

class _TextformFieldState extends State<TextformField> {
  RxBool isValue = false.obs;

  final controller = Get.put(PasswordController());
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isPadding
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          : EdgeInsets.zero,
      child: widget.isPassword
          ? Obx(
              () => TextFormField(
                controller:
                    widget.textController.isNull ? null : widget.textController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: controller.isShow.value,
                focusNode: focusNode,
                autofocus: true,
                onChanged: (value) {
                  isValue.value = value.isNotEmpty;
                },
                decoration: InputDecoration(
                    prefixIcon: widget.icon.isNull ? null : Icon(widget.icon),
                    hintText: widget.hinttext,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    fillColor: ColorsUtil.lightBg,
                    filled: true,
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
                validator: widget.validator,
              ),
            )
          : TextFormField(
              controller:
                  widget.textController.isNull ? null : widget.textController,
              keyboardType: widget.isNumber ? TextInputType.number : null,
              focusNode: focusNode,
              inputFormatters: widget.isNumber
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : null,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: widget.icon.isNull ? null : Icon(widget.icon),
                hintText: widget.hinttext,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                fillColor: ColorsUtil.lightBg,
                filled: true,
              ),
              onTapOutside: (event) {
                focusNode.unfocus();
              },
              autofocus: true,
              validator: widget.validator,
            ),
    );
  }
}
