import 'package:my_calendar/config/resources/image_asset.dart';

class Animal {
  String name;
  String image;
  String hour;

  Animal(
    this.name,
    this.hour,
    this.image,
  );

  static List<Animal> data = [
    Animal('Tý', '(23-1h)', ImageAssets.icMouse),
    Animal('Sửu', '(1-3h)', ImageAssets.icBuffalo),
    Animal('Dần', '(3-5h)', ImageAssets.icTiger),
    Animal('Mão', '(5-7h)', ImageAssets.icCat),
    Animal('Thìn', '(7-9h)', ImageAssets.icDragon),
    Animal('Tỵ', '(9-11h)', ImageAssets.icSneak),
    Animal('Ngọ', '(11-13h)', ImageAssets.icHorse),
    Animal('Mùi', '(13-15h)', ImageAssets.icYang),
    Animal('Thân', '(15-17h)', ImageAssets.icMonkey),
    Animal('Dậu', '(17-19h)', ImageAssets.icChick),
    Animal('Tuất', '(19-21h)', ImageAssets.icDog),
    Animal('Hợi', '(21-23h)', ImageAssets.icPig),
  ];
}
