import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:hotel_test_task/model/book_room_model.dart';
import 'package:hotel_test_task/screen/payment_screen.dart';
import 'package:hotel_test_task/template/bookroom_scr.dart';
import 'package:hotel_test_task/template/expandable_container_bookroomscr.dart';
import 'package:hotel_test_task/template/hotescr_containers.dart';
import 'package:hotel_test_task/template/price_container.dart';
import 'package:hotel_test_task/template/snackbars.dart';
import 'package:intl/intl.dart';

class BookRoomScreen extends StatefulWidget {
  const BookRoomScreen({super.key});

  @override
  State<BookRoomScreen> createState() => _BookRoomScreenState();
}

class _BookRoomScreenState extends State<BookRoomScreen> {

  var phoneNumberController = MaskedTextController(mask: '+7 (900) 000-00-00');
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();
  TextEditingController passportNumController = TextEditingController();
  TextEditingController passportValidityPerController = TextEditingController();

  int count = 1;
  
  var email = false.obs;

  @override
  void dispose() {
    phoneNumberController.dispose();
    emailController.dispose();
    
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    citizenshipController.dispose();
    passportNumController.dispose();
    passportValidityPerController.dispose();
    super.dispose();
  }

  List<Widget> containers = [];

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
            final fullPrice = bookRoom.tourPrice + bookRoom.serviceCharge + bookRoom.fuelCharge;
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
                            RatingContainer(rating: bookRoom.horating, ratingName: bookRoom.ratingName)
                          ],
                        ),

                        //HOTEL NAME / ADRESS
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
                        InfoBook(count: bookRoom.departure, text: 'Вылет из'),
                        InfoBook(count: bookRoom.arrivalCountry, text: 'Страна, город'),
                        InfoBook(count: "${bookRoom.tourDateStart}-${bookRoom.tourDateStop}", text: 'Даты'),
                        InfoBook(count: bookRoom.numberOfNights.toString(), text: 'Кол-во ночей'),
                        InfoBook(count: bookRoom.hotelName, text: 'Отель'),
                        InfoBook(count: bookRoom.room, text: 'Номер',),
                        InfoBook(count: bookRoom.nutrition, text: 'Питание'),
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
                              hintText: '+7 (9**) ***-**-**', hintStyle: TextStyle(fontSize: 14, color: Color.fromARGB(1000, 169, 171, 183)),
                              border: InputBorder.none,),
                              
                            keyboardType: TextInputType.number,
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
                          child: Obx(() => TextField(
                            controller: emailController,
                            decoration: InputDecoration(labelText: 'Почта', labelStyle: const TextStyle(color: Color.fromARGB(1000, 169, 171, 183)), 
                              hintText: 'examplemail.000@mail.ru', hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(1000, 169, 171, 183)),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: email.value ? const Color.fromARGB(1000,246, 246, 249) : const Color.fromARGB(150, 235, 87, 87), 
                                width: 2)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: email.value ? const Color.fromARGB(1000,246, 246, 249) : const Color.fromARGB(150, 235, 87, 87), 
                                width: 2)),
                              ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (asd) {
                              if (EmailValidator.validate(asd)) {
                                email(true);
                              } else {
                                email(false);
                              }
                            },
                          ),),
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children: [
                              Flexible(
                                child: Text('Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту', 
                                  style:  TextStyle(fontSize: 14, color: Color.fromARGB(1000, 130, 135, 150)),
                                )
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/100,
                  ),

                  ExpandableContainer(countTourist: count, firstNameController: firstNameController, 
                    lastNameController: lastNameController, dobController: dobController, 
                    citizenshipController: citizenshipController, passportNumController: passportNumController, 
                    passportValidityPerController: passportValidityPerController),


                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/200,
                  ),

                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), 
                    shrinkWrap: true,
                    itemCount: containers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 5,
                        title:ExpandableContainer(countTourist: count, firstNameController: firstNameController, 
                          lastNameController: lastNameController, dobController: dobController, 
                          citizenshipController: citizenshipController, passportNumController: passportNumController, 
                          passportValidityPerController: passportValidityPerController)
                      );
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/200,
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Добавить туриста', style: TextStyle(fontSize: 22),),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), 
                            color: const Color.fromARGB(1000, 13, 114, 255)),
                          child: IconButton(onPressed: (){
                            setState(() {
                              count++;
                              containers.add(ExpandableContainer(countTourist: count, firstNameController: firstNameController, 
                                lastNameController: lastNameController, dobController: dobController, 
                                citizenshipController: citizenshipController, passportNumController: passportNumController, 
                                passportValidityPerController: passportValidityPerController));
                            });
                          }, icon: const Icon(Icons.add, color: Colors.white, size: 24,)))
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/100,
                  ),

                  const PriceContainer(),

                  SizedBox(
                    height: MediaQuery.sizeOf(context).height/100,
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    width: MediaQuery.sizeOf(context).width/1,
                      child: Column(
                        children: [
                          Container(
                          width: MediaQuery.sizeOf(context).width/1.05,
                            decoration: BoxDecoration(color: const Color.fromARGB(1000, 13, 114, 255), borderRadius: BorderRadius.circular(15) ),
                            child: TextButton(onPressed: (){
                              if (phoneNumberController.text.isEmpty || emailController.text.isEmpty || firstNameController.text.isEmpty || lastNameController.text.isEmpty || dobController.text.isEmpty || citizenshipController.text.isEmpty || passportNumController.text.isEmpty || passportValidityPerController.text.isEmpty || email.value == false) {
                                ErrorWriteAllDataSnackBar.show(context);
                              } 
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
                              }
                            }, 
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(1000, 13, 114, 255))),
                              child: Text('Оплатить ${NumberFormat('#,##0').format(fullPrice).replaceAll(",", " ")} ₽', style: const TextStyle(color: Colors.white, fontSize: 16),),),
                        ),
                      ],
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