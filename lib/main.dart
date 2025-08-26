import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_network_platform/core/app/app.dart';
import 'package:social_network_platform/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
