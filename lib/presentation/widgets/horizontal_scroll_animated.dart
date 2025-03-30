import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  const HorizontalScroll({super.key});

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Ajusta la duración del desplazamiento
    )..repeat();



    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Número de elementos (puedes aumentar para un scroll más largo)
            itemBuilder: (context, index) {


              // Calcula el offset para cada elemento
              double offset = (index * 100 + _animation.value * -100) % 1000 ;


              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'),
                    ),
                    const SizedBox(height: 5),
                    Transform.translate(
                      offset: Offset(offset, 0.0),
                      child: Text('Hola ${index + 1}'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}