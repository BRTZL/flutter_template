import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FilterListTile extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isSelected;

  const FilterListTile({
    Key key,
    @required this.title,
    @required this.onPressed,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: CustomTheme.subtitle(context, fontWeight: FontWeight.w700),
                  ),
                ),
                Icon(
                  isSelected ? MdiIcons.checkboxMarked : MdiIcons.checkboxBlankOutline,
                  color: Palette.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
