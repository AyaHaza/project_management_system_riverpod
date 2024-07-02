import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/hive_config.dart';
import 'config/routes.dart';
import 'features/authentection/presentation_layer/pages/register.dart';
import 'features/creat_join/presentation_layer/pages/create&join.dart';
import 'injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Hive.initFlutter();
  await setupHive();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // userHive!.delete("token");
    print(userHive!.get("token"));
    return   MaterialApp(
      debugShowCheckedModeBanner:false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: (userHive!.get("token")==null || userHive!.get("token")=='')?
      Register() : CreateAndJoin(),
    );
  }
}
