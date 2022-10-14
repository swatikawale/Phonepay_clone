

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:citrusleaf/model/ImageSliderModel.dart';
import 'package:citrusleaf/model/Listpaymodel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

 


class Phonepe extends StatefulWidget {
  @override
  _PhonepeState createState() => _PhonepeState();
}

class _PhonepeState extends State<Phonepe> {
  int _currentIndex = 0;

    
 
       @override
  void initState() {
     
    super.initState();
    
      getDetails();
  }

FlutterSecureStorage _storage=FlutterSecureStorage();

 


  Future getDetails() async {
    
    final response = await http.get(
      Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"),
      headers: {
        "Content-Type": "application/json" 
      },
    );
    final responseJson = json.decode(response.body);
    print("respnse:" + responseJson.toString());
    _storage.write(key: "data", value: responseJson.toString());
    
       
  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 245, 251),
        appBar: _appBar(),
        body: _bodyItem(),
        bottomNavigationBar: _bottemTab());
  }

  Widget _appBar() {
    return new AppBar( 
       backgroundColor: Color.fromARGB(255, 32, 1, 86),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 124),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/outline_account_circle.png",
                color: Colors.white,
                height: 40,
                width: 40,
              ),  
                Image.asset(
                "assets/flag.png", 
                height: 40,
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  
                    Row(children: <Widget>[
                      Text(
                        'Indore',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Image.asset(
                "assets/outline_qrscan.png",
                color: Colors.white,
                height: 24,
                width: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Image.asset(
                "assets/notifications.png",
                color: Colors.white,
                height: 24,
                width: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 13,
              ),
              child: Image.asset(
                "assets/outline_help.png",
                color: Colors.white,
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ],
      elevation: 0,
    );
  }

  Widget _bottemTab() {
    return new BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 
                'Home',
              ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                "assets/stores.png",
                height: 19.5,
                width: 19.5,
              ),
              label:  
                'Stores',
              ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                "assets/placeholder.png",
                height: 19.5,
                width: 19.5,
              ),
              label:  
                'Apps',
              ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                "assets/rupee.png",
                height: 19.5,
                width: 19.5,
              ),
              label:  
                'My Money',
              ),
          new BottomNavigationBarItem(
              icon: Image.asset(
                "assets/history.png",
                height: 19.5,
                width: 19.5,
              ),
              label: 
                'History',
              ),
        ]);
  }

  Widget _bodyItem() {
    return new CustomScrollView(
      
      slivers: <Widget>[
      
        SliverToBoxAdapter(
            child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width/3.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 13),
                  child: CarouselSlider(
                    options: CarouselOptions(    // option:1,
                   aspectRatio: 2,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    pauseAutoPlayOnTouch: true, 
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, res) {
                      setState(() {
                        _currentIndex = index;
                        print(_currentIndex);
                      });
                    },),
               
                    items: CarouselSliderList(_getImageSliderList()),
                  ),
                ),
              ),
           ),
            Positioned(
              bottom: 5.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (int index) {
                    return dots(_currentIndex, index);
                  }),
                ),
              ),
            ),
          ],
        )),

         
        SliverToBoxAdapter(
          child: Divider(
            color: Colors.grey[400],
            height: 1,
          ),
        ),

        SliverToBoxAdapter(
          child:   Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Container(
                color: Colors.white,
                   padding: const EdgeInsets.only(left: 15,   right: 15),
            child:Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15,right: 15),
              child: Text(
              'Transfer Money',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            )),
           
          )),
        ),
        SliverToBoxAdapter(
            child: 
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Container(color: Colors.white,
                height: 85,
                 padding: const EdgeInsets.only(left: 15,right: 15),
                child: GridView.builder(
                  
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _getMoneyTransferList().length,
                  
                    itemBuilder: (context, index) {
                      return  Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[MoneyTransfer(_getMoneyTransferList()[index],
              )]);
                    }),
              ),
           // ),
       //   ],
        )),
         SliverToBoxAdapter(
          child:   Padding(
              padding: const EdgeInsets.only(left: 15,   bottom: 15,right: 15),
              child: Container(
                height: 50,
                color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ 
                
                Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [ Text(
              'My UPI ID : ',
              style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold, 
             ),
            textAlign: TextAlign.left,
            ),Text(
              '9876746444@gjb',
              style: TextStyle(fontSize: 12, 
             ),
            textAlign: TextAlign.left,
            ),
              ]),
            
           Align(alignment: Alignment.bottomRight,child: Image.asset("assets/arrow-right.png",width: 15,height: 15,))],)],),
             padding: EdgeInsets.only(left: 15, top: 10, bottom: 13, right: 15),
          )),
        ),
    
        SliverToBoxAdapter(
          child: Container(
            color: Colors.grey[100],
            height: 90,
                    width: 30, 
            child:
            
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 10, 15), child: Row(
              children: <Widget>[
                Expanded(
                  child:    Container(
                    
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue), 
                    child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/offers.png",
//                          color: Colors.pink[700],
                        width: 23,
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Offers',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
                 SizedBox(width: 10,),
             //   Image.asset("assets/suggestions_strip.png"),
                Expanded(
                  child:     Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue),
                   
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/rewards.png", 
                      width: 23,
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Rewards', style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(width: 10,), 
                Expanded(
                  child: 
                  Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue),
         
                    child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/refer.png", 
                        width: 23,
                        height: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Refer & Earn', style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                )
              ],
            )),
          ), 
        ),
 SliverToBoxAdapter(
          child: Padding(padding:    const EdgeInsets.only(left: 15,  right: 15),child:
              Container(
            color: Colors.white, padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10,right: 15),
            child: Padding(
              padding: const EdgeInsets.only(left: 15,  right: 15),
              child: Text(
                'Sponsored Links',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ),
        SliverToBoxAdapter(
          child: Column(
             
            children: <Widget>[
              Padding(padding:    const EdgeInsets.only(left: 15,   bottom: 8,right: 15),child:
              Container(
                padding: const EdgeInsets.only(left: 15,   bottom: 8,right: 15),
                height: 95,
                color: Colors.white,
                child:GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1),
                  scrollDirection: Axis.horizontal,
                  itemCount: _getListpayList().length,
                  itemBuilder: (context, index) {
                    return  Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[Listpay(_getListpayList()[index]) ]);
                  },
                ),
           ),
          )],
          ),
        ),
SliverToBoxAdapter(
            child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width/3.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 13),
                  child: CarouselSlider(
                    options: CarouselOptions(     
                   aspectRatio: 2,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    pauseAutoPlayOnTouch: true, 
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, res) {
                      setState(() {
                        _currentIndex = index;
                        print(_currentIndex);
                      });
                    },),
               
                    items: CarouselSliderList(_getImageSliderList()),
                  ),
                ),
              ),
           ),
            Positioned(
              bottom: 5.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (int index) {
                    return dots(_currentIndex, index);
                  }),
                ),
              ),
            ),
          ],
        )),

         
        SliverToBoxAdapter(
          child: Divider(
            color: Colors.grey[400],
            height: 1,
          ),
        ),
         
      ],
    );
  }

  List<Listpaymodel> _getListpayList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel(
        "assets/swiggy.png", "Swiggy", null));
    list.add(new Listpaymodel(
        "assets/ixigo.png", "ixigo", null));

    list.add(new Listpaymodel("assets/flipkart.png", "Flipkart", null));
    list.add(new Listpaymodel("assets/Group40.png", "My11Circle", null));
    return list;
  }

  List<Listpaymodel> _getMoneyTransferList() {
    List<Listpaymodel> list = new List<Listpaymodel>();
    list.add(new Listpaymodel("assets/Group32.png", "To Mobile\nNumber", null));
    list.add(new Listpaymodel(
        "assets/wallet.png", "To Wallet\nAccount", Color.fromARGB(255, 26, 3, 66)));
    list.add(new Listpaymodel("assets/Group30.png", "Check Bank\nBalance", null));
    
    return list;
  }

  
 
  List<ImageSliderModel> _getImageSliderList() {
    List<ImageSliderModel> list = new List();
    list.add(new ImageSliderModel("assets/ghghgh.jpg"));
    list.add(new ImageSliderModel("assets/ghghgh.jpg")); 

    return list;
  }

  CarouselSliderList(List<ImageSliderModel> getImageSliderList) {
    return getImageSliderList.map((i) {
      return Builder(builder: (BuildContext context) {
        return imageSliderItem(i);
      });
    }).toList();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget dots(int current, index) {
    if (current != index) {
      return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor(index),
          ));
    } else {
      return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: dotColor(index)));
    }
  }

  Widget imageSliderItem(ImageSliderModel i) {
    return Container(

        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: MediaQuery.of(context).size.width / 1.05,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            i.path,
fit: BoxFit.fill,


//            width: MediaQuery.of(context).size.width/4,
//            height: MediaQuery.of(context).size.height,
          ),
        ));
  }

  Color dotColor(int index) {
    return _currentIndex == index ? Colors.grey : Colors.black;
  }
}

class Listpay extends StatelessWidget {
  Listpaymodel listpaymodel;

  Listpay(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 40,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class MoneyTransfer extends StatelessWidget {
  Listpaymodel listpaymodel;

  MoneyTransfer(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 46,
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class SentMoney extends StatelessWidget {
  Listpaymodel listpaymodel;

  SentMoney(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          listpaymodel.imagepath,
          color: listpaymodel.color,
          width: 46,
          height: 46,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            listpaymodel.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  Listpaymodel listpaymodel;

  GridItem(this.listpaymodel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            listpaymodel.imagepath,
            width: 30,
            height: 30,
            color: listpaymodel.color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              listpaymodel.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
