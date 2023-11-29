import 'package:flutter/widgets.dart';
import 'package:juniorit/gamecraft.dart';
import 'first_scene.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  var game = Game.instance;
  game.init(1280, 512);

  var scene = FirstScene();
  game.addScene(scene);

  game.setCurrentScene(scene);

  game.run();
  
}
