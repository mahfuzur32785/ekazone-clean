import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFffff);
const Color blackColor = Color(0xff0B2C3D);
const Color whiteColor = Color(0xFFFFFFFF);
const Color f4f4Color = Color(0xFFF4F4F4);
const Color borderColor = Color(0xFFB0D8FF);
const Color pDetailsColor = Color(0xFFF0F8FF);
const Color greenColor = Color(0xFF34A853);
const Color ashColor = Color(0xFFE7ECEF);
const Color ashTextColor = Color(0xff989eb1);
final Color grayColor = const Color(0xff0B2C3D).withOpacity(.3);
const Color iconThemeColor = Color(0xffffffff);
// const Color redColor = Color(0xffFF5200);
const Color redColor = Color(0xFF3F51B5);
// const Color redColor = Color(0xffFFBB38);
const Color iconGreyColor = Color(0xff85959E);
const Color paragraphColor = Color(0xff18587A);
const Color bgGreyColor = Color(0xffE8EEF2);
const greenGradient = [redColor, redColor];

const kDuration = Duration(milliseconds: 300);

final borderRadius = BorderRadius.circular(4);

var inputDecorationTheme = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  hintStyle: const TextStyle(fontSize: 18, height: 1.667),
  border: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: const BorderSide(color: ashColor),
  ),
  errorBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: Colors.red)
  ),
  fillColor: primaryColor,
  filled: true,
  focusColor: blackColor,
);

final gradientColors = [
  [redColor, redColor.withOpacity(0.7)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffFFFFFF), const Color(0xffFFFFFF)],
];

final myItemSortListData = [
  {
    "name": "New Listings",
    "value": "latest"
  },
  {
    "name": "Old Listings",
    "value": "oldest"
  },
  {
    "name": "Price: Low to High",
    "value": "low_to_high"
  },
  {
    "name": "Price: High to Low",
    "value": "high_to_low"
  },

];

final countryListData = [
  "Canada", "Bangladesh", "South Afrika", "United State"
];

final dropDownListData = [
  {
    "title": "+5km",
    "value": "5"
  },
  {
  "title": "+10km",
  "value": "10"
  },
  {
  "title": "+15km",
  "value": "15"
  },
  {
  "title": "+30km",
  "value": "30"
  },
  {
  "title": "+50km",
  "value": "50"
  },
  {
  "title": "+150km",
  "value": "150"
  },
];

final scrollTabList = [
  "electronic", "property", "service", "pets & animal", "vehicle", "Education", "Job"
];

final categoryList = [
  "Event, Travel & Hotel", "Education & related services", "Industrial & business to business", "Jobs offer/Looking for a job"
];

const fuelTypeList = ["diesel","petrol","cng","hybrid","electric","octane","lpg","other"];
const vehicleBodyTypeList = ["Saloon","Hatchback","Estate","Convertible","Coupe/Sports","SUV/4X4","MVP","Others"];
const ramList = ["1 GB","2 GB","3 GB","4 GB","6 GB","8 GB","16 GB & Above"];
const propertySizeList = ["sqft","katha", "bigha","acres","shotok","decimal"];
const propertyPriceList = ["total price","per sqft","per katha", "per bigha", "per acres", "per shotok","per decimal"];
const jobTypeList = ["Full Time","Part Time","Contractual","Internship"];

final statusTypeList = [
  {
    "title": "Deactive",
    "value": "pending"
  },
  {
    "title": "Sold",
    "value": "sold"
  },
];
final statusTypeEditList = [
  {
    "title": "Deactive",
    "value": "pending"
  },
  {
    "title": "Sold",
    "value": "sold"
  },
];

const educationList = ["Primary School","Secondary School","SSC / O level","HSC / A level","Diploma", "Honors / BBA", "Masters / MBA", "phD / Doctorate"];
const noCommonFieldList = [2,7,10,25,26];

// const reasonTypeList = ["Item sold/unavailable","Fraud","Duplicate","Spam","Wrong category","Offensive","Other"];
const reasonTypeList = [

  {
    "id": "1",
    "name" : "Item sold/unavailable"
  },
  {
    "id": "2",
    "name" : "Fraud"
  },
  {
    "id": "3",
    "name" : "Duplicate"
  },
  {
    "id": "4",
    "name" : "Spam"
  },
  {
    "id": "5",
    "name" : "Wrong category"
  },
  {
    "id": "6",
    "name" : "Offensive"
  },
  {
    "id": "7",
    "name" : "Other"
  },

];
