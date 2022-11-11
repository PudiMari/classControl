import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/ambient/ambient_services.dart';
import 'models/user/user_manager.dart';
import 'screen/login/login_screen.dart';
import 'screen/login/signup_screen.dart';
import 'screen/mainpage/main_page.dart';
import 'screen/units/unit_add_screen.dart';

void main() async {
  const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyC0uDRGhtoAtzyeSUALPRQ6QhfdpP2iCxw",
    appId: "1:641587271241:web:127241018cf52649db9198",
    messagingSenderId: "641587271241",
    projectId: "appflutter-e65cb",
  );
  if (kIsWeb) {
    await Firebase.initializeApp(options: firebaseConfig);
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final ThemeData theme = ThemeData();
  final ThemeData theme = ThemeData.light();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //cria um objeto e o disponibiliza para este e os seus descententes
          create: (_) => UserManager(),
          /*Lazy: a classe UserManager() ainda não foi utilizada,
          portanto ele determina a instanciação imediata */
          lazy: false,
        ),
        ChangeNotifierProvider(
          //cria um objeto e o disponibiliza para este e os seus descententes
          create: (_) => AmbientServices(),
          /*Lazy: a classe UserManager() ainda não foi utilizada,
          portanto ele determina a instanciação imediata */
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ClassRoom Control APP',
        theme: theme.copyWith(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xffF5F5F6),
            primaryColor: const Color.fromARGB(255, 0, 0, 0),
            colorScheme: theme.colorScheme
                .copyWith(secondary: const Color.fromARGB(255, 0, 0, 0)),
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              subtitle1: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
              bodyText1: TextStyle(fontSize: 10.0),
            ),
            bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
              backgroundColor: const Color.fromARGB(255, 0, 188, 38),
            ),
            appBarTheme: theme.appBarTheme.copyWith(
              color: const Color.fromARGB(233, 1, 194, 1),
              toolbarTextStyle: theme.textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .bodyText2,
              titleTextStyle: theme.textTheme
                  .copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .headline6,
            )),
        initialRoute: '/login',
        routes: {
          // '/home': (context) => const HomeScreen(),
          '/unit': (context) => UnitAddScreen(),
          '/home': (context) => const MainPage(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          // '/booking': (context) => const AddBookingScreen(),
        },
      ),
    );
  }
}
