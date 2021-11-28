import 'package:flutter/material.dart';

class CustomExpansionCard extends StatefulWidget {
  final Widget title;
  final Widget child;

  const CustomExpansionCard({
    Key key,
    this.title,
    this.child,
  }) : super(key: key);

  @override
  _CustomExpansionCardState createState() => _CustomExpansionCardState();
}

class _CustomExpansionCardState extends State<CustomExpansionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: isExpanded
          ? Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    onTap: () => setState(() => isExpanded = false),
                    child: Row(
                      children: [
                        widget.title,
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_up),
                          onPressed: () => setState(() => isExpanded = false),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  widget.child,
                ],
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                onTap: () => setState(() => isExpanded = true),
                child: Row(
                  children: [
                    widget.title,
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_down),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
