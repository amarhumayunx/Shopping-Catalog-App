class ApiConstants {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  
  static String productEndpoint(int id) => '/products/$id';
}

class StorageKeys {
  static const String favorites = 'favorites';
  static const String cart = 'cart';
}

