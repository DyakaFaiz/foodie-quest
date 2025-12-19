import 'dart:io';
import 'package:flutter/material.dart';
import '../models/food_photo.dart';
import '../services/image_service.dart';

class PhotoProvider with ChangeNotifier {
  final ImageService _service = ImageService();

  List<FoodPhoto> _photos = [];
  List<FoodPhoto> get photos => _photos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  Future<void> fetchPhotos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _photos = await _service.getPhotos();
    } catch (e) {
      debugPrint("Error fetching photos: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> uploadPhoto(File imageFile, String caption) async {
    _isUploading = true;
    notifyListeners();
    try {
      final imageUrl = await _service.uploadImage(imageFile);
      if (imageUrl != null) {
        final newPhoto = await _service.savePhotoData(imageUrl, caption);
        _photos.insert(0, newPhoto!);
        _isUploading = false;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error uploading photo: $e");
      return false;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
