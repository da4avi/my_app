import 'package:flutter/material.dart';
import 'package:my_app/pages/carteira_page.dart';
import 'package:my_app/pages/configuracoes_page.dart';
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
            CarteiraPage(),
            ConfiguracoesPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Carteira'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
          ],
          onTap: (pagina) {
            pc.animateToPage(pagina, duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
        ),
      );
  }
}