import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';

String countNameTourist = 'Первый турист';

class ExpandableContainer extends StatefulWidget {
  final int countTourist;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController dobController;
  final TextEditingController citizenshipController;
  final TextEditingController passportNumController;
  final TextEditingController passportValidityPerController;

  const ExpandableContainer(
      {required this.countTourist,
      super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.dobController,
      required this.citizenshipController,
      required this.passportNumController,
      required this.passportValidityPerController});

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  late int countOfTourist;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController dobController;
  late TextEditingController citizenshipController;
  late TextEditingController passportNumController;
  late TextEditingController passportValidityPerController;

  bool firstNameIsEmpty = true;
  bool lastNameIsEmpty = true;
  bool dobIsEmpty = true;
  bool citizenshipIsEmpty = true;
  bool passportNumIsEmpty = true;
  bool passportValidityPerIsEmpty = true;

  void _checkTextFieldValue() {
    setState(() {
      firstNameIsEmpty = firstNameController.text.isEmpty;
      lastNameIsEmpty = lastNameController.text.isEmpty;
      dobIsEmpty = dobController.text.isEmpty;
      citizenshipIsEmpty = citizenshipController.text.isEmpty;
      passportNumIsEmpty = passportNumController.text.isEmpty;
      passportValidityPerIsEmpty = passportValidityPerController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    citizenshipController.dispose();
    passportNumController.dispose();
    passportValidityPerController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    countOfTourist = widget.countTourist;

    firstNameController = widget.firstNameController;
    lastNameController = widget.lastNameController;
    dobController = widget.dobController;
    citizenshipController = widget.citizenshipController;
    passportNumController = widget.passportNumController;
    passportValidityPerController = widget.passportValidityPerController;
    super.initState();
  }

  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  List<String> containerList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(12),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getName(),
                style: const TextStyle(fontSize: 22),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(50, 13, 114, 255)),
                child: IconButton(
                  onPressed: () {
                    toggleExpanded();
                  },
                  icon: Icon(
                    isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                    color: const Color.fromARGB(1000, 13, 114, 255),
                  ),
                ),
              ),
            ],
          ),
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: firstNameIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'Имя',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: lastNameIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Фамилия',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: dobIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      labelText: 'Дата рождения',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(1000, 169, 171, 183)),
                      hintText: 'дд.мм.гггг',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                    inputFormatters: [MaskedInputFormatter('##.##.####')],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: citizenshipIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: citizenshipController,
                    decoration: const InputDecoration(
                      labelText: 'Гражданство',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: passportNumIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: passportNumController,
                    decoration: const InputDecoration(
                      labelText: 'Номер загранпаспорта',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(1000, 169, 171, 183),
                      ),
                      hintText: '00 № 1234567',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                    inputFormatters: [MaskedInputFormatter('## № #######')],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: passportValidityPerIsEmpty
                        ? const Color.fromARGB(100, 235, 87, 87)
                        : const Color.fromARGB(1000, 246, 246, 249),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: passportValidityPerController,
                    decoration: const InputDecoration(
                      labelText: 'Срок действия загранпаспорта',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(1000, 169, 171, 183)),
                      hintText: 'дд.мм.гггг',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(1000, 169, 171, 183)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _checkTextFieldValue(),
                    inputFormatters: [MaskedInputFormatter('##.##.####')],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String getName() {
    switch (countOfTourist) {
      case 1:
        countNameTourist = 'Первый турист';
        break;

      case 2:
        countNameTourist = 'Второй турист';
        break;

      case 3:
        countNameTourist = 'Третий турист';
        break;

      case 4:
        countNameTourist = 'Четвертый турист';
        break;

      case 5:
        countNameTourist = 'Пятый турист';
        break;

      case 6:
        countNameTourist = 'Шестой турист';
        break;

      case 7:
        countNameTourist = 'Седьмой турист';
        break;

      case 8:
        countNameTourist = 'Восьмой турист';
        break;

      case 9:
        countNameTourist = 'Девятый турист';
        break;

      case 10:
        countNameTourist = 'Десятый турист';
        break;

      default:
        countNameTourist = 'N турист';
    }
    return countNameTourist;
  }
}
