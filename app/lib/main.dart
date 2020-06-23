import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:presentation/di/presentation_module.dart';
import 'di/index.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      modules: [
        AppModule(),
        RemoteModule(),
        DataModule(),
        DomainModule(),
        PresentationModule(),
      ],
      child: MaterialApp(
        title: 'Authentication Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(title: 'Authentication Demo'),
      ),
    );
  }
}
