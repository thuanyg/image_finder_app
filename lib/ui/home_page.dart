import 'package:flutter/material.dart';
import 'package:image_finder/ui/search_result.dart';
import 'package:provider/provider.dart';
import 'package:image_finder/providers/image_provider.dart' as ip;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7472E0),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Image Finder",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            Positioned(
              top: 200,
              left: 50,
              right: 50,
              child: Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 6),
                          blurRadius: 100)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black, height: 2),
                        decoration: const InputDecoration(
                          hintText: "Search image...",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          searchImage(context, _searchController.text.trim()),
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                        fixedSize: WidgetStatePropertyAll(Size(230, 10)),
                      ),
                      child: const Text(
                        "Search",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void searchImage(BuildContext context, String query) {
    Provider.of<ip.ImageProvider>(context, listen: false).photos.clear();
    Provider.of<ip.ImageProvider>(context, listen: false).searchImage(query, 1);
    showModalBottomSheet(
      routeSettings: RouteSettings(arguments: query),
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          height: MediaQuery.of(context).size.height * 0.88,
          width: double.maxFinite,
          child: SearchResultScreen(),
        );
      },
    );
  }
}
