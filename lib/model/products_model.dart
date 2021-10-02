const String products = 'products';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, name, category, price, brand, image,
  ];

  static const String id = '_id';
  static const String price = 'price';
  static const String name = 'name';
  static const String category = 'category';
  static const String brand = 'brand';
  static const String image = 'image';
}

class Product {
  final int? id;

  final int price;
  final String name;
  final String category;
  final String brand;
  final String image;

  const Product({
    this.id,
    required this.price,
    required this.name,
    required this.category,
    required this.brand,
    required this.image,
  });

  Product copy({
    int? id,
    int? price,
    String? name,
    String? category,
    String? brand,
    String? image,
  }) =>
      Product(
        id: id ?? this.id,
        price: price ?? this.price,
        name: name ?? this.name,
        category: category ?? this.category,
        brand: brand ?? this.brand,
        image: image ?? this.image,
      );

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[ProductFields.id] as int?,
        price: json[ProductFields.price] as int,
        name: json[ProductFields.name] as String,
        category: json[ProductFields.category] as String,
        brand: json[ProductFields.brand] as String,
        image: json[ProductFields.image] as String,
      );

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.name: name,
        ProductFields.price: price,
        ProductFields.category: category,
        ProductFields.brand: brand,
        ProductFields.image: image,
      };
}
