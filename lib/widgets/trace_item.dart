import 'package:flutter/material.dart';
import 'package:locktrace/models/trace.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class TraceItem extends StatelessWidget {
  final Trace trace;

  const TraceItem({super.key, required this.trace});

  Widget checkItem(bool value, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        Icon(
          value ? LucideIcons.check : LucideIcons.x,
          size: 16,
          color: value ? Color(0xFFFFC632) : Color(0xFFA9AFB9),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 12,
            color: value ? Color(0xFFFFC632) : Color(0xFFA9AFB9),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF24221F),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Porta trancada!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFFFC632),
                ),
              ),
              Text(
                timeago.format(trace.createdAt, locale: 'pt_BR'),
                style: TextStyle(color: Color(0xFFA9AFB9)),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 4,
                  children: [
                    checkItem(trace.roomWindow, "Janela do quarto"),
                    checkItem(trace.roomOutlet, "Tomada do quarto"),
                    checkItem(trace.clothesIron, "Ferro de passar roupa"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 4,
                  children: [
                    checkItem(trace.kitchenOutlet, "Tomadas da cozinha"),
                    checkItem(trace.burner, "Boca do fogão"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
