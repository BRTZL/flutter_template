import 'package:flutter/material.dart';
import 'package:flutter_template/src/widgets/custom_loader.dart';

typedef WidgetBuilder<T> = Widget Function(T data);

class FutureLoader<T> extends StatelessWidget {
  final Future<T> future;
  final WidgetBuilder<T> child;

  const FutureLoader({
    Key key,
    @required this.future,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          Navigator.pop(context);
          return const Scaffold(
            body: Center(
              child: Text('error'),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return child(snapshot.data);
        } else {
          return const Scaffold(
            body: Center(
              child: CustomLoader(),
            ),
          );
        }
      },
    );
  }
}
