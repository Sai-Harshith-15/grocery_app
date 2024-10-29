class ApiRoutes {

  static const String baseUrl = 'https://fakestoreapi.com';
  static const String products = '$baseUrl/products';
  static const String categories = '$baseUrl/products/categories';
  static String productById(String id) => '$baseUrl/products/$id';
  
}
