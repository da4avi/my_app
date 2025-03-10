import 'package:flutter/material.dart';
import 'package:my_app/pages/favoritas_page.dart';
import 'package:my_app/pages/moedas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;
  
  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setPaginaAtual,
          children: [
            MoedasPage(),
            FavoritasPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
          ],
          onTap: (pagina) {
            pc.animateToPage(pagina, duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
        ),
      );
  }
}