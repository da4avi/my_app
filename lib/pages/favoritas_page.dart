import 'package:flutter/material.dart';
import 'package:my_app/repositories/favoritas_repository.dart';
import 'package:my_app/widgets/moeda_card.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({super.key});

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favoritas'),
        backgroundColor: const Color.fromARGB(255, 96, 83, 141),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
          return favoritas.lista.isEmpty
          ? ListTile(
          leading: Icon(Icons.star, color: Color.fromARGB(255, 131, 131, 131)),
          title: Text('Ainda não há moedas favoritas',
          style: TextStyle(
            color: Color.fromARGB(255, 131, 131, 131)
          ),),
        )
        : ListView.builder(itemCount: favoritas.lista.length, itemBuilder: (_, index) {
          return MoedaCard(moeda: favoritas.lista[index]);
        },);
        
        }
        )
      ),
    );
  }
}