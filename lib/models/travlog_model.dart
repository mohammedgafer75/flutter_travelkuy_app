class TravlogModel {
  String? name;
  String? content;
  String? place;
  String? image;

  TravlogModel(this.name, this.content, this.place, this.image);
}

List<TravlogModel> travlogs = travlogsData
    .map((item) => TravlogModel(
        item['name'], item['content'], item['place'], item['image']))
    .toList();

var travlogsData = [
  {
    "name": "\"مروي!\"",
    "content":
        "لمدينة التي تمثل حاضرة أهل السودان القدماء في منطقة الشمال وتربط بين السودان وجنوب منطقة النوبة",
    "place": "مروي, ولاية الشمالية",
    "image": "assets/images/أهرامات-كوفر-.jpg"
  },
  {
    "name": "\"الأُبَيِّض!\"",
    "content":
        "لأُبَيِّض (بضم الهمزة على الألف وتشديد كسرة الياء) مدينة تقع في وسط ولاية شمال كردفان في السودان!",
    "place": "الأُبَيِّض, شمال كردفان",
    "image": "assets/images/image002.jpg"
  },
  {
    "name": "\"جبل مرة!\"",
    "content":
        " تقع في ولاية وسط دارفور في إقليم دارفور في السودان ، وتسكنها قبائل الفور،...",
    "place": "جبل مرة, جنوب دارفور",
    "image": "assets/images/-نيالا-في-السودان-e1561553445414.jpg"
  },
  /*{
    "name": "\"كسلا!\"",
    "content":
        "تقع مدينة كسلا حاضرة الولاية على ارتفاع 496 متر فوق مستوى سطح البحر",
    "place": " شرق السودان, كسلا",
    "image": "assets/images/FB_IMG_1648013722935.jpg"
  },*/
  {
    "name": "\" كاَدُقْلِي !\"",
    "content":
        " تقع في ولاية وسط دارفور في إقليم دارفور في السودان ، وتسكنها قبائل الفور،...",
    "place": " كاَدُقْلِي, جنوب كردفان ",
    "image": "assets/images/6c21f000fac35192633bba9e5f877b90-780x405.jpg"
  },
  {
    "name": "\"الشماليه!\"",
    "content":
        "ومساحة الولاية 348,765 كم2 وعاصمتها مدينة دنقلا. يقدر عدد سكان الولاية بحوالي 667 ألف نسمة !",
    "place": "الشماليه, شمال السودان ",
    "image": "assets/images/بحث-عن-نهر-النيل-وأهميته.jpg"
  },
];
