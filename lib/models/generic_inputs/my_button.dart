import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String insertText;
  final double? textSize;
  final Color? buttonColor;
  final Color? outlineButtonColor;
  final IconData? buttonIcon;
  final double? buttonIconSize;
  final double? buttonRadius;
  final Axis? direction;
  // Agregar requerimientos para: Shape, Color, Iconos

  const MyButton({
    super.key,
    required this.onTap,
    required this.insertText,
    this.outlineButtonColor,
    this.buttonColor,
    this.buttonIcon,
    this.buttonIconSize,
    this.textSize,
    this.buttonRadius,
    this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 174,
      height: 70,
      child: OutlinedButton(

          onPressed: onTap,
          iconAlignment: IconAlignment.start,
          style: OutlinedButton.styleFrom(
            side: BorderSide(width: 2.0, color: outlineButtonColor ?? Colors.transparent),
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
            backgroundColor: buttonColor ?? const Color(0xFF044389),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(buttonRadius ?? 5))
            ),

          ),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: direction ?? Axis.vertical,
            children: [
              Icon(
                buttonIcon ?? Icons.info_outline_rounded,
                color: Colors.white,
                size: buttonIconSize ?? 25,
              ),
              const SizedBox(width: 9,),
              Text(
                insertText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize ?? 17,
                ),)
            ],
          ),
          // child: Text(
          //   insertText,
          //     Padding(
          //       padding: const EdgeInsets.only(top: 0, bottom: 0),
          //       child: GestureDetector(
          //         onTap: onTap,
          //         child: Container(
          //           padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 44.0, right: 15.0),
          //           decoration: BoxDecoration(
          //             color: Color(0xFF044389),
          //             borderRadius: BorderRadius.circular(3),
          //           ),
          //           child: Center(
          //             child: Text(
          //               insertText,
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 27,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
      ),
    );
  }
}
