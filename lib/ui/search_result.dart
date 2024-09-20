import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_finder/providers/image_provider.dart' as ip;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key});

  late ip.ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    imageProvider = Provider.of<ip.ImageProvider>(context, listen: false);
    String query = ModalRoute.of(context)?.settings.arguments as String;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Text(
            "Results for '$query'",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.green,
            thickness: .8,
            height: 16,
          ),
          Expanded(
            child: Consumer<ip.ImageProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: provider.getPhotos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.currentSelectedIndex = index;
                        showPreviewImage(context, provider);
                      },
                      child: CachedNetworkImage(
                        imageUrl: provider.photos[index].src!.medium.toString(),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void showPreviewImage(BuildContext parentContext, ip.ImageProvider provider) {
    showModalBottomSheet(
      context: parentContext,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text("Actions"),
                    actions: [
                      InkWell(
                        onTap: () async {
                          bool isDownloaded =
                              await provider.imageRepository.downloadImage(
                            provider.photos[provider.currentSelectedIndex].src!
                                .original
                                .toString(),
                          );
                          isDownloaded
                              ? ScaffoldMessenger.of(parentContext)
                                  .showSnackBar(const SnackBar(
                                      content:
                                          Text("Download image completed.")))
                              : ScaffoldMessenger.of(parentContext)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Download image failed. Please try again!")));
                        },
                        child: const ListTile(
                          title: Text("Download"),
                          leading: Icon(Icons.download),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text("Information"),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "ID: ${provider.getPhotos[provider.currentSelectedIndex].id}"),
                                        Text(
                                          "Url: ${provider.getPhotos[provider.currentSelectedIndex].url}",
                                        ),
                                        Text(
                                            "Height: ${provider.getPhotos[provider.currentSelectedIndex].height}"),
                                        Text(
                                            "Width: ${provider.getPhotos[provider.currentSelectedIndex].width}"),
                                      ],
                                    ));
                              });
                        },
                        child: const ListTile(
                          title: Text("Information"),
                          leading: Icon(Icons.info),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  pageController: PageController(
                      initialPage: provider.currentSelectedIndex),
                  onPageChanged: (index) {
                    provider.currentSelectedIndex = index;
                  },
                  itemCount: provider.getPhotos.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(
                          provider.photos[index].src!.original.toString()),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(
                          tag: provider.photos[index].id.toString()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
