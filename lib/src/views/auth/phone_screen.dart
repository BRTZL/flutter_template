import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:flutter_template/src/helpers/link_launcher.dart';
import 'package:flutter_template/src/views/auth/code_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneScreen extends StatelessWidget {
  final LoginBloc loginBloc;

  const PhoneScreen({
    Key key,
    @required this.loginBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (ctx, state) {
        if (state is LoginSuccess) {
          if (state.verificationId != null) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CodeScreen(loginBloc: loginBloc)));
          }
        }
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
              onPressed: () => Navigator.pop(context),
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
                    "Enter your phone number to continue",
                    style: CustomTheme.headline4(context, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const Height(16.0),
                  Text(
                    "A 4-digit OTP will be send via SMS to verify your phone number.",
                    style: CustomTheme.headline6(context, color: Palette.secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                  const Height(40.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Palette.primaryColor,
                        width: 2.5,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InternationalPhoneNumberInput(
                      countries: const ["TR", "US"],
                      autofillHints: const [AutofillHints.telephoneNumber],
                      onInputChanged: (PhoneNumber phoneNumber) {
                        loginBloc.add(LoginUpdatePhoneNumber(phoneNumber: phoneNumber));
                      },
                      autoFocus: true,
                      inputDecoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      onInputValidated: (bool isValid) {
                        loginBloc.add(LoginUpdatePhoneNumberValidation(isValid: isValid));
                      },
                    ),
                  ),
                  const Height(20.0),
                  CustomButton(
                    text: 'Send OTP',
                    isEnabled: state.isEnabled,
                    customButtonType: CustomButtonType.primary,
                    onPressed: () {
                      loginBloc.add(LoginSendCode());
                    },
                  ),
                  CustomButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    text: 'By signing up, you’re agree to our Terms of Use and Privacy Policy',
                    customButtonType: CustomButtonType.flat,
                    onPressed: () {
                      launchLink(Links.termsAndConditionsLink);
                    },
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
