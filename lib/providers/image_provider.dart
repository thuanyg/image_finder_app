import 'package:flutter/material.dart';
import 'package:image_finder/models/image.dart' as ImageModel;
import 'package:image_finder/repository/image_repository.dart';

class ImageProvider extends ChangeNotifier {
  List<ImageModel.Photo> photos = [];
  int currentSelectedIndex = 0;
  int currentPage = 1;
  bool isLoading = false;

  ImageRepository imageRepository;

  ImageProvider(this.imageRepository);

  List<ImageModel.Photo> get getPhotos => photos;

  Future<void> searchImage(String query, int page) async {
    isLoading = true;
    notifyListeners();
    final image = await imageRepository.searchImages(query, page);
    if (image != null) photos.addAll(image.photos);
    isLoading = false;
    notifyListeners();
  }


}
