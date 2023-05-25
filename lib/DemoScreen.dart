import 'package:flutter/material.dart';
import 'package:spint_demo/widgets/FortuneWheel.dart';
import 'package:spint_demo/widgets/FortuneWheelChild.dart';

import 'controller/FortuneWheelController.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  DemoScreenState createState() => DemoScreenState();
}

class DemoScreenState extends State<DemoScreen> {
  FortuneWheelController<int> fortuneWheelController = FortuneWheelController();
  FortuneWheelChild? currentWheelChild;
  int currentBalance = 0;

  @override
  void initState() {
    fortuneWheelController.addListener(() {
      if (fortuneWheelController.value == null) return;

      setState(() {
        currentWheelChild = fortuneWheelController.value;
      });

      if (fortuneWheelController.isAnimating) return;

      if (fortuneWheelController.shouldStartAnimation) return;

      setState(() {
        currentBalance = fortuneWheelController.value!.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color:
                          currentBalance.isNegative ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'Current balance: $currentBalance ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(
                  color: Colors.black87,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 80,
                  width: 80,
                  child: currentWheelChild != null
                      ? currentWheelChild!.foreground
                      : Container(),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 350,
                    height: 350,
                    child: FortuneWheel<int>(
                      controller: fortuneWheelController,
                      children: [
                        _createFortuneWheelChild(-50, "vocher 50k"),
                        _createFortuneWheelChild(1000, "vocher 1 chỉ vàng"),
                        _createFortuneWheelChild(-50, "vocher 10k"),
                        _createFortuneWheelChild(-50, "chúc bạn may mắn lần sau"),
                      ],
                    )),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () => fortuneWheelController.rotateTheWheel(),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'ROTATE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  FortuneWheelChild<int> _createFortuneWheelChild(int value, String title) {
    Color color = value.isNegative ? Colors.red : Colors.green;
    String verb = value.isNegative ? 'Lose' : 'Win';
    int valueString = value.abs();

    return FortuneWheelChild(
        foreground:
            _getWheelContentCircle(color, '$verb\n$title', title),
        value: value);
  }

  Container _getWheelContentCircle(
      Color backgroundColor, String text, String title) {
    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 4)),
      child: Center(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
