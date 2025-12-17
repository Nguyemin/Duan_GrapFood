class Product {
  int id;
  String title;
  dynamic price;
  String description; 
  String catergory;
  String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.catergory,
    required this.image,
  });
  factory Product.formJson(Map<String, dynamic> json){
    return Product(
      id: json['id']?? 0,
      title: json['title']??'',
      price: json['price']?? 0,
      description: json['description']??'',
      catergory: json['catergory']??'',
      image: json['image']??'',
    );
  }
}