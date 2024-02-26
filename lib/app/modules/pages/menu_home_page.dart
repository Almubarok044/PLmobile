// ignore_for_file: must_be_immutable, no_logic_in_create_state, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:plmobile/app/modules/pages/customer.dart';
import 'package:plmobile/app/modules/pages/item_barang.dart';
import 'package:plmobile/app/modules/pages/print_faktur.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({super.key});

  static List<StatefulWidget> pages = [
    const Customer(),
    const Barang(),
    const PrintPage()
  ];

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  int indexSelected = 0;

  void onItemTap(int index) {
    setState(() {
      indexSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Color(0xff3F736F), blurRadius: 2),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            fixedColor: Colors.grey[800],
            items: const [
              BottomNavigationBarItem(
                  label: 'Customer',
                  backgroundColor: Color.fromARGB(255, 112, 193, 186),
                  icon: Icon(
                    Icons.people,
                    color: Color.fromARGB(255, 112, 193, 186),
                  )),
              BottomNavigationBarItem(
                  label: 'Item',
                  backgroundColor: Color.fromARGB(255, 112, 193, 186),
                  icon: Icon(
                    Icons.category,
                    color: Color.fromARGB(255, 112, 193, 186),
                  )),
              BottomNavigationBarItem(
                  label: 'Faktur',
                  backgroundColor: Color.fromARGB(255, 112, 193, 186),
                  icon: Icon(
                    Icons.badge,
                    color: Color.fromARGB(255, 112, 193, 186),
                  )),
            ],
            currentIndex: indexSelected,
            onTap: onItemTap,
          ),
        ),
      ),
      body: MenuHome.pages.elementAt(indexSelected),
    );
  }
}
