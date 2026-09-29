import 'package:flutter/material.dart';
import '../screens/landing_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/task_detail_screen.dart';
import '../screens/note_form_screen.dart';
import '../models/task_model.dart';

class AppRoutes {
  static const String landing = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String taskDetail = '/task-detail';
  static const String noteForm = '/note-form';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case taskDetail:
        final args = settings.arguments;
        if (args is TaskModel) {
          return MaterialPageRoute(builder: (_) => TaskDetailScreen(task: args));
        }
        return _errorRoute();
      case noteForm:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute<String>(builder: (_) => NoteFormScreen(initialNote: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Route tidak ditemukan')),
      ),
    );
  }
}
