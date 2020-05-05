import 'package:course_app/stylefiles/text_styles.dart';
import 'package:flutter/material.dart';



class ContentHeadingWidget extends StatelessWidget {

  final String heading;

  const ContentHeadingWidget({Key key, @required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        heading,
        style: headingOneTextStyle,
      ),
    );
  }
}
