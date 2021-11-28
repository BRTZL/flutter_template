import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/imports.dart';

class CustomSwitch extends StatefulWidget {
  final String tab1Title;
  final String tab2Title;

  final Function(int value) onChanged;

  const CustomSwitch({
    Key key,
    @required this.tab1Title,
    @required this.tab2Title,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int index = 0;

  void _toggle() {
    setState(() {
      index = index == 0 ? 1 : 0;
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MaterialButton(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            color: index == 0 ? Palette.primaryColor : Palette.grayColor[100],
            onPressed: _toggle,
            padding: EdgeInsets.zero,
            child: Text(
              widget.tab1Title,
              style: CustomTheme.body(context, fontWeight: FontWeight.w700, color: index == 0 ? Colors.white : Palette.secondaryTextColor),
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            color: index == 1 ? Palette.primaryColor : Palette.grayColor[100],
            onPressed: _toggle,
            padding: EdgeInsets.zero,
            child: Text(
              widget.tab2Title,
              style: CustomTheme.body(context, fontWeight: FontWeight.w700, color: index == 1 ? Colors.white : Palette.secondaryTextColor),
            ),
          ),
        ),
      ],
    );
  }
}
