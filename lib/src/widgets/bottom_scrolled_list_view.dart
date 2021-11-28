import 'package:flutter/material.dart';

class BottomScrolledListView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry padding;

  const BottomScrolledListView({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.padding,
  }) : super(key: key);

  @override
  _BottomScrolledListViewState createState() => _BottomScrolledListViewState();
}

class _BottomScrolledListViewState extends State<BottomScrolledListView> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());

    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}
