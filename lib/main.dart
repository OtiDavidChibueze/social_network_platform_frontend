import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_platform/core/di/locator.dart';
import 'package:social_network_platform/features/auth/presentation/bloc/user_bloc.dart';
import 'package:social_network_platform/firebase_options.dart';
import './app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setLocator();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<UserBloc>())],
      child: const MyApp(),
    ),
  );
}
