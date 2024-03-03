import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefenceBrain {
  //initialise shared preference
  Future<SharedPreferences> sharedPref() async {
    return await SharedPreferences
        .getInstance(); //returns an instance of SharedPreferences.
  }

  //save int value
  void setIntValue(String key, int value) async {
    await sharedPref().then(
      (SharedPreferences prefs) => prefs.setInt(key, value),
    ); //saves an int value to the key.
  }

  void setDoubleValue(String key, double value) async {
    await sharedPref().then(
      (SharedPreferences prefs) => prefs.setDouble(key, value),
    ); //saves an int value to the key.
  }

  void setStringValue(String key, String value) async {
    await sharedPref().then(
      (SharedPreferences prefs) => prefs.setString(key, value),
    ); //saves an int value to the key.
  }

  void setListValue(String key, List<String> value) async {
    await sharedPref().then(
      (SharedPreferences prefs) => prefs.setStringList(key, value),
    ); //saves an int value to the key.
  }

  //read the data
  void getIntValue(String key) async {
    return await sharedPref().then(
      (SharedPreferences prefs) => prefs.getInt(key), //returns an int value.
    );
  }

  void getDoubleValue(String key) async {
    return await sharedPref().then(
      (SharedPreferences prefs) => prefs.getDouble(key), //returns an int value.
    );
  }

  void getStringValue(String key) async {
    return await sharedPref().then(
      (SharedPreferences prefs) => prefs.getString(key),
    );
  }

  void getListValue(String key) async {
    return await sharedPref().then(
      (SharedPreferences prefs) => prefs.getStringList(key), //returns an int value.
    );
  }

  //remove the data
  void removeValue(String key) async {
    await sharedPref().then(
      (SharedPreferences prefs) => prefs.remove(key), //removes the key-value pair.
    );
  }
}
