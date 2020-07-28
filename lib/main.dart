import 'dart:async';
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/constant.dart';
import 'package:delivery_app/services/initialize_i18n.dart';
import 'package:delivery_app/services/localizations.dart'
    show MyLocalizationsDelegate;
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/auth/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

void main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();
  Map localizedValues = await initializeI18n();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String locale = prefs.getString('selectedLanguage') ?? "en";
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  tokenCheck(locale, localizedValues);
  runZoned<Future<Null>>(() async {
    runApp(new MyApp(
      locale,
      localizedValues,
    ));
  }, onError: (error) async {});
}

void tokenCheck(locale, localizedValues) {
  Common.getToken().then((tokenVerification) async {
    if (tokenVerification != null) {
      AuthService.verifyTokenOTP(tokenVerification).then((verifyInfo) async {
        if (verifyInfo['success'] == true) {
        } else {
          Common.removeToken();
        }
      });
    }
  });
}

class MyApp extends StatefulWidget {
  final String locale;
  final Map localizedValues;
  MyApp(this.locale, this.localizedValues);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginIn = false;
  bool loginCheck = false;
  Timer oneSignalTimer;

  @override
  void initState() {
    super.initState();
    loginInCheck();
  }

  loginInCheck() {
    if (mounted) {
      setState(() {
        loginCheck = true;
      });
    }
    oneSignalTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      initOneSignal();
    });
    Common.getToken().then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            loginIn = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            loginIn = false;
          });
        }
      }
    });
  }

  Future<void> initOneSignal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {});
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});
    OneSignal.shared.init(Constants.oneSignalKey, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared.setInFocusDisplayType(
      OSNotificationDisplayType.notification,
    );

    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    String playerId = status.subscriptionStatus.userId;
    if (playerId != null) {
      if (mounted) {
        setState(() {
          loginCheck = false;
        });
      }
      prefs.setString("playerId", playerId);
      if (oneSignalTimer != null && oneSignalTimer.isActive)
        oneSignalTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(widget.locale),
      localizationsDelegates: [
        MyLocalizationsDelegate(widget.localizedValues, [widget.locale]),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale(widget.locale)],
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        cursorColor: Colors.black,
        unselectedWidgetColor: Colors.grey,
      ),
      home: loginCheck
          ? CheckTokenScreen()
          : loginIn
              ? HomePage(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                )
              : Login(
                  locale: widget.locale,
                  localizedValues: widget.localizedValues,
                ),
    );
  }
}

class CheckTokenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primary,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/splash.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
