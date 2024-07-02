import 'package:flutter/material.dart';
import '../features/authentection/presentation_layer/pages/login.dart';
import '../features/authentection/presentation_layer/pages/register.dart';
import '../features/creat_join/presentation_layer/pages/create&join.dart';
import '../features/mangement_project/presentation_layer/pages/create_project.dart';
import '../features/mangement_project/presentation_layer/pages/project_home.dart';
import '../features/mangement_task/presentation_layer/pages/add_task.dart';


class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute( Register());

      case '/register':
        return _materialRoute(Register());

      case '/login':
        return _materialRoute(Login());

      case '/Create&Join':
        return _materialRoute(CreateAndJoin());

      case '/CreateProject':
        return _materialRoute(CreateProject());

      case '/AddTask':
        return _materialRoute(AddTask());

      case '/ProjectHome':
        return _materialRoute(ProjectHome());

      default:
        return _materialRoute( Register());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}