import 'package:flutter/material.dart';
import 'package:my_app/models/moeda.dart';
import 'package:my_app/pages/moedas_detalhes_page.dart';
import 'package:my_app/repositories/moeda_repository.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        centerTitle: true,
        title: Text('Cripto Moedas'),
        backgroundColor: const Color.fromARGB(255, 96, 83, 141),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return AppBar(
        centerTitle: true,
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: const Color.fromARGB(255, 127, 119, 156),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MoedasDetalhesPage(moeda: moeda)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            leading:
                (selecionadas.contains(tabela[moeda]))
                    ? CircleAvatar(child: Icon(Icons.check))
                    : SizedBox(
                      width: 40,
                      child: Image.asset(tabela[moeda].icone),
                    ),
            title: Text(
              tabela[moeda].nome,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
              style: const TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: const Color.fromARGB(168, 127, 119, 156),
            selectedColor: Colors.white,
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          ); //LINHA DA TABELA
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ____) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          selecionadas.isNotEmpty
              ? FloatingActionButton.extended(
                onPressed: () { },
                icon: Icon(Icons.star),
                label: Text(
                  'FAVORITAR',
                  style: const TextStyle(
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
              : null,
    );
  }
}
