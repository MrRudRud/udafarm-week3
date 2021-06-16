import 'package:flutter/material.dart';
import 'package:udafarm/widget/constant.dart';

class ButtonUniversal extends StatelessWidget {
  final VoidCallback press;

  const ButtonUniversal({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kPrimaryColor,
      child: Text(
        'Submit',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white),
      ),
      elevation: 8.0,
      onPressed: press,
    );
  }
}
