import 'package:juniorit/gamecraft.dart';

class FirstScene extends Scene {

  late Sprite background;
  late Sprite sprite;
  
  FirstScene() {

    background = Sprite('background.png');
    sprite = Sprite('t-rex.png');

    addChild(background);
    addChild(sprite);
    
  }

}