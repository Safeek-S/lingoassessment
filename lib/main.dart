import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lingoassessment/src/screens/login_screen/login_screen.dart';
import 'package:lingoassessment/src/screens/login_screen/login_screen_vm.dart';
import 'package:lingoassessment/src/screens/products_display_screen/products_display_screen.dart';
import 'package:lingoassessment/src/screens/products_display_screen/products_display_screen_vm.dart';
import 'package:lingoassessment/src/screens/signup_screen/signup_screen.dart';
import 'package:lingoassessment/src/screens/signup_screen/signup_screen_vm.dart';
import 'package:lingoassessment/src/services/api_service/api_service.dart';
import 'package:lingoassessment/src/services/api_service/api_service_impl.dart';
import 'package:lingoassessment/src/services/auth_service/auth_service.dart';
import 'package:lingoassessment/src/services/auth_service/auth_service_impl.dart';
import 'package:lingoassessment/src/services/remote_config_service/remote_config_service.dart';
import 'package:lingoassessment/src/services/remote_config_service/remote_config_service_impl.dart';
import 'package:lingoassessment/src/services/remote_storage_service/remote_storage_service.dart';
import 'package:lingoassessment/src/services/remote_storage_service/remote_storage_service_impl.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBOPrhFH7tlme2HWorwbNer0OgU4pfzJsE',
              appId: "1:175157767259:android:0603f6d32841dc49df237e",
              messagingSenderId: '175157767259',
              projectId: "assessment-977fa"))
      : await Firebase.initializeApp();
  await init();
  runApp(MyApp());
}

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => FirebaseAuth.instance);
  sl.registerFactory(() => FirebaseFirestore.instance);
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => FirebaseRemoteConfig.instance);
  sl.registerFactory<ApiService>(() => ApiServiceImpl(sl()));

  sl.registerFactory<AuthService>(() => AuthServiceImpl(sl()));
  sl.registerFactory<RemoteConfigService>(() => RemoteConfigServiceImpl(sl()));
  sl.registerFactory<RemoteStorageService>(
      () => RemoteStorageServiceImpl(sl()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsDisplayScreenViewModel(
            sl.get(),
            sl.get(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpScreenViewModel(
            AuthServiceImpl(sl.get()),
            RemoteStorageServiceImpl(
              sl.get(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginScreenViewModel(
            AuthServiceImpl(
              sl.get(),
            ),
            RemoteConfigServiceImpl(
              sl.get(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/signupScreen': (context) => const SignUpScreen(),
          '/productsDisplayScreen': (context) => const ProductsDisplayScreen(),
        },
      ),
    );
  }
}
