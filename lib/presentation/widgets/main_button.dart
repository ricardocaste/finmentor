import 'package:flutter/material.dart';
import 'package:finmentor/infrastructure/constants/app_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final bool isActionButton;
  final VoidCallback onPressed;
  final double width;

  const MainButton({
    super.key,
    required this.text,
    this.isActionButton = false,
    this.width = 150,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: width,
      child:  ElevatedButton(
        onPressed: onPressed,
        style: isActionButton ?
          Theme.of(context).elevatedButtonTheme.style :
          Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all<Color>(AppColors.acqua_50) ),// Color(0x2196F3))
            
        // ElevatedButton.styleFrom(
        //   backgroundColor: isPrimaryColor ? Colors.blue : Colors.grey, // Cambia el color según isPrimaryColor
        //   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        //   textStyle: const TextStyle(fontSize: 18, color: Colors.white),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0), // Ajusta el radio para la forma redondeada
        //   ),
        // ),
        child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
      )
    );


  }
}