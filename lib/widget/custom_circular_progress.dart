import 'package:flutter/material.dart';
import 'package:udafarm/widget/constant.dart';

class CustomCircular extends StatelessWidget {
  const CustomCircular({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.yellow,
      valueColor: AlwaysStoppedAnimation(kPrimaryColor),
      strokeWidth: 7,
    );
  }
}
