class Product {
  final int id;
  final String name;
  final String? description;
  final bool isActive;

  const Product({
    required this.id,
    required this.name,
    this.description,
    this.isActive = true,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id: j['id'] as int,
        name: j['name'] as String,
        description: j['description'] as String?,
        isActive: j['isActive'] as bool? ?? true,
      );
}

class CreateProductRequest {
  final String name;
  final String? description;
  final bool isActive;

  const CreateProductRequest({
    required this.name,
    this.description,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        if (description != null) 'description': description,
        'isActive': isActive,
      };
}

class UpdateProductRequest {
  final String? name;
  final String? description;
  final bool? isActive;

  const UpdateProductRequest({this.name, this.description, this.isActive});

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (isActive != null) 'isActive': isActive,
      };
}
