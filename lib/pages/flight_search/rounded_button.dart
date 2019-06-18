import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final bool selected;
  final GestureTapCallback onTap;

  const RoundedButton({Key key, this.text, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = selected ? Colors.white : Colors.transparent;
    Color textColor = selected ? Colors.red : Colors.white;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 36.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor),
              )
            ),
          ),
        ),
      ),
    );
  }
}