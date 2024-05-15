import 'package:flutter/material.dart';
import 'package:project/services/theme_provider.dart';
import 'package:provider/provider.dart';

enum SampleItem {
  itemOne,
  itemTwo,
}

class AppBarMenu extends StatefulWidget {
  const AppBarMenu({super.key});

  @override
  State<AppBarMenu> createState() => _AppBarMenuState();
}

class _AppBarMenuState extends State<AppBarMenu> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
        initialValue: selectedItem,
        onSelected: (SampleItem item) {
          setState(() {
            selectedItem = item;
          });
          Provider.of<ThemeProvider>(context, listen: false)
              .setThemeMode(selectedItem == SampleItem.itemOne);
        },
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: SampleItem.itemOne,
                child: ListTile(
                  leading: const Icon(Icons.wb_sunny_outlined),
                  title: Text(
                    "Светлая тема",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              PopupMenuItem(
                value: SampleItem.itemTwo,
                child: ListTile(
                  leading: const Icon(Icons.nightlight_outlined),
                  title: Text(
                    "Темная тема",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ]);
  }
}
