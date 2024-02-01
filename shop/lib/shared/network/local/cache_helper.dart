//==========================================================================================================================================================
// This file contains the CacheHelper class, which provides methods for managing data in shared preferences.

import 'package:shared_preferences/shared_preferences.dart'; 

//==========================================================================================================================================================

// A helper class to manage caching data using shared preferences.
class CacheHelper {
  static late SharedPreferences sharedPre; // A static instance of SharedPreferences.

  // Method to initialize SharedPreferences.
  static init() async {
    sharedPre = await SharedPreferences.getInstance(); // Initialize shared preferences.
  }

//==========================================================================================================================================================

  // Method to store boolean data in shared preferences.
  static Future<bool> putData({
    required String key,
    required bool value,
  }) async {
    return await sharedPre.setBool(key, value); // Store boolean data.
  }

//==========================================================================================================================================================

  // Method to retrieve data from shared preferences.
  static dynamic getData({
    required String key,
  }) {
    return sharedPre.get(key); // Retrieve data associated with the given key.
  }

//==========================================================================================================================================================

  // Method to save data of various types in shared preferences.
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    // Determine the type of value and store accordingly.
    if (value is String) return await sharedPre.setString(key, value); // Store string data.
    if (value is int) return await sharedPre.setInt(key, value); // Store integer data.
    if (value is bool)return await sharedPre.setBool(key, value); // Store boolean data.

    
    return await sharedPre.setDouble(key, value); // Store double data by default.
  }

//==========================================================================================================================================================

  // Method to remove data associated with a given key from shared preferences.
  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPre.remove(key); // Remove data associated with the given key.
  }

//==========================================================================================================================================================
}

//==========================================================================================================================================================
