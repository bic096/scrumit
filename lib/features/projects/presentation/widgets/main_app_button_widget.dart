import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:scrumit/core/presentaion/text_style.dart';
import 'package:scrumit/utils/size_helper.dart' as size;

class MainAppButton extends StatelessWidget {
  const MainAppButton({
    Key? key,
    required this.label,
    this.onPress,
    this.height = 50,
    this.width,
  }) : super(key: key);
  final String label;
  // ignore: prefer_function_declarations_over_variables
  final Callback? onPress;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: height,
        width: width ?? size.displayWidth(context) * 0.9,
        child: InkWell(
          onTap: onPress ?? () {},
          child: Card(
              elevation: .9,
              child: Center(
                  child: Text(
                label,
                style: CustomTextStyle.buttonTextStyle,
              ))),
        ),
      ),
    );
  }
}
