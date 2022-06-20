/// Static variables for all urls used in the app
class ApiConstants {
  static String baseUrl = "http://127.0.0.1:3333";
  static String imageBaseaseUrl = "http://192.168.10.65:3000/public/";
  static String loginUrl = baseUrl + "/users/login";
  static String notificationUrl = baseUrl + "/notification";
  static String setCooked = baseUrl + "/setCooked/";

  static String signupUrl = baseUrl + "users/signup";
  static String forgotPassword = baseUrl + "users/forgotPassword";
  static String changePassword = baseUrl + "users/verifyCode";

  static String getOrders = baseUrl + "/fetchAll";
  static String getTransaction = baseUrl + "expense/";
  static String createOrder = baseUrl + "/order";
  static String order = baseUrl + "/orderForTable";
  static String updateOrder = baseUrl + "/updateOrder";
  static String getBudgets = baseUrl + "budget";
  static String fetchProducts = baseUrl + "/fetch_items_by_category";
}
