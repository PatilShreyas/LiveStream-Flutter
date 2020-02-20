library livestream;

import 'dart:collection';

/// Abstract/Interface for LiveStream.
abstract class _ILiveStream {
  void emit(String stream, var value);
  void on(String stream, void Function(Object) callback);
  void getValue(String stream);
}

/// LiveStream is a class which can be used to share data values among different modules in your application.
/// It makes easy to provide communication among different parts of your application.
/// It's a data holder class which can be created and used anywhere in application.
/// By using it, You can emit values to any stream with data value from anywhere in the application.
/// Observers will receive data events when the value of subscribed stream is updated.
class LiveStream implements _ILiveStream {
  _DataStore _mStorage = _DataStore.getInstance();

  /// Sets a new value [value] to the data stream [stream]. 
  /// If there are active subscribers, the value will be dispatched to them.
  @override
  void emit(String stream, var value) {
    _mStorage?.setValue(stream, value);
  }

  /// Subscribes to the given stream [stream].
  /// If stream already has data set, it will be delivered to the [callback] function.
  @override
  void on(String stream, void Function(Object) callback) {
    _mStorage?.setCallback(stream, callback);
  }

  /// Returns the current value of a given data [stream].
  @override
  Object getValue(String stream) {
    return _mStorage?.getValue(stream);
  }
}

// Storage class for LiveStream.
class _DataStore {
  // Singleton Instance for DataStore
  static _DataStore _instance;

  // Map instance to store data values with data stream.
  HashMap<String, _DataItem> _mDataItemsMap;

  _DataStore._init() {
    _mDataItemsMap = new HashMap();
  }

  // Sets/Adds the new value to the given key.
  void setValue(String key, var value) {

    // Retrieve existing data item from map.
    _DataItem item = _mDataItemsMap[key];
    if (item == null) {
      item = _DataItem();
    }

    // Set new value to new/existing item.
    item.value = value;
    
    // Reset item to the map.
    _mDataItemsMap[key] = item;

    // Retrieve all the callback functions.
    Iterator<Function(Object)> callback = item.callbacks?.iterator;

    // Check if callback functions exists or not.
    if (callback != null) {

      // Iterate callback functions one by one.
      while (callback.moveNext()) {

        // Dispatch value to the callback.
        callback?.current(value);
      }
    }
  }

  // Sets/Adds the new callback to the given data stream.
  void setCallback(String key, Function(Object) callback) {
    if (callback != null) {

      // Retrieve existing data item from the map.
      _DataItem item = _mDataItemsMap[key];

      if (item == null) {
        item = _DataItem();
      }
      
      // Retrieve callback functions from data item.
      List<Function(Object)> callbacks = item.callbacks;

      // Check if callback functions exists or not.
      if (callbacks == null) {

        // If it's null then create new List.
        callbacks = new List();

        // Set callback functions list to data item.
        item.callbacks = callbacks;

        // Set the data item to the map.
        _mDataItemsMap[key] = item;
      }

      // Add the given callback into List of callback functions.
      callbacks.add(callback);

      // Dispatch value to the callback function if value already exists.
      if (item.value != null) {
        callback(item.value);
      }
    }
  }

  // Returns current value of the data stream.
  Object getValue(String key) {
    return _mDataItemsMap[key]?.value;
  }

  // Returns singleton instance of _DataStore
  static _DataStore getInstance() {
    if (_instance == null) {
      _instance = new _DataStore._init();
    }
    return _instance;
  }
}

// Data class to hold value and callback functions of a data stream.
class _DataItem {
  var value;
  List<Function(Object)> callbacks;
}
