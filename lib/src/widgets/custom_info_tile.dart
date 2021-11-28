import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/config/imports.dart';

enum CustomInfoType { high, medium, low }

class CustomInfoTile extends StatelessWidget {
  final CustomInfoType _customInfoType;
  final String _text;

  final Function() _onPressed;

  const CustomInfoTile({
    @required CustomInfoType customInfoType,
    @required String text,
    Function() onPressed,
    Key key,
  })  : _customInfoType = customInfoType,
        _text = text,
        _onPressed = onPressed,
        super(key: key);

  Color get getColor {
    switch (_customInfoType) {
      case CustomInfoType.low:
        return Palette.successColor;
        break;
      case CustomInfoType.medium:
        return Palette.warningColor;
        break;
      case CustomInfoType.high:
      default:
        return Palette.dangerColor;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        overlayColor: MaterialStateProperty.all(getColor.withOpacity(0.2)),
        onTap: _onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: getColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(
                FeatherIcons.info,
                color: getColor,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  _text,
                  style: CustomTheme.body(context, fontWeight: FontWeight.w700, color: getColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
