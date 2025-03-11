import 'package:flutter/material.dart';
import 'package:my_app/configs/app_settings.dart';
import 'package:my_app/models/moeda.dart';
import 'package:my_app/pages/moedas_detalhes_page.dart';
import 'package:my_app/repositories/favoritas_repository.dart';
import 'package:my_app/repositories/moeda_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language, color: Colors.white),
      itemBuilder: (context) => [
        PopupMenuItem(child: ListTile(
          leading: Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        ))
      ],
    );
  } 

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
        actions: [
          changeLanguageButton(),
        ],
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
            limparSelecionadas();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      );
    }
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MoedasDetalhesPage(moeda: moeda)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();

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
            title: Row(
              children: [
                Text(
                  tabela[moeda].nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                if (favoritas.lista.any((fav) => fav.sigla == tabela[moeda].sigla))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.star, color: Colors.amber, size: 15),
                  ),
              ],
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
                onPressed: () {
                  favoritas.saveAll(selecionadas);
                  limparSelecionadas();
                },
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
