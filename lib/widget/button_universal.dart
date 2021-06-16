import 'package:flutter/material.dart';

import 'package:udafarm/widget/constant.dart';

class ButtonUniversal extends StatelessWidget {
  final VoidCallback press;
  final String text;

  const ButtonUniversal({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kPrimaryColor,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.white),
      ),
      onPressed: press,
    );
  }
}
