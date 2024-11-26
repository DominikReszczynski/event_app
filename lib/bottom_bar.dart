import 'package:event_app/global.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: mainGrey,
      currentIndex: _mapEnumToIndex(currentSite.value),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 35,
          ),
          label: 'Śląskie',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.article_outlined,
            size: 35,
          ),
          label: 'Aktualności',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.event_outlined,
            size: 35,
          ),
          label: 'Wydarzenia',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.explore_outlined,
            size: 35,
          ),
          label: 'Eksploruj',
        ),
      ],
      onTap: (index) {
        setState(() {
          currentSite.value = _mapIndexToEnum(index);
        });
      },
    );
  }

  // Mapping enum to index
  int _mapEnumToIndex(MainViews view) {
    switch (view) {
      case MainViews.slask:
        return 0;
      case MainViews.news:
        return 1;
      case MainViews.events:
        return 2;
      case MainViews.explore:
        return 3;
    }
  }

  // Mapping index to enum
  MainViews _mapIndexToEnum(int index) {
    switch (index) {
      case 0:
        return MainViews.slask;
      case 1:
        return MainViews.news;
      case 2:
        return MainViews.events;
      case 3:
        return MainViews.explore;
      default:
        return MainViews.events;
    }
  }
}
