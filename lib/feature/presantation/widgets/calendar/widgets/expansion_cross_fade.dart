import 'package:flutter/cupertino.dart';

class ExpansionCrossFade extends StatelessWidget {
  final Widget body;
  final bool isExpanded;

  ExpansionCrossFade({this.body, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: body,
      secondChild: body,
      firstCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.decelerate,
      crossFadeState:
      isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}