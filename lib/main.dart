import 'package:flutter/material.dart';
import 'app.dart';
import 'bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialBinding().initServices();
  runApp(const EcoBinProApp());
}
