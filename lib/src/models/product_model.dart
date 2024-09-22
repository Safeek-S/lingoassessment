class ProductModel {
  int? id;
  String? title;
  String? description;
  double? price;
  double? discountPercentage;
  List<String>? images;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];

    // Handle price (can be int, double, or String)
    price = _parseToDouble(json['price']);

    // Handle discountPercentage (can be int, double, or String)
    discountPercentage = _parseToDouble(json['discountPercentage']);

    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'images': images,
    };
  }

  // Utility function to parse a value into double
  double? _parseToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble(); // Convert int to double
    } else if (value is double) {
      return value; // Already a double
    } else if (value is String) {
      return double.tryParse(value); // Try to parse a String to double
    }
    return null; // Return null if the value is not convertible
  }
}

extension ProductModelExtension on ProductModel {
  double getDiscountedPrice() {
    if (price != null && discountPercentage != null && discountPercentage! > 0) {
      return price! - (price! * discountPercentage! / 100);
    }
    return price ?? 0; 
  }
}
