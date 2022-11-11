import 'package:places/domain/category.dart';
import 'package:places/presets/icons/icons.dart';
import 'package:places/presets/strings/app_strings.dart';

final List<Category> categories = [
  Category(name: AppStrings.caregoriesHotel, icon: AppIcons.hotel),
  Category(name: AppStrings.caregoriesRestourant, icon: AppIcons.restourant),
  Category(
    name: AppStrings.caregoriesParticularPlace,
    icon: AppIcons.particularPlace,
  ),
  Category(name: AppStrings.caregoriesPark, icon: AppIcons.park),
  Category(name: AppStrings.caregoriesMuseum, icon: AppIcons.museum),
  Category(name: AppStrings.caregoriesCafe, icon: AppIcons.cafe),
  Category(name: AppStrings.caregoriesCity, icon: AppIcons.heart),
  Category(name: AppStrings.caregoriesVinery, icon: AppIcons.search),
  Category(name: AppStrings.caregoriesMonastery, icon: AppIcons.map),
];
