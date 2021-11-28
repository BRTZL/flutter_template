import 'package:flutter/material.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/views/auth/welcome_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const WelcomeScreen(),
    );
  }
}
