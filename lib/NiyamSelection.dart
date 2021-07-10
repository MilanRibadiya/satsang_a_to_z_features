import 'package:flutter/material.dart';
import 'package:satsang_a_to_z_feature/colors.dart';

class NiyamSelection extends StatefulWidget {
  @override
  _NiyamSelectionState createState() => _NiyamSelectionState();
}

class _NiyamSelectionState extends State<NiyamSelection> {
  bool select = false;
  List<String> _texts = [
    "દરરોજ વ્યક્તિગત પૂજા અને તિલક-ચાંદલો કરીશ તથા પૂ.ગુરુજીના સારા સ્વાસ્થ્ય માટે ૧ (એક) માળા વિશેષ કરીશ.",
    "દરરોજની માળા, દંડવત્ અને પ્રદક્ષિણા કરીશ. ",
    "દરરોજ ૫(પાંચ) માનસી પૂજા કરીશ. ",
    "દરરોજ માતા-પિતાને પગે લાગી ‘જય સ્વામિનારાયણ’ કહીશ.",
    "દરરોજ મહારાજના તિલ-ચિહ્નની એક ઉથલ કરીશ.",
    "દરરોજ ‘વંદુના પાઠ’ કરીશ.",
    "દરરોજ ‘ચેષ્ટા ગાન’ કરીશ.",
    "કોઈપણ એક ધાર્મિક ગ્રંથનું સંપૂર્ણ વાંચન કરીશ.",
    "મારા જીવનનો ધ્યેય પ્રાપ્ત કરવા માટે અભ્યાસમાં પૂરતું ધ્યાન આપીશ.",
    "દરરોજ “જનમંગલ નામાવલી, સ્તોત્રમ & મંત્રજાપ” એપ્લીકેશન દ્વારા online મંત્રજાપ, જનમંગલનો પાઠ અને અને જનમંગલ સ્ત્રોતમનો પાઠ કરીશ કરીશ.",
    "દરરોજ “ચાલો મંત્રલેખન કરીએ” એપ્લીકેશન દ્વારા online મંત્રલેખન કરીશ.",
    "દરરોજ રાત્રે પૂ.ગુરુજીની ભક્તચિંતામણી કથા કથા-વાર્તા સાંભળીશ.",
    "હું વધુ પ્રમાણમાં ફોનનો ઉપયોગ કરીશ નહીં તથા ગેમ રમીશ નહીં.",
    "દરરોજ સુતા પહેલા ભગવાન અને સંતો-ભક્તોને યાદ કરી, પ્રાર્થના કરીને પછી જ સુઇશ."
  ];
  List<bool> _isChecked;

  @override
  void initState() {
    _isChecked = List<bool>.filled(_texts.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryExtraLightColor,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: MaterialApp(
          theme: ThemeData(
            checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(width: 1.3, color: Theme.of(context).unselectedWidgetColor),
                splashRadius: 0),
          ),
          home: Scaffold(
            backgroundColor: secondaryExtraLightColor,
            body: SafeArea(
              child: Column(
                children: [
                  /*Expanded(
                    child: ListView.builder(
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: CheckboxListTile(
                              title: Text(
                                _texts[index],
                                style: TextStyle(fontFamily: "baloobhai"),
                              ),
                              value: _isChecked[index],
                              onChanged: (val) {
                                setState(
                                  () {
                                    _isChecked[index] = val;
                                  },
                                );
                              },
                              activeColor: Colors.green,
                              selectedTileColor: Colors.green,
                              secondary: Text((index + 1).toString() + "."),
                            ),
                          ),
                        );
                      },
                    ),
                  ),*/
                  Expanded(
                    child: ListView.builder(
                        itemCount: _texts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          (index + 1).toString() + ".",
                                          style: TextStyle(fontFamily: "baloobhai", fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 40.0, left: 25),
                                        child: Text(
                                          _texts[index],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "baloobhai",
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Transform.scale(
                                            scale: 1.5,
                                            child: Checkbox(
                                              value: _isChecked[index],
                                              onChanged: (val) {
                                                setState(() {
                                                  _isChecked[index] = val;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
