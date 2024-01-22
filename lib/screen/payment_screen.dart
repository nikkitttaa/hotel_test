import 'package:flutter/material.dart';
import 'package:hotel_test_task/screen/hotel_screen.dart';
import 'package:hotel_test_task/template/randomaizer.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int randomNumber = Randomizer.generateRandomNumber();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заказ оплачен'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(
          children: [
            Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(1000, 246, 246, 249)),
                child: Image.asset('assets/images/party_popper.png')),
            SizedBox(height: MediaQuery.sizeOf(context).height / 30),
            const Text(
              'Ваш заказ принят в работу',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height / 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Text(
                'Подтверждение заказа №${randomNumber.toString()} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(1000, 130, 135, 150)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 3.5,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          width: MediaQuery.sizeOf(context).width / 1,
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width / 1.05,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(1000, 13, 114, 255),
                    borderRadius: BorderRadius.circular(15)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HotelScreen()),
                        (route) => false);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(1000, 13, 114, 255))),
                  child: const Text(
                    'Супер!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
