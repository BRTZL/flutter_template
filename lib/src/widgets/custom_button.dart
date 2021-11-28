import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/src/config/imports.dart';

enum CustomButtonType {
  primary,
  secondary,
  delete,
  confirm,
  cancel,
  formField,
  flat,
  camera,
  document,
  faded,
}

Map<CustomButtonType, Color> _customButtonColors = {
  CustomButtonType.primary: Palette.primaryColor,
  CustomButtonType.secondary: Palette.secondaryColor,
  CustomButtonType.delete: Palette.dangerColor,
  CustomButtonType.confirm: Palette.successColor,
  CustomButtonType.cancel: Palette.grayColor,
  CustomButtonType.formField: Palette.grayColor[100],
  CustomButtonType.flat: Colors.white,
  CustomButtonType.camera: Palette.grayColor[100],
  CustomButtonType.document: Palette.grayColor[100],
  CustomButtonType.faded: Palette.primaryColor[100].withAlpha(100),
};

Map<CustomButtonType, Color> _customButtonTextColors = {
  CustomButtonType.primary: Colors.white,
  CustomButtonType.secondary: Colors.white,
  CustomButtonType.delete: Colors.white,
  CustomButtonType.confirm: Colors.white,
  CustomButtonType.cancel: Colors.white,
  CustomButtonType.formField: Palette.grayColor[600],
  CustomButtonType.flat: Colors.black,
  CustomButtonType.camera: Colors.black,
  CustomButtonType.document: Colors.black,
  CustomButtonType.faded: Palette.primaryColor,
};

class CustomButton extends StatelessWidget {
  final CustomButtonType _customButtonType;
  final Widget _child;
  final String _text;
  final Function() _onPressed;
  final Function() _onLongPress;
  final bool _haveChild;
  final bool _isExpanded;
  final bool _isEnabled;
  final bool _isDone;

  final FocusNode _focusNode;

  final TextStyle _textStyle;

  final BorderRadius _borderRadius;
  final EdgeInsetsGeometry _padding;
  final EdgeInsetsGeometry _margin;
  final EdgeInsetsGeometry _customPadding;

  const CustomButton({
    Key key,
    @required String text,
    @required CustomButtonType customButtonType,
    @required Function() onPressed,
    Function() onLongPress,
    bool isExpanded = true,
    bool isEnabled = true,
    bool isDone = false,
    FocusNode focusNode,
    TextStyle textStyle,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.5),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0),
    EdgeInsetsGeometry customPadding,
  })  : _text = text,
        _customButtonType = customButtonType,
        _onPressed = onPressed,
        _onLongPress = onLongPress,
        _isExpanded = isExpanded,
        _isEnabled = isEnabled && onPressed != null,
        _isDone = isDone,
        _focusNode = focusNode,
        _textStyle = textStyle,
        _borderRadius = borderRadius,
        _padding = padding,
        _margin = margin,
        _customPadding = customPadding,
        _haveChild = false,
        _child = null,
        super(key: key);

  const CustomButton.child({
    Key key,
    @required Widget child,
    @required Function() onPressed,
    CustomButtonType customButtonType = CustomButtonType.flat,
    Function() onLongPress,
    bool isExpanded = true,
    bool isEnabled = true,
    bool isDone = false,
    FocusNode focusNode,
    TextStyle textStyle,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 3.5),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0),
    EdgeInsetsGeometry customPadding,
  })  : _child = child,
        _customButtonType = customButtonType,
        _onPressed = onPressed,
        _onLongPress = onLongPress,
        _isExpanded = isExpanded,
        _isEnabled = isEnabled,
        _isDone = isDone,
        _focusNode = focusNode,
        _textStyle = textStyle,
        _borderRadius = borderRadius,
        _padding = padding,
        _margin = margin,
        _customPadding = customPadding,
        _haveChild = true,
        _text = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !_isEnabled,
      child: Container(
        margin: _margin,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: _isEnabled
              ? (_haveChild
                  ? (_customButtonType == CustomButtonType.formField || _customButtonType == CustomButtonType.faded
                      ? _customButtonColors[_customButtonType]
                      : Colors.transparent)
                  : _customButtonColors[_customButtonType])
              : Palette.grayColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            overlayColor: MaterialStateProperty.all(Palette.primaryColor[50].withAlpha(100)),
            highlightColor: Palette.primaryColor[50].withAlpha(50),
            focusNode: _focusNode,
            borderRadius: const BorderRadius.all(Radius.circular(7.0)),
            onTap: () {
              HapticFeedback.mediumImpact();
              _onPressed();
            },
            onLongPress: _onLongPress != null
                ? () {
                    HapticFeedback.heavyImpact();
                    _onLongPress();
                  }
                : null,
            child: Padding(
              padding: _customPadding ?? const EdgeInsets.all(12.0).add(_padding),
              child: Row(
                mainAxisSize: _isExpanded ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _childBuilder(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _childBuilder(BuildContext context) {
    if (_haveChild) {
      return _child;
    } else if (_customButtonType == CustomButtonType.camera) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 12.0),
          const Icon(Icons.photo),
          const SizedBox(width: 12.0),
          Text(_text),
          if (_isDone)
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.done,
                color: Palette.primaryColor,
              ),
            )
          else
            const SizedBox(width: 12.0),
        ],
      );
    } else if (_customButtonType == CustomButtonType.document) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 24.0),
          const Icon(Icons.description),
          const SizedBox(width: 12.0),
          Text(_text),
          if (_isDone)
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.done,
                color: Palette.primaryColor,
              ),
            )
          else
            const SizedBox(width: 36.0),
        ],
      );
    } else {
      if (!_isExpanded) {
        return Text(
          _text,
          style: _textStyle ??
              CustomTheme.subtitle(
                context,
                color: _isEnabled ? _customButtonTextColors[_customButtonType] : Colors.white,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        );
      } else {
        return Expanded(
          child: Text(
            _text,
            style: _textStyle ??
                CustomTheme.subtitle(
                  context,
                  color: _isEnabled ? _customButtonTextColors[_customButtonType] : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        );
      }
    }
  }
}
