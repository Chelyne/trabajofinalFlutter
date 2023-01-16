import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/features/detail/presentation/views/detail_page.dart';
import 'package:flutter_movie_app/features/favorites/presentation/views/favorites_page.dart';
import 'package:flutter_movie_app/features/home/presentation/views/home_page.dart';
import 'package:flutter_movie_app/features/profile/presentation/views/profile_page.dart';
import 'package:flutter_movie_app/screens/screens.dart';
import 'package:flutter_movie_app/services/auth_services.dart';
import 'package:flutter_movie_app/services/push_notification_service.dart';
import 'package:flutter_movie_app/user_preferences.dart';
import 'package:flutter_movie_app/wrapper.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.initializeApp();
  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationService.messageStream.listen((message) {
      print('Mensaje: $message');
    });
  }

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
          '/profile': (context) => ProfilePage(),
          '/favorites': (context) => FavoritesPage(),
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
