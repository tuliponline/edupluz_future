class ApiPath {
  static const String getProducts = "/catalog/product/v1/products";
  static const String getCategories = "/catalog/category/v1/categories";
  static const String getBrands = "/catalog/brand/v1/brands";
  static const String coupons = "/marketing/coupon/v1/coupons";
  static const String flashSale = "/marketing/flashsale/v1/flashsales";

  static const String cart = "/order/cart/v1/carts";
  static const String orders = "/order/order/v1/orders";
  static const String users = "/customer/user/v1/users";

  //auth
  static const String register = "/account/auth/v1/auth/register";
  static const String verifyOtp = "/account/auth/v1/auth/register/otp/verify";
  static const String resendOtp = "/account/auth/v1/auth/email/resend";
  static const String login = "/account/auth/v1/auth/login";
  static const String refreshToken = '/account/auth/v1/auth/refresh';

  //account
  static const String user = "/account/user/v1/user";
  static const String addresss = "/account/address/v1/addresses";
}
