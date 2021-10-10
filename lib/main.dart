import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart = BodyPart.none;
  BodyPart? attackingBodyPart = BodyPart.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(213, 222, 240, 1),
      body: Column(
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 16),
              Expanded(
                  child: Center(
                      child: Column(
                children: List<Widget>.generate(
                    6,
                    (int index) =>
                        index == 0 ? const Text("You") : const Text("1")),
              ))),
              const SizedBox(width: 12),
              Expanded(
                  child: Center(
                      child: Column(
                children: List<Widget>.generate(
                    6,
                    (int index) =>
                        index == 0 ? const Text("Enemy") : const Text("1")),
              ))),
              const SizedBox(width: 16),
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text("Defend".toUpperCase()),
                    const SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: defendingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torse,
                      selected: defendingBodyPart == BodyPart.torse,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text("Attack".toUpperCase()),
                    const SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: attackingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    const SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torse,
                      selected: attackingBodyPart == BodyPart.torse,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16)
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: _deselectAllBodyParts,
                child: SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color: _getColorForGo(),
                      child: Center(
                        child: Text(
                          "Go".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    )),
              )),
              const SizedBox(
                width: 16,
              )
            ],
          )
        ],
      ),
    );
  }

  Color _getColorForGo() {
    return (attackingBodyPart == BodyPart.none ||
            defendingBodyPart == BodyPart.none)
        ? const Color.fromRGBO(0, 0, 0, 0.38)
        : const Color.fromRGBO(0, 0, 0, 0.87);
  }

  void _deselectAllBodyParts() {
    if (attackingBodyPart != BodyPart.none &&
        defendingBodyPart != BodyPart.none) {
      setState(() {
        attackingBodyPart = BodyPart.none;
        defendingBodyPart = BodyPart.none;
      });
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torse = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");
  static const none = BodyPart._("None");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? const Color.fromRGBO(28, 121, 206, 1)
              : const Color.fromRGBO(0, 0, 0, 0.38),
          child: Center(child: Text(bodyPart.name.toUpperCase())),
        ),
      ),
    );
  }
}