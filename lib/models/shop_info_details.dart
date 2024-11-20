class ShopInfoDetails {
  static String? shopName;
  static String? email;
  static String? address;
  static String? phoneNumber;
  static String? uploadImageUrl;

  static void saveDetails({
    required String shopNameInput,
    required String emailInput,
    required String addressInput,
    required String phoneNumberInput,
    String? imageUrlInput,
  }) {
    shopName = shopNameInput;
    email = emailInput;
    address = addressInput;
    phoneNumber = phoneNumberInput;
    uploadImageUrl = imageUrlInput;
  }

  static Map<String, String?> getDetails() {
    return {
      'shopName': shopName,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'uploadImageUrl': uploadImageUrl,
    };
  }

  // Clear details
  static void clearDetails() {
    shopName = null;
    email = null;
    address = null;
    phoneNumber = null;
    uploadImageUrl = null;
  }
}
