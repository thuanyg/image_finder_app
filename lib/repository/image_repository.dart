import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_finder/models/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageRepository {
  final dio = Dio();

  Future<Image?> searchImages(String query, int page) async {
    try {
      Response response = await dio.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=50",
        options: Options(
          headers: {
            "Authorization":
                "txzjoTA0DIzLgOkaLBZv4r0X0O9fc20bEpkYenpeBebkkgQS5QW7LuOm"
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return Image.fromJson(data);
      }

      return null;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<bool> downloadImage(String imgUrl) async {
    try {
      bool permissionGranted = false;

      // Check for Android version
      if (Platform.isAndroid) {
        if (await Permission.storage.isGranted) {
          // Permission already granted
          permissionGranted = true;
        } else {
          // Request storage permission based on Android version
          if (await Permission.storage.request().isGranted) {
            permissionGranted = true;
          } else if (await Permission.manageExternalStorage
              .request()
              .isGranted) {
            permissionGranted = true;
          } else {
            print('Storage permission not granted');
            return false;
          }
        }
      } else if (Platform.isIOS) {
        // For iOS, request permission if necessary
        var status = await Permission.photos.request();
        if (status.isGranted) {
          permissionGranted = true;
        } else {
          print('Photos permission not granted on iOS');
        }
      }

      if (permissionGranted) {
        var pathInStorage = await getApplicationDocumentsDirectory();
        String fullPath = '${pathInStorage.path}/sampleimage.jpg';
        print(fullPath);

        await Dio().download(
          imgUrl,
          fullPath,
          onReceiveProgress: (count, total) {
            if (count == total) {
              print('Downloading Completed');
            }
          },
        );

        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }
}
