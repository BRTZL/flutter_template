import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_template/src/config/imports.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int index) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    @required this.onTap,
    @required this.items,
    Key key,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

final GlobalKey _key = GlobalKey();

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  double _position = 0;
  int _currentIndex = 0;

  Future _updatePosition() async {
    final RenderBox box = _key.currentContext.findRenderObject() as RenderBox;
    final double tempPosition = box.localToGlobal(Offset.zero).dx;

    // while (_position != tempPosition) {
    //   await Future.delayed(const Duration(milliseconds: 1));
    //   final RenderBox box = _key.currentContext.findRenderObject() as RenderBox;
    //   tempPosition = box.localToGlobal(Offset.zero).dx;
    //   setState(() {
    //     _position = tempPosition - 40;
    //   });
    // }

    if (tempPosition != _position) {
      Future.delayed(const Duration(milliseconds: 1), () {
        _updatePosition();
      });

      setState(() {
        _position = tempPosition - 40;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: max(MediaQuery.of(context).padding.bottom, 20),
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            offset: const Offset(-6, -6),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(6, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 200),
            left: _position,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Palette.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTheme(
                    data: const IconThemeData(
                      color: Palette.primaryColor,
                    ),
                    child: widget.items[_currentIndex].activeIcon,
                  ),
                  const Width(6),
                  Text(
                    widget.items[_currentIndex].label,
                    style: CustomTheme.subtitle(context, color: Palette.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items
                .asMap()
                .map<int, Widget>((index, item) => MapEntry(
                      index,
                      BottomNavigationBarItemBuilder(
                        item: item,
                        isSelected: _currentIndex == index,
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                            widget.onTap(index);
                          });

                          _updatePosition();
                        },
                      ),
                    ))
                .values
                .toList(),
          )
        ],
      ),
    );
  }
}

class BottomNavigationBarItemBuilder extends StatelessWidget {
  final BottomNavigationBarItem item;
  final bool isSelected;
  final Function() onTap;

  const BottomNavigationBarItemBuilder({
    @required this.item,
    @required this.isSelected,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        key: _key,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Visibility(
          visible: false,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: Row(
            children: [
              IconTheme(
                data: const IconThemeData(
                  color: Palette.primaryColor,
                ),
                child: item.activeIcon,
              ),
              const Width(6),
              Text(
                item.label,
                style: CustomTheme.subtitle(context, color: Palette.primaryColor),
              ),
            ],
          ),
        ),
      );
    } else {
      return IconTheme(
        data: const IconThemeData(
          color: Palette.grayColor,
        ),
        child: item.icon,
      ).withOnPressed(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onPressed: onTap,
      );
    }
  }
}
