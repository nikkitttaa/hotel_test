import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:hotel_test_task/model/book_room_model.dart';
import 'package:hotel_test_task/template/widget_for_info_book.dart';

class BookRoomScreen extends StatefulWidget {
  const BookRoomScreen({super.key});

  @override
  State<BookRoomScreen> createState() => _BookRoomScreenState();
}

class _BookRoomScreenState extends State<BookRoomScreen> {

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();
  

  @override
  void dispose() {
    phoneNumberController.dispose();
    emailController.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    citizenshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(1000, 246, 246, 249),
      appBar: AppBar(
        title: const Text('Бронирование'),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back_ios, size: 20,),
        ),
      ),
      body: FutureBuilder<BookRoom>(
        future: BookRoom.fetchBookRoomData(),
        builder: (context, snapshot) { 

          if (snapshot.hasData) {
            final bookRoom = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    child: Column(
                      children: [
              
                        //Блок с отелем
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
                                  Text('${bookRoom.horating} ${bookRoom.ratingName}', 
                                    style: const TextStyle(color: Color.fromARGB(1000,255, 168, 0), fontSize: 16,
                                    fontWeight: FontWeight.w600),),
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
                                      Flexible(child: Text(bookRoom.hotelName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                                    ],
                                  ),
                                  Text(bookRoom.hotelAdress, style: const TextStyle(color: Color.fromARGB(1000, 13, 114, 255),) ,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/100,
                  ),

                  //данные брони
                  Container(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height/100),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    child: Column(
                      children: [
                        InfoCountBook(count: bookRoom.departure, text: 'Вылет из'),
                        InfoCountBook(count: bookRoom.arrivalCountry, text: 'Страна, город'),
                        InfoCountBook(count: "${bookRoom.tourDateStart}-${bookRoom.tourDateStop}", text: 'Даты'),
                        InfoCountBook(count: bookRoom.numberOfNights.toString(), text: 'Кол-во ночей'),
                        InfoCountBook(count: bookRoom.hotelName, text: 'Отель'),
                        InfoCountBook(count: bookRoom.room, text: 'Номер',),
                        InfoCountBook(count: bookRoom.nutrition, text: 'Питание'),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/100,
                  ),

                  //Информация о покупателе
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Информация о покупателе', style: TextStyle(fontSize: 22),),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height/100,
                        ),

                        //number phone field
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          decoration: BoxDecoration(color: const Color.fromARGB(1000,246, 246, 249), 
                            borderRadius: BorderRadius.circular(10),),
                          child: TextField(
                            controller: phoneNumberController,
                            decoration: const InputDecoration(labelText: 'Номер телефона', labelStyle: TextStyle(color: Color.fromARGB(1000, 169, 171, 183)), 
                              hintText: '+7 (000) 000-00-00', hintStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none,  ),
                              inputFormatters: [
                                MaskedInputFormatter('+7 (###) ###-##-##')
                              ],
                          ),
                        ),

                         SizedBox(
                          height: MediaQuery.sizeOf(context).height/100,
                        ),

                        //email field
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          decoration: BoxDecoration(color: const Color.fromARGB(1000,246, 246, 249), 
                            borderRadius: BorderRadius.circular(10),),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: 'Почта', labelStyle: TextStyle(color: Color.fromARGB(1000, 169, 171, 183)), 
                              hintText: 'examplemail.000@mail.ru', hintStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none,  ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children: [
                              Flexible(
                                child: Text('Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту', 
                                  style:  TextStyle(fontSize: 14, color: Color.fromARGB(1000, 130, 135, 150)),
                                )
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
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
        },
      ),
    );
  }
}