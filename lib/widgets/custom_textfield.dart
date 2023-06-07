import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obsecureText;
  final TextEditingController controller;
  final TextEditingController? secondryController;
  final int lines;
  final String validationType;
  final IconData? activeSuffix, notActiveSuffix;
  final bool isHome;
  const CustomTextField({
    required this.textInputAction,
    required this.textInputType,
    required this.obsecureText,
    required this.hintText,
    required this.controller,
    required this.validationType,
    this.isHome = false,
    this.activeSuffix,
    this.notActiveSuffix,
    this.secondryController,
    this.lines = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool initValue = false;
  @override
  void initState() {
    super.initState();
    initValue = widget.obsecureText;
  }

  changeState(bool value) {
    setState(() {
      initValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          validator: (value) {
            String fieldValue = value!;
            if (widget.validationType == "Name" ||
                widget.validationType == "Password" ||
                widget.validationType == "Business Name") {
              if (value.length <= 5 || value.length >= 30) {
                return "Field must be between 5 & 30";
              }
            } else if (widget.validationType == "Email") {
              if (fieldValue.length < 3 && !fieldValue.contains("@")) {
                return "Email must be valid";
              }
            } else if (widget.validationType == "Confirm Password") {
              if (widget.secondryController!.text != widget.controller.text) {
                return "${widget.validationType} must matched with password field";
              }
            }
            return null;
          },
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.lines,
          obscuringCharacter: "*",
          style: AppStyle.txtUrbanistBold16
              .copyWith(fontSize: 15, color: ColorConstant.primaryColor),
          enabled: !initValue,
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppStyle.txtUrbanistBold16.copyWith(
                fontSize: 15,
                color: ColorConstant.primaryColor.withOpacity(0.3)),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.white,
            filled: true,
            suffixIcon:
                widget.activeSuffix == null && widget.notActiveSuffix == null
                    ? null
                    : initValue == true
                        ? InkWell(
                            onTap: () {
                              changeState(false);
                            },
                            child: Icon(
                              widget.notActiveSuffix,
                              color: Colors.grey,
                              size: 15,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              changeState(true);
                            },
                            child: Icon(
                              widget.activeSuffix,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(2)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isHome == false
                        ? Colors.white
                        : ColorConstant.primaryColor),
                borderRadius: BorderRadius.circular(2)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isHome == false
                        ? Colors.white
                        : ColorConstant.primaryColor),
                borderRadius: BorderRadius.circular(2)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isHome == false
                        ? Colors.white
                        : ColorConstant.primaryColor),
                borderRadius: BorderRadius.circular(2)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isHome == false
                        ? Colors.white
                        : ColorConstant.primaryColor),
                borderRadius: BorderRadius.circular(2)),
          ),
        ),
      ),
    );
  }
}
