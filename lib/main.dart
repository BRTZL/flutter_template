import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/app_localizations.dart';
import 'package:flutter_template/helper/app_lifecycle_listener.dart';
import 'package:flutter_template/helper/cloud_messaging_listener.dart';
import 'package:flutter_template/helper/dynamic_link_listener.dart';
import 'package:flutter_template/helper/load_assets.dart';
import 'package:flutter_template/helper/rate_my_app_listener.dart';
import 'package:flutter_template/helper/reassemble_listener.dart';
import 'package:flutter_template/helper/restart_app.dart';
import 'package:flutter_template/routes.dart';
import 'package:flutter_template/src/blocs/blocs.dart';
import 'package:flutter_template/src/config/imports.dart';
import 'package:flutter_template/src/service/services.dart';
import 'package:flutter_template/src/views/app/app_wrapper.dart';
import 'package:flutter_template/src/views/auth/auth_wrapper.dart';
import 'package:in_app_notification/in_app_notification.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await loadAssets();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));

  runApp(RestartWidget(child: AppEntry()));
  // runZonedGuarded(() async {
  // }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class AppEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteConfigControllerBloc(
            restartAppFunction: () => RestartWidget.restartApp(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => OnboardingControllerBloc(),
        ),
      ],
      child: const MaterialAppWrapper(),
    );
  }
}

class MaterialAppWrapper extends StatefulWidget {
  const MaterialAppWrapper({Key key}) : super(key: key);

  @override
  _MaterialAppWrapperState createState() => _MaterialAppWrapperState();
}

class _MaterialAppWrapperState extends State<MaterialAppWrapper> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1284 / 3, 2778 / 3),
      builder: () => MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: _analytics),
        ],
        debugShowCheckedModeBanner: false,
        title: Config.title,
        theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,
        initialRoute: Routes.initialRoute,
        routes: Routes.routes,
        builder: (_, child) => AppBuilder(child: child),
        supportedLocales: const [
          Locale('en', ''),
          Locale('tr', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return locale;
            }
          }

          return supportedLocales.first;
        },
      ),
    );
  }
}

class AppBuilder extends StatelessWidget {
  final Widget child;

  const AppBuilder({
    @required this.child,
    Key key,
  }) : super(key: key);

  double getTextScaleFactor(BuildContext context) {
    if (MediaQuery.of(context).size.width < 400) {
      return 0.8;
    } else if (MediaQuery.of(context).size.width < 450) {
      return 0.87;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: CloudMessagingListener(
        child: DynamicLinkListener(
          child: AppLifecycleListener(
            appLifecycleListenerCallback: (state, oldState) {
              // can attach to other app bloc
              if (oldState == AppLifecycleState.paused && state == AppLifecycleState.inactive) {
                if (context.read<AuthenticationBloc>().state is AuthenticationAuthenticated) {
                  blocGet(context);
                }
              }
            },
            child: ReassembleListener(
              onReassemble: () => kDebugMode ? AppLocalizations.of(context).load() : null,
              child: RateMyAppListener(
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: getTextScaleFactor(context)),
                  child: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationAuthenticated) {
                        blocGet(context);
                        NavigationService.instance.navigatorKey.currentState.pushAndRemoveUntil(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => const AppWrapper(),
                            transitionDuration: Duration.zero,
                          ),
                          (route) => false,
                        );
                      } else if (state is AuthenticationNotAuthenticated) {
                        NavigationService.instance.navigatorKey.currentState.pushAndRemoveUntil(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => const AuthWrapper(),
                            transitionDuration: Duration.zero,
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
