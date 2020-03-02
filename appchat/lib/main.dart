import 'package:appchat/env/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Injector(
      inject: [
        Inject(()=> ThemeModel())
      ],
      builder: (context) {
        print("load main");
        final theme = Injector.get<ThemeModel>();
        return StateBuilder(
          models: [theme],
          builder: (context, _) => MaterialApp(
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              brightness: theme.brightness,
              iconTheme: IconThemeData(color: Colors.pink),
              accentColor: theme.accentColor,
              primaryColor: theme.primaryColor,
            ),
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          ),
        );
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeModel them = Injector.get(context: context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: them.brightnessStatus,
    ));
    print('load1');
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
            print("cant change brightness");
          } else {
            them.changeBrightness();
          }
        },
        icon: Icon(Icons.refresh),
        label: Text("Change theme"),
      ),
    );
  }
}

