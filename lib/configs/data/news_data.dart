import 'package:core_news/configs/resources/app_strings.dart';

Map<String, String> getCategories() {
  Map<String, String> cats = <String, String>{};
  cats["General"] = appStrings.GENERAL_CATEGORY_KEY;
  cats["Sport"] = appStrings.SPORT_CATEGORY_KEY;
  cats["Health"] = appStrings.HEALTH_CATEGORY_KEY;
  cats["Science"] = appStrings.SCIENCE_CATEGORY_KEY;
  cats["Technology"] = appStrings.TECHNOLOGY_CATEGORY_KEY;
  cats["Business"] = appStrings.BUSINESS_CATEGORY_KEY;
  cats["Entertainment"] = appStrings.BINTERTAINMENT_CATEGORY_KEY;
  return cats;
}
