import 'package:flutter/material.dart';
import 'package:hotel_test_task/model/book_room_model.dart';
import 'package:intl/intl.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookRoom>(
        future: BookRoom.fetchBookRoomData(),
        builder: (context, snapshot) { 
        if (snapshot.hasData) {
          final bookRoom = snapshot.data!;
          final int fullPrice = bookRoom.tourPrice + bookRoom.serviceCharge + bookRoom.fuelCharge;
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Тур', 
                      style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150), fontSize: 16),),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),

                    const Text('Топливный сбор', 
                      style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150), fontSize: 16),),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),

                    const Text('Сервисный сбор', 
                      style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150), fontSize: 16),),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),

                    const Text('К оплате', 
                      style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150), fontSize: 16),),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${NumberFormat('#,##0').format(bookRoom.tourPrice).replaceAll(",", " ")} ₽', 
                      style: const TextStyle(fontSize: 16),),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),
                    Text('${NumberFormat('#,##0').format(bookRoom.fuelCharge).replaceAll(",", " ")} ₽', 
                      style: const TextStyle(fontSize: 16),),
                      SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),
                    Text('${NumberFormat('#,##0').format(bookRoom.serviceCharge).replaceAll(",", " ")} ₽', 
                      style: const TextStyle(fontSize: 16),),
                      SizedBox(
                      height: MediaQuery.sizeOf(context).height/100,
                    ),
                    Text('${NumberFormat('#,##0').format(fullPrice).replaceAll(",", " ")} ₽', 
                      style: const TextStyle(fontSize: 16, color: Color.fromARGB(1000, 13, 114, 255)),),
                  ],
                )
              ],
            ),
          );
        }
        else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } 
        else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}