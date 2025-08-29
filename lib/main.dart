import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/di/locator.dart';
import 'features/auth/presentation/bloc/user_bloc.dart';
import 'features/auth/presentation/bloc/user_event.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

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
