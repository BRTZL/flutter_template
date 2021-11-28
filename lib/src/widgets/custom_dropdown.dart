import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/config/imports.dart';

class CustomDropDown<T> extends StatelessWidget {
  final Map<String, T> _items;
  final Function(T value) _onChanged;
  final T _value;
  final String _placeholder;
  final Widget _prefix;
  final FocusNode _focusNode;

  final bool _isEnabled;

  final EdgeInsetsGeometry _padding;
  final EdgeInsetsGeometry _margin;
  final BorderRadiusGeometry _borderRadius;

  const CustomDropDown({
    Key key,
    @required Map<String, T> items,
    @required Function(T value) onChanged,
    @required String placeholder,
    FocusNode focusNode,
    Widget prefix,
    T value,
    bool isEnabled = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    EdgeInsetsGeometry margin = const EdgeInsets.symmetric(vertical: 8.0),
    BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(10)),
  })  : _items = items,
        _onChanged = onChanged,
        _placeholder = placeholder,
        _focusNode = focusNode,
        _prefix = prefix,
        _value = value,
        _isEnabled = isEnabled,
        _padding = padding,
        _margin = margin,
        _borderRadius = borderRadius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !_isEnabled,
      child: Container(
        padding: _padding,
        margin: _margin,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: Palette.grayColor[100],
        ),
        child: DropdownButtonFormField<T>(
          focusNode: _focusNode,
          value: _value,
          icon: const Icon(
            FeatherIcons.chevronDown,
            size: 20,
            color: Palette.secondaryColor,
          ),
          hint: Text(
            _placeholder,
            style: CustomTheme.body(context, color: Palette.secondaryTextColor),
            overflow: TextOverflow.ellipsis,
          ),
          decoration: InputDecoration(
            prefixIcon: _prefix,
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6.0),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          items: _items.keys.map((e) {
            return DropdownMenuItem(
              value: _items[e],
              child: Text(e),
            );
          }).toList(),
          onChanged: _onChanged,
        ),
      ),
    );
  }
}
