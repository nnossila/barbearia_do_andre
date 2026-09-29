import 'package:flutter/material.dart';
import 'splashpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ptkcvobvabayrmrmmvep.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB0a2N2b2J2YWJheXJtcm1tdmVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTA1OTY3MTQsImV4cCI6MjEwNjE3MjcxNH0.GfPJfLRzQ18GtMCBgvDsi5Mwa356r1Bnvwyh1b8Eon4',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Escola',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lora',
      ),

      home: const SplashPage(),
    );
  }
}