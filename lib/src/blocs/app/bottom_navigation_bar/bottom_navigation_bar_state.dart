part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarState extends Equatable {
  final int index;

  const BottomNavigationBarState({
    @required this.index,
  });

  @override
  List<Object> get props => [index];
}

class BottomNavigationBarInitial extends BottomNavigationBarState {
  const BottomNavigationBarInitial({
    @required int index,
  }) : super(index: index);

  @override
  List<Object> get props => [index];
}

class BottomNavigationBarUpdated extends BottomNavigationBarState {
  const BottomNavigationBarUpdated({
    @required int index,
  }) : super(index: index);

  @override
  List<Object> get props => [index];
}
