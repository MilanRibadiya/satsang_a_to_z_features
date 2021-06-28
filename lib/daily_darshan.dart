// import 'dart:async';
// import 'dart:convert';
// // import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:image_picker_saver/image_picker_saver.dart';
// // import 'package:transparent_image/transparent_image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class DailyDarshan extends StatefulWidget {
//   const DailyDarshan({Key key}) : super(key: key);

//   @override
//   _DailyDarshanState createState() => _DailyDarshanState();
// }

// class _DailyDarshanState extends State<DailyDarshan> {
//   StreamController _streamController;
//   Stream _stream;
//   Response response;
//   var jsonResponse;

//   List<String> imageList = [];
//   List<int> errList = [];

//   String day = "02", month = "06", year = "2021";

//   DateTime date = DateTime.utc(2021, 06, 02);
//   Future<Null> selectDatePicker(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: date,
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2023));
//     if (picked != null && picked != date) {
//       setState(() {
//         date = picked;

//         // final DateFormat formatter = DateFormat('DD/MM/YY');
//         // String string_date = formatter.format(date);
//         // DateTime final_date = formatter.parse(string_date);

//         day = date.day.toString();
//         month = date.month.toString();
//         year = date.year.toString();

//         if (date.day.toInt() <= 9) {
//           day = "0" + date.day.toString();
//         }

//         if (date.month.toInt() <= 9) {
//           month = "0" + date.month.toString();
//         }

//         print(date.day.toString());
//         _onDateChanged();
//       });
//     }
//   }

//   _onDateChanged() async {
//     String _url = "https://dhanrajsakariya.tk/dailydarshan/" +
//         day +
//         "-" +
//         month +
//         "-" +
//         year;
//     response = await get(Uri.parse(_url));
//     _streamController.add(json.decode(response.body));

//     jsonResponse = json.decode(response.body);

//     imageList.clear();
//     for (int i = 0; i <= jsonResponse.length - 1; i++) {
//       imageList.add(jsonResponse[i]["image"].toString());
//     }

//     // debugPrint("saasaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasasddaddaddadd" +
//     //     jsonResponse[2]["image"].toString());
//     // imageList.add("sdd");
//     print(imageList);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _streamController = StreamController();
//     _stream = _streamController.stream;
//     _onDateChanged();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('StreamBuilder Demo'),
//         actions: [
//           Padding(
//               padding: EdgeInsets.all(8.0),
//               child: IconButton(
//                 icon: Icon(Icons.calendar_today_outlined),
//                 onPressed: () {
//                   selectDatePicker(context);
//                 },
//               )),
//           // Text(date.toString())
//         ],
//       ),
//       body: StreamBuilder(
//           stream: _stream,
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: _onDateChanged,
//                 ),
//               );
//             }

//             return Container(
//               margin: EdgeInsets.all(12),
//               child: new StaggeredGridView.countBuilder(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ddSlider(imageList)));
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               // border: Border.all(width: 1.0, color: Colors.amber),
//                               color: Colors.transparent,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(12))),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.all(Radius.circular(12)),
//                             child: FadeInImage.memoryNetwork(
//                               fadeInCurve: Curves.fastOutSlowIn,
//                               placeholder: null,
//                               image: snapshot.data[index]["image"],
//                               fit: BoxFit.cover,
//                               imageErrorBuilder: (BuildContext context,
//                                   Object exception, StackTrace stackTrace) {
//                                 return Container(
//                                   color: Colors.amber,
//                                   height: 0.0,
//                                   width: 0.0,
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   staggeredTileBuilder: (index) {
//                     return new StaggeredTile.fit(1);
//                   }),
//             );
//           }),
//     );
//   }
// }

// class ddSlider extends StatefulWidget {
//   // const ddSlider({ Key key }) : super(key: key);

//   final List<String> imageList;

//   ddSlider(this.imageList);

//   @override
//   _ddSliderState createState() => _ddSliderState();
// }

// class _ddSliderState extends State<ddSlider> {
//   @override
//   Widget build(BuildContext context) {
//     double dwidth = MediaQuery.of(context).size.width;
//     double dheight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Daily Darshan"),
//       ),
//       body: PageView.builder(
//         itemCount: widget.imageList.length, // Can be null
//         itemBuilder: (context, index) {
//           return Stack(
//             children: [
//               Image.network(
//                 widget.imageList[index],
//                 // errorBuilder:
//                 //     (BuildContext context, Object exception, StackTrace stackTrace) {
//                 //   return ddSlider(widget.imageList);
//                 // },
//                 fit: BoxFit.fitWidth,
//               ),
//               IconButton(
//                   padding: EdgeInsets.only(right: 8, bottom: 8),
//                   icon: Icon(Icons.download),
//                   color: Colors.cyan,
//                   alignment: Alignment.bottomRight,
//                   onPressed: () {
//                     _onDownloadPressed(index);
//                   }),
//             ],
//             // bottomNavigationBar: IconButton(
//             //     icon: Icon(Icons.download),
//             //     color: Colors.cyan,
//             //     alignment: Alignment.bottomRight,
//             //     onPressed: () {
//             //       _onDownloadPressed(index);
//             //     }),
//           );
//         },
//       ),
//     );
//   }

//   void _onDownloadPressed(imageIndex) async {
//     // _onLoading(true);
//     print('download');
//     print(widget.imageList[imageIndex].toString());
//     var image = await get(Uri.parse(widget.imageList[imageIndex].toString()));
//     var filepath = await ImagePickerSaver.saveFile(fileData: image.bodyBytes);
//   }
// }

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Daily Darshan'),
// //       ),
// //       body: Center(
// //         child: CarouselSlider(
// //           options: CarouselOptions(
// //             enlargeCenterPage: true,
// //             enableInfiniteScroll: false,
// //             autoPlay: false,
// //           ),
// //           items: widget.imageList
// //               .map((e) => ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Stack(
// //                       fit: StackFit.expand,
// //                       children: <Widget>[
// //                         Image.network(
// //                           e,
// //                           height: dheight,
// //                           width: dwidth,
// //                           fit: BoxFit.fitHeight,
// //                           errorBuilder : (BuildContext context,
// //                                   Object exception, StackTrace stackTrace) {
// //                                 return null;
// //                           }
// //                         ),
// //                       ],
// //                     ),
// //                   ))
// //               .toList(),
// //         ),
// //       ),
// //     );
// //   }
// // }

// //   return Container(
// //   margin: EdgeInsets.all(12),
// //   child: new StaggeredGridView.countBuilder(
// //       crossAxisCount: 2,
// //       crossAxisSpacing: 12,
// //       mainAxisSpacing: 12,
// //       itemCount: snapshot.data.length,
// //       itemBuilder: (context, index) {
// //         return Container(
// //           decoration: BoxDecoration(
// //               color: Colors.transparent,
// //               borderRadius: BorderRadius.all(Radius.circular(12))),
// //           child: Center(
// //             child: ClipRRect(
// //               borderRadius: BorderRadius.all(Radius.circular(12)),
// //               child: FadeInImage.memoryNetwork(
// //                   placeholder: kTransparentImage, image: snapshot.data[index]["image"],fit: BoxFit.cover,),
// //             ),
// //           ),
// //         );
// //       },
// //       staggeredTileBuilder: (index) {
// //         return new StaggeredTile.count(12, index.isEven ? 1.2 : 1.8);
// //       }),
// // );
// // return GridView.count(
// //     crossAxisSpacing: 5,
// //     crossAxisCount: 2,
// //     children: List.generate(snapshot.data.length, (index) {
// //       return Center(
// //         child: FittedBox(
// //           clipBehavior: Clip.hardEdge,
// //           child:Image.network(
// //             snapshot.data[index]["image"],
// //             fit: BoxFit.fitHeight,
// //           ),
// //         ),
// //       );
// //     }),);
