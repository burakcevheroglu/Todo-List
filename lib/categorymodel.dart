class CategoryModel{
  String title;
  int taskCount;

  CategoryModel({required this.title, this.taskCount = 1});

  static List<CategoryModel> Categories = [
    CategoryModel(title: "Business", taskCount: 20),
    CategoryModel(title: "Hobbies", taskCount: 18),
    CategoryModel(title: "Study", taskCount: 84),
    CategoryModel(title: "Crypto", taskCount: 16),
  ];

  static List<CategoryModel> get getCategories => Categories;

}