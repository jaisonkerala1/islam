import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static const String connectionString = 'mongodb://localhost:27017/islamic_app';
  static Db? _db;
  static bool _isConnected = false;

  // Collections
  static const String usersCollection = 'users';
  static const String prayersCollection = 'prayers';
  static const String coursesCollection = 'courses';
  static const String discussionsCollection = 'discussions';
  static const String productsCollection = 'products';

  static Future<void> connect() async {
    try {
      if (_isConnected) return;

      _db = await Db.create(connectionString);
      await _db!.open();
      _isConnected = true;

      print('Connected to MongoDB successfully');
    } catch (e) {
      print('Failed to connect to MongoDB: $e');
      // In production, implement proper error handling
    }
  }

  static Future<void> disconnect() async {
    if (_db != null && _isConnected) {
      await _db!.close();
      _isConnected = false;
      print('Disconnected from MongoDB');
    }
  }

  static DbCollection getCollection(String collectionName) {
    if (_db == null || !_isConnected) {
      throw Exception('Database not connected. Call connect() first.');
    }
    return _db!.collection(collectionName);
  }

  // User operations
  static Future<Map<String, dynamic>?> findUserByPhone(String phoneNumber) async {
    try {
      final collection = getCollection(usersCollection);
      return await collection.findOne(where.eq('phoneNumber', phoneNumber));
    } catch (e) {
      print('Error finding user: $e');
      return null;
    }
  }

  static Future<bool> createUser(Map<String, dynamic> userData) async {
    try {
      final collection = getCollection(usersCollection);
      await collection.insert(userData);
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  static Future<bool> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      final collection = getCollection(usersCollection);
      await collection.update(
        where.eq('_id', ObjectId.fromHexString(userId)),
        modify.set('updatedAt', DateTime.now()).set('data', updates),
      );
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Prayer data operations
  static Future<List<Map<String, dynamic>>> getPrayerTimes(String userId) async {
    try {
      final collection = getCollection(prayersCollection);
      return await collection.find(where.eq('userId', userId)).toList();
    } catch (e) {
      print('Error getting prayer times: $e');
      return [];
    }
  }

  // Course operations
  static Future<List<Map<String, dynamic>>> getAllCourses() async {
    try {
      final collection = getCollection(coursesCollection);
      return await collection.find().toList();
    } catch (e) {
      print('Error getting courses: $e');
      return [];
    }
  }

  // Discussion operations
  static Future<List<Map<String, dynamic>>> getDiscussions({int limit = 20}) async {
    try {
      final collection = getCollection(discussionsCollection);
      return await collection.find(where.limit(limit).sortBy('createdAt', descending: true)).toList();
    } catch (e) {
      print('Error getting discussions: $e');
      return [];
    }
  }

  static Future<bool> createDiscussion(Map<String, dynamic> discussionData) async {
    try {
      final collection = getCollection(discussionsCollection);
      discussionData['createdAt'] = DateTime.now();
      await collection.insert(discussionData);
      return true;
    } catch (e) {
      print('Error creating discussion: $e');
      return false;
    }
  }

  // Product operations
  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final collection = getCollection(productsCollection);
      return await collection.find().toList();
    } catch (e) {
      print('Error getting products: $e');
      return [];
    }
  }
}



