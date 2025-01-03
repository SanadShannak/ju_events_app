// function randomly return image path from 'event_card_images_by_index'
import 'dart:math';

class RandomImageGenerator {
  static Random random = Random();
  static String getRandomEventImagePath() {
    String randomPath = '${random.nextInt(4)}.jpeg';
    return randomPath;
  }

  static String getRandomInstitutionalUnitImagePath() {
    String randomPath = '${random.nextInt(5)}.jpg';
    return randomPath;
  }
}
