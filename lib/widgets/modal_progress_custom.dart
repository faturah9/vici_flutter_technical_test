import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';

class ModalProgress extends StatelessWidget {
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Offset? offset;
  final bool? dismissible;
  final Widget? child;

  const ModalProgress({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      Widget layOutProgressIndicator;
      layOutProgressIndicator = Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Lottie.asset(
            'assets/jsons/loading_spinner_json.json',
            repeat: true,
          ),
        ),
      );
      final modal = [
        Opacity(
          opacity: opacity!,
          child: ModalBarrier(dismissible: dismissible!, color: color),
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return Stack(
      children: widgetList,
    );
  }
}
