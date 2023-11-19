import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool obscureText = true;

  Color topColor = const Color.fromARGB(255, 101, 128, 51);
  int _selectedIndex = 0;

  List<String> imagens = [
    "assets/images/logo_flutter.png",
    // Adicione outras imagens locais aqui
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _opacityAnimation.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });

    // Chamando a função para comprimir as imagens
    _compressImages();
  }

  // Função para comprimir as imagens
  Future<void> _compressImages() async {
    for (int i = 0; i < imagens.length; i++) {
      await _compressImage(i);
    }
  }

  Future<void> _compressImage(int index) async {
    String imagePath = imagens[index];
    var result = await FlutterImageCompress.compressWithFile(
      imagePath,
      quality: 85, // Ajuste a qualidade conforme necessário
    );

    // Atualize a lista de imagens com os dados comprimidos
    if (result!.isNotEmpty) {
      imagens[index] = result as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 150, 92),
        title: const Text("Cadastro de Usuários"),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: imagens.map((imagemUrl) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagemUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          _buildCircularContainer("Elemento 1", Colors.blue),
          _buildCircularContainer("Elemento 2", Colors.red),
          // Adicione outros widgets ou conteúdo aqui
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Cadastro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Consulta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Sair',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCircularContainer(String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
