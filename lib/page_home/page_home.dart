import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../page_images/page_images.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with SingleTickerProviderStateMixin {

  final List<Tab> tabs = <Tab>[
    const Tab(text: "Backgrounds"),
    const Tab(text: "Fashion"),
    const Tab(text: "Nature"),
    const Tab(text: "Science"),
    const Tab(text: "Education"),
  ];

  TabController? tabController;
  List listImages = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Lottie.asset(
              'assets/raw_download.json',
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Wallpaper Download',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff201f1f)
              ),
            ),
          ],
        ),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: const Color(0xff201f1f),
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          indicator: const BubbleTabIndicator(
            indicatorHeight: 25,
            indicatorColor: Color(0xfffde568),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: tabs.map((Tab tab) {
          return PageImages(
            strKategori: tab.text!.toLowerCase(),
          );
        }).toList(),
      ),
    );
  }
}
