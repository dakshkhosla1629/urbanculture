import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbanculture/provider/imageuploadingprovider.dart';
import 'package:urbanculture/provider/skincareprovider.dart';
import 'package:urbanculture/screens/navigationbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(MainApp());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SkincareProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Imageuploadingprovider(),
        ),
      ],
      child: const MaterialApp(
        home: Navigationbarscreen(),
      ),
    );
  }
}
