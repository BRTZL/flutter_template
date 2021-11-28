import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeScreen extends StatelessWidget {
  final LoginBloc loginBloc;

  const CodeScreen({
    @required this.loginBloc,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: kToolbarHeight,
            leading: CustomButton.child(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              customPadding: EdgeInsets.zero,
              child: Row(
                children: [
                  const Icon(FeatherIcons.chevronLeft),
                  Text(
                    'Back',
                    style: CustomTheme.headline6(context, color: Palette.primaryColor),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            leadingWidth: 110,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const Height(30.0),
                  Text(
                    "Verify phone number",
                    style: CustomTheme.headline4(context, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const Height(16.0),
                  Text(
                    "Check your SMS messages. We’ve sent you the PIN at ${state.phoneNumber.phoneNumber}",
                    style: CustomTheme.headline6(context, color: Palette.secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                  const Height(40.0),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    textStyle: CustomTheme.headline5(context, fontWeight: FontWeight.bold),
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: MediaQuery.of(context).size.width * .12,
                      activeFillColor: Colors.white,
                      activeColor: Palette.primaryColor,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Palette.grayColor,
                      selectedFillColor: Colors.white,
                      selectedColor: Palette.grayColor,
                    ),
                    showCursor: false,
                    useHapticFeedback: true,
                    enableActiveFill: true,
                    autoDismissKeyboard: false,
                    autoFocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    onCompleted: (code) {
                      loginBloc.add(LoginVerifyCode(code: code));
                    },
                  ),
                  const Height(20.0),
                  CustomButton(
                    text: 'Verify Now',
                    customButtonType: CustomButtonType.primary,
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CodeScreen()));
                    },
                  ),
                  CustomButton.child(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Didn’t you receive any code?\n',
                        style: CustomTheme.body(context, color: Palette.secondaryTextColor, fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Re-send code',
                            style: CustomTheme.body(context, color: Palette.primaryColor, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
