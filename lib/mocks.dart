import 'package:places/domain/sight.dart';
import 'package:places/presets/strings/app_strings.dart';

final List<Sight> mocks = [
  Sight(
    name: 'Кишинёв',
    type: AppStrings.caregoriesCity,
    details: 'Cтолица и крупнейший город Молдавии.',
    lat: 47.0264,
    lon: 28.8404,
    url: [
      'https://upload.wikimedia.org/wikipedia/commons/6/6b/Vorota_kishineva.jpg',
      'https://static.locals.md/2016/10/2-1.jpg',
      'https://img.gazeta.ru/files3/647/14159647/upload-Depositphotos_225200244_XL-pic_32ratio_900x600-900x600-84617.jpg',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/a6/1a/0a/triumphal-arch.jpg?w=700&h=-1&s=1',
      'https://i.simpalsmedia.com/point.md/news/thumbnails/large/c19c95caf3d9a2d6a9ed49083458b000.jpg',
    ],
  ),
  Sight(
    name: 'Бельцы',
    type: AppStrings.caregoriesCity,
    details:
        'Важнейший транспортный узел севера Молдавии, в состав которого входят две железнодорожные станции.',
    lat: 47.75262016556979,
    lon: 27.917615622282028,
    url: ['http://www.prospect.md/images/gallery/belicy-moldova-8462-1.jpg'],
  ),
  Sight(
    name: 'Орхей',
    type: AppStrings.caregoriesCity,
    details: 'Город и муниципий в Молдавии, центр Оргеевского района.',
    lat: 47.37750267673351,
    lon: 28.823907896876335,
    url: ['https://newsmaker.md/wp-content/uploads/2020/01/3-6-1024x681.jpg'],
  ),
  Sight(
    name: 'Старый Орхей',
    type: AppStrings.caregoriesMuseum,
    details:
        'Историко-археологический комплекс, расположенный в 60 км к северо-востоку от Кишинёва, на реке Реут.',
    lat: 47.306441463915256,
    lon: 28.941984102129936,
    url: ['https://fs.tonkosti.ru/0x/pt/0xptwn0803mokc40o8sgwck48.jpg'],
  ),
  Sight(
    name: 'Единцы',
    type: AppStrings.caregoriesCity,
    details: 'Город и муниципий в Молдавии, центр Единéцкого района.',
    lat: 48.161546843606565,
    lon: 27.293590307235718,
    url: ['https://static.locals.md/2016/11/Edinet_1.jpg'],
  ),
  Sight(
    name: 'Рези́на',
    type: AppStrings.caregoriesCity,
    details: 'Город в Молдавии, центр Резинского района.',
    lat: 47.74736114224474,
    lon: 28.970455415546898,
    url: [
      'http://images2.moldovatrans.com/tur/imgbank/locations/20140424152313910.jpg',
    ],
  ),
  Sight(
    name: 'Замок “Mimi”',
    type: AppStrings.caregoriesVinery,
    details:
        'Замок Мими в настоящее время входит в число самых красивых архитектурных шедевров в мире вина.',
    lat: 46.892114278080825,
    lon: 29.291635528206825,
    url: [
      'https://www.deltalight.com/frontend/files/projects/images/source/003002_REA01.jpg',
    ],
  ),
  Sight(
    name: 'Монастырь Кэприяна',
    type: AppStrings.caregoriesMonastery,
    details:
        'В живописных Кодрах, в 40 км к северо-западу от Кишинева, расположен один из самых старинных монастырей Молдовы Каприяна. Дата основания монастыря 1429 год.',
    lat: 47.116018,
    lon: 28.5115,
    url: [
      'http://aerotourmd.com/images/moldova/religious-tourism/capriana.jpg',
    ],
  ),
];
