import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderTicketWidget extends StatefulWidget {
  final KitchenOrder order;
  final bool isSelected;
  final VoidCallback onTap;

  const OrderTicketWidget({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<OrderTicketWidget> createState() => _OrderTicketWidgetState();
}

class _OrderTicketWidgetState extends State<OrderTicketWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.order.patienceProgress;
    final isCritical = progress < 0.25;

    if (isCritical && !_shakeController.isAnimating) {
      _shakeController.repeat(reverse: true);
    } else if (!isCritical && _shakeController.isAnimating) {
      _shakeController.stop();
    }

    final barColor = progress > 0.5
        ? Colors.greenAccent
        : progress > 0.25
        ? Colors.orangeAccent
        : Colors.redAccent;

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final shake = isCritical ? sin(_shakeController.value * pi * 4) * 3.0 : 0.0;
        return Transform.translate(
          offset: Offset(shake, 0),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 110,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.isSelected ? const Color(0xFF334155) : const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.isSelected ? Colors.amber : (isCritical ? Colors.red : Colors.transparent),
                  width: 2,
                ),
                boxShadow: widget.isSelected
                    ? [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 10)]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.order.recipe.emoji, style: const TextStyle(fontSize: 22)),
                      if (widget.order.isVIP)
                        const Text('⭐', style: TextStyle(color: Colors.amber, fontSize: 12)),
                    ],
                  ),
                  Text(
                    widget.order.recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      color: barColor,
                      backgroundColor: Colors.white12,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}