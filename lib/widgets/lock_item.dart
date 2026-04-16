import 'package:flutter/material.dart';

class LockItem extends StatelessWidget {
  const LockItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xFF24221F),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Porta trancada!"), Text("horario da saida")],
          ),
        ],
      ),
    );
  }
}
