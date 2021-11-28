import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/palette.dart';
import 'package:flutter_template/src/config/theme.dart';

class CustomTripleSwitch extends StatefulWidget {
  final List<String> titles;
  final List<Widget> widgets;

  const CustomTripleSwitch({
    Key key,
    @required this.titles,
    @required this.widgets,
  }) : super(key: key);

  @override
  _CustomTripleSwitchState createState() => _CustomTripleSwitchState();
}

class _CustomTripleSwitchState extends State<CustomTripleSwitch> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  height: 40,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                  ),
                  color: index == 0 ? Palette.primaryColor : Palette.grayColor[100],
                  onPressed: () => setState(() => index = 0),
                  child: Text(
                    widget.titles[0],
                    style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: index == 0 ? Colors.white : Palette.grayColor),
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  height: 40,
                  color: index == 1 ? Palette.primaryColor : Palette.grayColor[100],
                  onPressed: () => setState(() => index = 1),
                  child: Text(
                    widget.titles[1],
                    style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: index == 1 ? Colors.white : Palette.grayColor),
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  elevation: 0,
                  height: 40,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  color: index == 2 ? Palette.primaryColor : Palette.grayColor[100],
                  onPressed: () => setState(() => index = 2),
                  child: Text(
                    widget.titles[2],
                    style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700, color: index == 2 ? Colors.white : Palette.grayColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        widget.widgets[index],
      ],
    );
  }
}
