import 'package:flutter/material.dart';
import '../model/model_home.dart';
import '../page_view/page_view.dart';
import '../service/network_service.dart';

class PageImages extends StatelessWidget {

  final String strKategori;

  const PageImages({super.key, required this.strKategori});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ModelHome>>(
        future: NetworkService.fetchNews(strKategori),
        builder: (context, snapshot) {
          final listData = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xfffde568))
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Ups, Error!", style: TextStyle(
                  color: Color(0xff201f1f),
                  fontSize: 24,
                  fontWeight: FontWeight.bold)
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: listData!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (1 / .6),
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageViews(
                            strKategori: snapshot.data![index].downloadURL.toString(),
                            strThumbUser: snapshot.data![index].thumdUser.toString(),
                            strType: snapshot.data![index].typeImages.toString(),
                            strTags: snapshot.data![index].tagsImages.toString(),
                            strUsername: snapshot.data![index].userName.toString(),
                          )
                      )
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data![index].previewURL.toString()),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
