import 'package:flutter/material.dart';
import 'package:house_of_deliverance/core/custom_colors.dart';
import 'package:house_of_deliverance/core/custom_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  const ButtonWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              ColorConstant.primaryColor2.withOpacity(0.8),
              ColorConstant.primaryColor.withOpacity(0.8),
            ],
          )),
      child: Center(
        child: Text(title, style: AppStyle.txtUrbanistBold16),
      ),
    );
  }
}
