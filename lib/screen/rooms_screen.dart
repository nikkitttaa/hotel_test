import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hotel_test_task/model/rooms_model.dart';
import 'package:hotel_test_task/screen/book_room_screen.dart';
import 'package:intl/intl.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  
  final _pictureController = PageController();
  int currentPicture = 0;

  @override
  void initState() {
    super.initState();
    _pictureController.addListener(() {
      setState(() {
        currentPicture = _pictureController.page!.toInt();
      });
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 246, 246, 249),
      appBar: AppBar(
        title: const Text('Steigenberger Makadi'),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back_ios, size: 20,),
        ),
      ),
      body: FutureBuilder<List<Room>>(
        future: fetchRooms(),
        builder: (context, snapshot) { 

          if (snapshot.hasData) {
            List<Room> rooms = snapshot.data!;

            return ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                Room room = rooms[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12) ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      //images
                      CarouselSlider(
                        items: room.imageUrls.map((image) {
                          return Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: MediaQuery.sizeOf(context).height/3.5,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPicture = index;
                            });
                          },
                        ),
                      ),
                      DotsIndicator(
                        dotsCount: room.imageUrls.length,
                        position: currentPicture,
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: Colors.blue,
                          activeSize: const Size(10.0, 10.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      
                      //name
                      Text(
                        room.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //peculiarities
                      Wrap(
                        children: room.peculiarities.map((peculiaritie) {
                          return Container( 
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: const Color.fromARGB(1000, 251, 251, 252), 
                              borderRadius: BorderRadius.circular(5)), 
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                peculiaritie,
                                style: const TextStyle(color: Color.fromARGB(1000, 130, 135, 150)), // задайте желаемый размер текста
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      //button more info room
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(50, 13, 114, 255)),
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              child: const Row(
                                children: [
                                  Text('Подробнее о номере', 
                                    style: TextStyle(color: Color.fromARGB(1000, 13, 114, 255), fontSize: 14,),),
                                  Icon(Icons.arrow_forward_ios, color: Color.fromARGB(1000, 13, 114, 255), size: 16,),
                                ],
                              )
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),

                      SizedBox(
                        height: MediaQuery.sizeOf(context).height/100,
                      ),

                      //price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${NumberFormat('#,##0').format(room.price).replaceAll(",", " ")} ₽', 
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                          Text(room.pricePer, 
                            style: const TextStyle(color: Colors.grey, fontSize: 16,))
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.sizeOf(context).height/70,
                      ),
                      //button select room
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: const Color.fromARGB(1000, 13, 114, 255),
                            borderRadius: BorderRadius.circular(15)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Выбрать номер', style: TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          )
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BookRoomScreen()));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } 
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } 
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}