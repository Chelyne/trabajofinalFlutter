import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/detail/presentation/views/detail_page.dart';
import 'package:flutter_movie_app/features/home/presentation/views/home_page.dart';
import 'package:flutter_movie_app/screens/screens.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:flutter_movie_app/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          'home': (context) => const HomePage(),
          'details': (context) => const DetailsPage(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => registerScreen(),
          '/welcome': (context) => WelcomeScreen(),
          // 'login': (_) => const LoginPage(),
          // 'register': (_) => const RegisterPage(),
        },
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            color: Color(0xFF0F111D),
          ),
        ),
      ),
    );
  }
}
