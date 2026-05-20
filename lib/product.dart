import 'dart:convert';

class Product {
  int id;
  String name;
  String image;
  double price;

  // Danh sach san pham mac dinh
  static List<Product> products = [
    Product(id: 1, name: 'Laptop Dell XPS 15', image: 'dell.png', price: 32000000),
    Product(id: 2, name: 'iPhone 15 Pro', image: 'iphone.png', price: 28000000),
    Product(id: 3, name: 'Samsung Galaxy S24', image: 'samsung.png', price: 20000000),
    Product(id: 4, name: 'Sony WH-1000XM5', image: 'sony.png', price: 7500000),
    Product(id: 5, name: 'Apple Watch Series 9', image: 'apple_watch.png', price: 11000000),
  ];

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Factory: tao Product tu mot Map JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
    );
  }

  // Chuyen Product thanh Map JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }

  // Them san pham vao danh sach
  static void add(Product product) {
    products.add(product);
  }

  // Sua san pham theo id
  static void edit(int id, String newName, String newImage, double newPrice) {
    for (var p in products) {
      if (p.id == id) {
        p.name = newName;
        p.image = newImage;
        p.price = newPrice;
        return;
      }
    }
    print('Khong tim thay san pham co id = $id');
  }

  // Tim kiem theo ten (khong phan biet hoa thuong)
  static List<Product> searchByName(String keyword) {
    return products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  // Tim kiem theo khoang gia
  static List<Product> searchByPriceRange(double min, double max) {
    return products.where((p) => p.price >= min && p.price <= max).toList();
  }

  // Tim san pham theo id
  static Product? findById(int id) {
    for (var p in products) {
      if (p.id == id) return p;
    }
    return null;
  }

  // Tang gia tat ca san pham len 10% - dung declarative (map)
  static List<Product> increasePrice() {
    return products.map((p) => Product(
      id: p.id,
      name: p.name,
      image: p.image,
      price: p.price * 1.1,
    )).toList();
  }

  // Xoa san pham theo id
  static void delete(int id) {
    products.removeWhere((p) => p.id == id);
    print('Da xoa san pham co id = $id');
  }

  // Tao danh sach Product tu JSON string
  static List<Product> fromJsonList(String jsonString) {
    List<dynamic> list = jsonDecode(jsonString);
    return list.map((item) => Product.fromJson(item)).toList();
  }

  // Sắp xếp theo giá
  static void sortByPrice(bool ascending) {
    products.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
  }

  // In toan bo danh sach
  static void printAll() {
    for (var p in products) {
      print(p);
    }
  }
}

void main() {
  Product.add(Product(
      id: 1, name: "iPhone 17 màu bạch kim", image: "iphone17.png", price: 2500));

  Product.add(Product(
      id: 6, name: "Samsung S24 ultra", image: "s24.png", price: 2200));

  print("=== Product List ===");
  Product.printAll();

  print("\n=== Search 'iphone' ===");
  var result = Product.searchByName("iphone");
  result.forEach(print);

  print("\n=== Find Product id 1 ===");
  print(Product.findById(1));

  // Edit sử dụng id=1 thay cho P001, truyền từng tham số
  Product.edit(1, "iPhone 15 Pro", "iphone20.png", 3000);

  print("\n=== After Edit ===");
  Product.printAll();
  
  Product.products = Product.increasePrice();

  print("\n=== After Increase Price 10% ===");
  Product.printAll();

  Product.sortByPrice(true);
  print("\n=== Ascending ===");
  Product.printAll();

  Product.sortByPrice(false);
  print("\n=== Descending ===");
  Product.printAll();
}
