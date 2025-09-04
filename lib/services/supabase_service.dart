import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class SupabaseService {
  static const String _supabaseUrl = 'https://dvscnclorvsrhkiurlpt.supabase.co';
  static const String _supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2c2NuY2xvcnZzcmhraXVybHB0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxNTk0NDYsImV4cCI6MjA3MDczNTQ0Nn0.LfMdRX-QSeDmeEEyCcb5lI7juh_ylHCjQ3HCDXj1UOQ';
  
  late SupabaseClient _supabase;

  Future<void> initialize() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
    _supabase = Supabase.instance.client;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String gender,
    required String university,
    required String graduationYear,
    required String course,
    String? profession,
    String? profileImage,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
          'gender': gender,
          'university': university,
          'graduation_year': graduationYear,
          'course': course,
          if (profession != null) 'profession': profession,
        },
      );

      if (response.user != null) {
        // Insert user profile data
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'name': name,
          'phone': phone,
          'gender': gender,
          'university': university,
          'graduation_year': graduationYear,
          'course': course,
          'profession': profession,
          'profile_image_url': profileImage,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        return true;
      }
      return false;
    } catch (e) {
      print('Sign up error: $e');
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user != null;
    } catch (e) {
      print('Sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      print('Get user profile error: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(String userId, Map<String, dynamic> data) async {
    try {
      await _supabase
          .from('profiles')
          .update({
            ...data,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      return true;
    } catch (e) {
      print('Update user profile error: $e');
      return false;
    }
  }

  Future<String?> updateProfileImage(String userId, String imageUrl) async {
    try {
      await _supabase
          .from('profiles')
          .update({
            'profile_image_url': imageUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      return imageUrl;
    } catch (e) {
      print('Update profile image error: $e');
      return null;
    }
  }

  Future<String?> uploadAvatarBytes(Uint8List data, String storagePath, {String contentType = 'image/png'}) async {
    try {
      final bucket = _supabase.storage.from('avatars');
      await bucket.uploadBinary(storagePath, data, fileOptions: FileOptions(upsert: true, contentType: contentType));
      final publicUrl = bucket.getPublicUrl(storagePath);
      return publicUrl;
    } catch (e) {
      print('Upload avatar error: $e');
      return null;
    }
  }

  Stream<AuthState> authStateChanges() {
    return _supabase.auth.onAuthStateChange;
  }
} 