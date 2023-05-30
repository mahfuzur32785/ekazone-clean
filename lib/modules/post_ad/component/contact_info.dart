import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({Key? key}) : super(key: key);

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {

  bool isFeature = false;

  List<String> authenticities = ["New","Used"];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Phone Number*"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Backup Phone Number"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Whats App Phone Number"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),


                  const Text("Model*"),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Model",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  const Text("Authenticity*"),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      hintText: "Authenticity",
                    ), items: authenticities.map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e,style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                  )).toList(),
                    onChanged: (String? value) {  },
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text("Condition"),
                          Row(
                            children: [
                              Checkbox(value: isFeature, onChanged: (value){
                                setState(() {
                                  isFeature = value!;
                                });
                              }),
                              const Text("Fresh")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Negotiable"),
                          Row(
                            children: [
                              Radio(
                                  value: false,
                                  groupValue: isFeature,
                                  onChanged: (value){
                                setState(() {
                                  isFeature = value!;
                                });
                              }),
                              const Text("Fresh")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: isFeature,
                                  onChanged: (value){
                                setState(() {
                                  isFeature = value!;
                                });
                              }),
                              const Text("Fresh")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Features"),
                      Row(
                        children: [
                          Checkbox(value: isFeature, onChanged: (value){
                            setState(() {
                              isFeature = value!;
                            });
                          }),
                          const Text("Comportable")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: isFeature, onChanged: (value){
                            setState(() {
                              isFeature = value!;
                            });
                          }),
                          const Text("Beautiful look")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(value: isFeature, onChanged: (value){
                            setState(() {
                              isFeature = value!;
                            });
                          }),
                          const Text("Good Condition")
                        ],
                      ),
                    ],
                  ),

                  const Text("Note*"),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Note",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Established*"),
                  TextFormField(
                    textAlign: TextAlign.start,
                    controller: dateController,
                    validator: (String? value) {
                      if (value == "") {
                        return 'Select Your Birthday';
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    maxLines: 1,
                    cursorColor: Colors.black87,
                    onSaved: (String? val) {
                      date = val;
                    },
                    onTap: (){
                      dateChooser(context);
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      hintText: 'mm/dd/yyyy',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Website URL*"),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Website URL",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("Phone*"),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Phone",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  //.......... Date Chooser ............
  var dateController = TextEditingController();
  final formatter = DateFormat('MM-dd-yyyy');
  DateTime dateTime = DateTime.now();
  String? date;
  dateChooser(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1950),
        lastDate: DateTime(2040),
        currentDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF31A3DD),
                onPrimary: Color(0xFFFFFFFF),
                surface: Color(0xFF31A3DD),
                onSurface: Color(0xFF000000),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      dateTime = newSelectedDate;
      dateController
        ..text = formatter.format(dateTime)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateController.text.length,
            affinity: TextAffinity.upstream));
      setState((){
        date = dateController.text;
      });
    }
  }

}
