import 'package:cuhkszapp/Login/sign_in_page.dart';
import 'package:cuhkszapp/MainPages/home_page.dart';
import 'package:cuhkszapp/Onboarding/onboarding_main.dart';
import 'package:cuhkszapp/Services/User/bloc/bloc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen $initScreen');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: UserBloc(),
      child: MaterialApp(
        title: "CUHK SZ",
        theme: ThemeData(
          primaryColor: Color(0xff6747CD),
          accentColor: Color(0xff6747CD),
        ),
        initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
        routes: {
          '/': (context) {
            UserBloc userBloc = BlocProvider.of(context);
            return StreamBuilder<User>(
              stream: userBloc.authStatus,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomePage();
                } else if (snapshot.hasError) {
                  return Text("Ocurrio un error en la transmision de datos");
                } else if (snapshot.connectionState !=
                    ConnectionState.waiting) {
                  return SignInPage();
                } else {
                  return Scaffold(
                    body: Center(
                      child: Container(child: CircularProgressIndicator()),
                    ),
                  );
                }
              },
            );
          },
          "first": (context) => OnboardingMain(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
