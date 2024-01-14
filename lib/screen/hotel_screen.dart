import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hotel_test_task/model/hotel_model.dart';
import 'package:hotel_test_task/screen/rooms_screen.dart';
import 'package:intl/intl.dart';


class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  
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
        title: const Text('Отель'),
        centerTitle: true,
      ),
      body: FutureBuilder<Hotel>(
        future: Hotel.fetchHotelData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final hotel = snapshot.data!;
            return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //main data
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height/60),
                      child: Column(
                        children: [
                        
                        //карусель из фотографий
                        CarouselSlider(
                          items: hotel.imageUrls.map((image) {
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
                          dotsCount: hotel.imageUrls.length,
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

                        //main info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(100, 255, 199, 0)),
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 20,),
                                  Text('${hotel.rating} ${hotel.ratingName}', 
                                    style: const TextStyle(color: Color.fromARGB(1000,255, 168, 0), fontSize: 16,
                                    fontWeight: FontWeight.bold),),
                                ],
                              )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width/1,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(child: Text(hotel.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),)),
                                    ],
                                  ),
                                  Text(hotel.adress, style: const TextStyle(color: Color.fromARGB(1000, 13, 114, 255)),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('от ${NumberFormat('#,##0').format(hotel.minimalPrice).replaceAll(",", " ")} ₽', 
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                                Text(hotel.priceForIt, 
                                  style: const TextStyle(color: Colors.grey, fontSize: 16,))
                            ],
                          ),
                        )
                      ]),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //description
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Об отеле', 
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                          ],
                        ),
                        
                        //peculiarities
                        Wrap(
                          children: hotel.peculiarities.map((peculiaritie) {
                            return Container( 
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(color: const Color.fromARGB(1000, 251, 251, 252), 
                                borderRadius: BorderRadius.circular(5)), 
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  peculiaritie,
                                  style: const TextStyle(color: Color.fromARGB(1000, 130, 135, 150)),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        Text(hotel.description, textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16),),

                        const SizedBox(
                          height: 20,
                        ),

                          //more info
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15)),
                          child: Column(children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/icons/emoji-happy.png'),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text('Удобства', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text('Самое необходимое', style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150)),)
                                    ],),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/icons/tick-square.png'),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text('Что включено', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text('Самое необходимое', style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150)),)
                                    ],),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],),
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/icons/close-square.png'),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text('Что не включено', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                      Text('Самое необходимое', style: TextStyle(color: Color.fromARGB(1000, 130, 135, 150)),)
                                    ],),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],),
                            )
                          ]),
                        )
                    ]),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка загрузки данных'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomsScreen()));
      }, 
      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(1000, 13, 114, 255))),
        child: const Text('К выбору номера', style: TextStyle(color: Colors.white, fontSize: 16),),),
    );
  }
}