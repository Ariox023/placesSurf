/// Строковые константы приложения
class AppStrings {
  static const String appTitle = 'Места';
  static const String searchField = 'Поиск';
  // Ключи боксов для хранения данных и ключи настроек
  static const String boxSights = 'box_for_Sights';

  static const String boxSettings = 'Settings';
  static const String boxSettingsTheme = 'Theme';
  static const String boxSettingsThemeLight = 'Light';
  static const String boxSettingsThemeDark = 'Dark';
  static const String boxSettingsLang = 'Language';
  static const String boxSettingsLangRu = 'ru_RU';
  static const String boxSettingsLangEn = 'en_US';

  // пути страниц
  static const String settingsScreen = '/settings';
  static const String maingsScreen = '/';
  static const String detailsScreen = '/details';
  static const String visitedScreen = '/vizited';
  static const String filtersScreen = '/filters';
  static const String tutorialScreen = '/tutorial';
  static const String addSightScreen = '/add_sight_screen';
  static const String categoriesScreen = '/categories';
  static const String mapScreen = '/map';
  static const String onboardingScreen = '/initial';
  static const String splashScreen = '/splash';
  static const String sightListScreen = '/list';

  // Настройки для отбора мест сохраненные в Hivev
  static const String boxFilters = 'Filters';
  static const String boxFiltersCategories = 'Categories';
  static const String boxFiltersRangeMin = 'RangeMin';
  static const String boxFiltersRangeMax = 'RangeMax';
  static const String boxFiltersListCategories = 'ListCategories';

  /// Заголовки экранов
  static const String scrTitleSightListScreen = 'Список интересных мест';
  static const String scrTimeDetailScreen = 'закрыто до 09:00';
  static const String scrButtonDetailScreen = 'ПОСТРОИТЬ МАРШРУТ';
  static const String scrMenyCalendarDetailScreen = 'Запланировать';
  static const String scrMenyFavoritDetailScreen = 'В Избранное';
  static const String scrTitleVisitingScreen = 'Избранное';
  static const String scrTabBarViewVisitingScreen1 = 'Хочу посетить';
  static const String scrTabBarViewVisitingScreen2 = 'Посетил';
  static const String scrTabBarViewEmptyBody = 'Пусто';
  static const String scrTabBarViewLikedEmptyBody =
      'Отмечайте понравившиеся места и они появятся здесь.';
  static const String scrTabBarViewVisitedEmptyBody =
      'Завершите маршрут, чтобы место попало сюда.';
  static const String scrSightListScreenEmptyBodySubtitle =
      'Ничего не найдено.';
  static const String scrSightListScreenEmptyBodySubtitle2 =
      'Попробуйте изменить параметры поиска.';

  static const String scrFiltersScreen = 'КАТЕГОРИИ';
  static const String scrFiltersScreenRange = 'Расстояние';
  static const String scrSettingsScreen = 'Настройки';
  static const String scrAddSightScreen = 'Новое место';

  // Категории интересных мест
  static const String caregoriesHotel = 'Отель';
  static const String caregoriesRestourant = 'Ресторан';
  static const String caregoriesParticularPlace = 'Особое место';
  static const String caregoriesPark = 'Парк';
  static const String caregoriesMuseum = 'Музей';
  static const String caregoriesCafe = 'Кафе';
  static const String caregoriesCity = 'Город';
  static const String caregoriesVinery = 'Винный погреб';
  static const String caregoriesMonastery = 'Монастырь';

  // перевод
  static const String scrFirstSettingsScreenLan = 'Язык: ';
  static const String scrFirstSettingsScreenLanRu = 'Русский';
  static const String scrFirstSettingsScreenLanEn = 'English';

  static const String scrFirstSettingsScreenThema = 'Темная тема';
  static const String scrFirstSettingsScreenInfo = 'Смотреть туториал';

  static const String scrOnboardingScreenState = 'Смотреть туториал';
  // Кнопки
  static const String buttonClear = 'Очистить';
  static const String buttonFill = 'Заполнить';
  static const String buttonCancellation = 'Отмена';
  static const String buttonSave = 'Сохранить';
  static const String buttonSkip = 'Пропустить';

  // Строки Экрана добавления нового места.
  static const String scrAddSightScreenCategory = 'Категория';
  static const String scrAddSightScreenEmptyCategory = 'Не выбрано';
  static const String scrAddSightScreenCategoryError = 'Нет такой категории';
  static const String scrAddSightScreenCategoryError2 =
      'Категория должна быть заполнена.';
  static const String scrAddSightScreenName = 'НАЗВАНИЕ';
  static const String scrAddSightScreenNameError =
      'В списке интересных мест уже есть имя';
  static const String scrAddSightScreenNameError2 =
      'Имя интересного места должно быть заполнено.';
  static const String scrAddSightScreenMapLat = 'ШИРОТА';
  static const String scrAddSightScreenMapEmptyLat =
      'Широта должна быть заполнена.';
  static const String scrAddSightScreenMapErrorLat =
      'Должно быть между -90 и 90.';
  static const String scrAddSightScreenMapLong = 'ДОЛГОТА';
  static const String scrAddSightScreenMapEmptyLong =
      'Долгота должна быть заполнена.';
  static const String scrAddSightScreenMapErrorLong =
      'Должно быть между -180 и 180.';
  static const String scrAddSightScreenGoToMap = 'Указать на карте';
  static const String scrAddSightScreenDescription = 'ОПИСАНИЕ';
  static const String scrAddSightScreenDescriptionError =
      'Описание должно быть заполнено.';
  static const String scrAddSightScreenDescriptionHint = 'Введите текст';
  static const String scrMapNewSight = 'Новое интересное место.';
  static const String scrMapNewSightAddImageTitle = 'Введите адрес изображения';
  static const String scrMapNewSightAddImageCamera = 'Камера';
  static const String scrMapNewSightAddImagePhoto = 'Фотография';
  static const String scrMapNewSightAddImageFail = 'Файл';

  // Строки Начального экрана.
  static const String scrOnboardingScreenFirstPage1 =
      'Добро пожаловать в Путеводитель';
  static const String scrOnboardingScreenFirstPage2 =
      'Ищи новые локации и сохраняй самые любимые.';
  static const String scrOnboardingScreenSecondPage1 =
      'Построй маршрут и отправляйся в путь';
  static const String scrOnboardingScreenSecondPage2 =
      'Достигай цели максимально быстро и комфортно.';
  static const String scrOnboardingScreenThirdPage1 =
      'Добавляй места, которые нашёл сам';
  static const String scrOnboardingScreenThirdPage2 =
      'Делись самыми интересными и помоги нам стать лучше!';
  static const String scrOnboardingScreenThirdPageButton = 'На старт';

  AppStrings._();
}
