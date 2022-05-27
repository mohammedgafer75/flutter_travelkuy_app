class CarouselModel {
  String? image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image'])).toList();

var carouselsData = [
  {"image": "assets/images/أهرامات-كوفر-.jpg"},
  {"image": "assets/images/548d3192948f89fc8f1a78e2fd01fc44.jpg"},
  {"image": "assets/images/19_2017-636347037195631221-563.jpg"},
];
