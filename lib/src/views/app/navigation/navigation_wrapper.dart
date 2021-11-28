import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/widgets/custom_bottom_navigation_bar.dart';

class NavigationWrapper extends StatelessWidget {
  const NavigationWrapper({Key key}) : super(key: key);

  static const List<Widget> pageList = [
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationBarBloc(),
          lazy: false,
        ),
      ],
      child: _build(),
    );
  }

  Widget _bodyBuilder(BottomNavigationBarState state) {
    if (kDebugMode) {
      return pageList[state.index];
    } else {
      return IndexedStack(
        index: state.index,
        children: pageList,
      );
    }
  }

  Widget _build() {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          body: _bodyBuilder(state),
          extendBody: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            onTap: (index) => context.read<BottomNavigationBarBloc>().add(BottomNavigationBarUpdate(index: index)),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.one_k),
                activeIcon: Icon(Icons.one_k),
                label: 'Tab 1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.two_k),
                activeIcon: Icon(Icons.two_k),
                label: 'Tab 2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.three_k),
                activeIcon: Icon(Icons.three_k),
                label: 'Tab 3',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.four_k),
                activeIcon: Icon(Icons.four_k),
                label: 'Tab 4',
              ),
            ],
          ),
        );
      },
    );
  }
}
