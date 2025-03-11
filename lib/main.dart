import 'package:flutter/material.dart';
import 'package:my_app/configs/app_settings.dart';
import 'package:my_app/configs/hive_config.dart';
import 'package:my_app/repositories/conta_repository.dart';
import 'package:my_app/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';
import 'meuAplicativo.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // para não bugar com o código antes do runApp
  await HiveConfig.start(); 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
