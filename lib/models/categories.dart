
class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categoriesList = [
  Category(
    title: "All",
    image: "images/all.png",
  ),
  Category(
    title: "Electronics",
    image: "images/shoes.png",
  ),
  Category(
    title: "Groceries",
    image: "images/beauty.png",
  ),
  Category(
    title: "Furniture",
    image: "images/image1.png",
  ),
  Category(
    title: "Kitchenware",
    image: "images/jewelry.png",
  ),
  Category(
    title: "Fitness",
    image: "images/men.png",
  ),
];
