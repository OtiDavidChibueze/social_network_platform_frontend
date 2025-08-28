import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/locator.dart';
import 'features/auth/presentation/bloc/user_bloc.dart';
import 'features/auth/presentation/bloc/user_event.dart';
import 'firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UserBloc>()..add(GetUserEvent())),
      ],
      child: const MyApp(),
    ),
  );
}
