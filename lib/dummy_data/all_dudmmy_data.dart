import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ekayzone/modules/blog/model/blog_model.dart';
import 'package:ekayzone/modules/category/model/category_model.dart';
import 'package:ekayzone/modules/dashboard/model/dashboard_card_model.dart';
import 'package:ekayzone/modules/home/model/product_model.dart';
import 'package:ekayzone/modules/home/model/slider_model.dart';
import 'package:ekayzone/modules/location/model/location_model.dart';
import 'package:ekayzone/modules/profile/model/public_profile_model.dart';

final sliderList = [
  const SliderModel(
      id: 1,
      title: "",
      description: "",
      image: "uploads/custom-images/slider-2022-11-13-10-50-32-4131.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 2,
      title: "",
      description: "",
      image: "uploads/custom-images/slider-2022-11-13-10-54-28-1362.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 3,
      title: "",
      description: "",
      image: "uploads/custom-images/slider-2022-11-13-10-54-52-4479.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 4,
      title: "",
      description: "",
      image: "uploads/custom-images/slider-2022-11-13-10-55-11-3042.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 5,
      title: "",
      description: "",
      image: "uploads/custom-images/slider-2022-11-13-10-50-32-4131.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
];

final imageList = [
  const SliderModel(
      id: 1,
      title: "",
      description: "",
      image: "https://adlisting.templatecookie.com/dummy/product/vehicles/car/Acura.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 2,
      title: "",
      description: "",
      image: "https://adlisting.templatecookie.com/dummy/product/vehicles/car/Equinox.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 3,
      title: "",
      description: "",
      image: "https://adlisting.templatecookie.com/dummy/product/vehicles/car/Dodge.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
  const SliderModel(
      id: 4,
      title: "",
      description: "",
      image: "https://adlisting.templatecookie.com/dummy/product/vehicles/car/Roadster.jpg",
      link: "",
      status: 1,
      serial: 1,
      createdAt: "",
      updatedAt: ""
  ),
];

final products = [
  const ProductModel(
      id: 1,
      title: "Samsung Galaxy A04s",
      category: "Mobile",
      image: "https://www.mobiledokan.com/wp-content/uploads/2022/03/Samsung-Galaxy-A03.jpg",
      model: "Samsung",
      authenticity: 'New',
      condition: 'New',
      negotiable: "Yes",
      location: "Uttara,Dhaka",
      price: 22499.0,
  ),
  const ProductModel(
      id: 1,
      title: "Samsung Galaxy A32s",
      category: "Mobile",
      image: "https://www.mobiledokan.com/wp-content/uploads/2022/10/Samsung-Galaxy-A04s.jpg",
      model: "Samsung",
      authenticity: 'New',
      condition: 'New',
      negotiable: "Yes",
      location: "Uttara,Dhaka",
      price: 22499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Samsung Galaxy F13",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2022/08/Samsung-Galaxy-F13.jpg",
    model: "Samsung",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Uttara,Dhaka",
    price: 22499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Samsung Galaxy A23",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2022/04/Samsung-Galaxy-A23.jpg",
    model: "Samsung",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Uttara,Dhaka",
    price: 33499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Samsung Galaxy A72",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2021/03/Samsung-Galaxy-A72-image.jpg",
    model: "Samsung",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Uttara,Dhaka",
    price: 54499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 14 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2022/09/Apple-iPhone-14-Pro-Max.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 13 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2021/10/Apple-iPhone-13-Pro-Max-image.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 11 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2019/09/Apple-iPhone-11-Pro-Max.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 14 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2022/09/Apple-iPhone-14-Pro-Max.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 13 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2021/10/Apple-iPhone-13-Pro-Max-image.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
  const ProductModel(
    id: 1,
    title: "Apple I-Phone 11 Pro Max",
    category: "Mobile",
    image: "https://www.mobiledokan.com/wp-content/uploads/2019/09/Apple-iPhone-11-Pro-Max.jpg",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 122499.0,
  ),
];

final locationList = [
  const LocationModel(
      id: 1,
      title: "All of Bangladesh",
      subLocation: []
  ),
  const LocationModel(
      id: 1,
      title: "Dhaka",
      subLocation: [
        "Mirpur",
        "Uttara",
        "Mohammadpur",
        "Dhanmondi",
        "Banani",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Chattogram",
      subLocation: [
        "Agrabad",
        "Kowali",
        "Nasirabad",
        "Halisahar",
        "Baizid",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Sylhet",
      subLocation: [
        "Zinda Bazar",
        "Amber Khana",
        "South Surma",
        "Uposhoor",
        "Shibgonj",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Khulna",
      subLocation: [
        "Khulna Sadar",
        "Doulatpur",
        "Khalishpur",
        "Boyra Bazar",
        "Rupsa",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Barishal",
      subLocation: [
        "Sadar Road",
        "Amtala",
        "Bangla Bazar",
        "Kashipur",
        "Natun Bazar",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Rajshahi",
      subLocation: [
        "Khulna Sadar",
        "Doulatpur",
        "Khalishpur",
        "Boyra Bazar",
        "Rupsa",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Rangpur",
      subLocation: [
        "Zinda Bazar",
        "Amber Khana",
        "South Surma",
        "Uposhoor",
        "Shibgonj",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Mymensingh",
      subLocation: [
        "Kowali",
        "KowaliAgrabad",
        "Nasirabad",
        "Halisahar",
        "Baizid",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Dhaka Division",
      subLocation: [
        "Narayanganj",
        "Gazipur",
        "Demra",
        "Damal",
        "Banani",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Chattogram Division",
      subLocation: [
        "Feni",
        "Cumilla",
        "Rangamati",
        "Cox's Bazar",
        "Teknaf",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Sylhet Division",
      subLocation: [
        "Hobiganj ",
        "Bholagonj",
        "Sunamganj",
        "Akhaura",
        "Shibgonj",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Khulna Division",
      subLocation: [
        "Feni",
        "Cumilla",
        "Rangamati",
        "Cox's Bazar",
        "Teknaf",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Barishal Division",
      subLocation: [
        "Narayanganj",
        "Gazipur",
        "Demra",
        "Damal",
        "Banani",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Rajshahi Division",
      subLocation: [
        "Nimtola",
        "Amtala",
        "Jolpai Ghuri",
        "Damal",
        "Banani",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Rangpur Division",
      subLocation: [
        "Narayanganj",
        "Gazipur",
        "Demra",
        "Damal",
        "Banani",
      ]
  ),
  const LocationModel(
      id: 1,
      title: "Mymensingh Division",
      subLocation: [
        "Kowali",
        "KowaliAgrabad",
        "Nasirabad",
        "Halisahar",
        "Baizid",
      ]
  ),
];

final categoryList = [
  const CategoryModel(
      id: 0,
      title: "Go to All Category",
      subCategory: []
  ),
  const CategoryModel(
      id: 1,
      title: "Mobile",
      subCategory: [
        "Mobile Phones",
        "Wearables",
        "SIM Cards",
        "Mobile Phone Services",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Mens Fashion & Grooming",
      subCategory: [
        "Jacket & Coat",
        "Shirts & T-Shirt",
        "Pants",
        "Traditional Clothing",
        "Baby Boy's Fashion",
        "Bags & Accessories",
        "Footwear",
        "Watches",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Women's Fashion & Beauty",
      subCategory: [
        "Traditional Wear",
        "Winter Wear",
        "Western Wear",
        "Bags & Accessories",
        "Footwear",
        "Lingerie & Sleepwear",
        "Beauty & Personal Care",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Electronics",
      subCategory: [
        "Desktop Computers",
        "Laptops",
        "Laptop & Accessories",
        "TVs",
        "Home Appliances",
        "Other Electronics",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Vehicles",
      subCategory: [
        "Cars",
        "Motorbikes",
        "Bicycles",
        "Trucks",
        "Three Wheelers",
        "Vans",
        "Buses",
        "Heavy Duty",
        "Water Transport",
        "Rental",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Property",
      subCategory: [
        "Land For Sale",
        "Apartments For Sale",
        "Houses For Sale",
        "Commercial Properties For Sale",
        "New Projects",
        "Apartment Rentals",
        "Room Rentals",
        "Land Rentals",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Pets & Animals",
      subCategory: [
        "Pets",
        "Farm Animals",
        "Per & Animal Accessories",
        "Other Pets & Animal",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Hobbies, Sports & Kids",
      subCategory: [
        "Feni",
        "Cumilla",
        "Rangamati",
        "Cox's Bazar",
        "Teknaf",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Education",
      subCategory: [
        "Textbooks",
        "Tution",
        "Courses",
        "Study Abroad",
        "Other Education",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Essentials",
      subCategory: [
        "Grocery",
        "Fruits & Vegetables",
        "Meat & Seafood",
        "Baby Products",
        "Health Care",
        "House Hold",
        "Other Essential",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Services",
      subCategory: [
        "Building maintenance",
        "Domestic & Daycare Services",
        "Fitness & Beauty Sevices",
        "IT Services",
        "Matrimonial",
        "Service & Repair",
      ]
  ),
  const CategoryModel(
      id: 1,
      title: "Jobs",
      subCategory: [
        "Nimtola",
        "Amtala",
        "Jolpai Ghuri",
        "Damal",
        "Banani",
      ]
  ),
];

final dashboardCardList = [
  const DashboardCardModel(id: 1, title: "Posted Ads", value: 15, image: Icons.library_books_rounded),
  // const DashboardCardModel(id: 2, title: "Favourite Ads", value: 7, image: Icons.favorite),
  const DashboardCardModel(id: 5, title: "Featured Ads", value: 5, image: Icons.featured_play_list_rounded),
  const DashboardCardModel(id: 3, title: "Expire Ads", value: 6, image: Icons.bookmark_remove_sharp),
  const DashboardCardModel(id: 4, title: "Remaining Ads", value: 10, image: Icons.list_alt),
];

final plansBillingList = [
  const ProductModel(
    id: 1,
    title: "Basic",
    category: "Mobile",
    image: "assets/images/basic.png",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 0,
  ),
  const ProductModel(
    id: 1,
    title: "Premium",
    category: "Mobile",
    image: "assets/images/premium.png",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 100.0,
  ),
  const ProductModel(
    id: 1,
    title: "Business",
    category: "Mobile",
    image: "assets/images/business.png",
    model: "Apple",
    authenticity: 'New',
    condition: 'New',
    negotiable: "Yes",
    location: "Banani,Dhaka",
    price: 500.0,
  ),
];

final blogList = [
  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://evbite.com/wp-content/uploads/2020/04/Ferrari-Red-Tesla-Cybertruck-4.jpg',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),
  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://www.cnet.com/a/img/resize/fcf3051d5af4d8ca924f2458d7519c1a71ef077d/hub/2021/04/02/2b950299-b983-45c3-a2c7-e29c8a4b24d2/0x0-cybertruck-14.jpg?auto=webp&fit=crop&height=675&width=1200',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),

  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://evbite.com/wp-content/uploads/2020/04/Ferrari-Red-Tesla-Cybertruck-4.jpg',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),

  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://www.cnet.com/a/img/resize/fcf3051d5af4d8ca924f2458d7519c1a71ef077d/hub/2021/04/02/2b950299-b983-45c3-a2c7-e29c8a4b24d2/0x0-cybertruck-14.jpg?auto=webp&fit=crop&height=675&width=1200',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),

  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://evbite.com/wp-content/uploads/2020/04/Ferrari-Red-Tesla-Cybertruck-4.jpg',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),

  const BlogModel(
      id: 1,
      title: 'Why the tesla cybertruck design the way it is ?',
      category: 'TECHNOLOGY',
      image: 'https://www.cnet.com/a/img/resize/fcf3051d5af4d8ca924f2458d7519c1a71ef077d/hub/2021/04/02/2b950299-b983-45c3-a2c7-e29c8a4b24d2/0x0-cybertruck-14.jpg?auto=webp&fit=crop&height=675&width=1200',
      summery: 'An exploration into the trucks polarising design.',
      publishDate: '2 day\'s ago'
  ),
];

final socialNameList = [
  const SocialMedias(
    id: 0,
    socialMedia: "facebook",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "twitter",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "instagram",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "youtube",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "linkedin",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "pinterest",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "reddit",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "github",
    url: '',
  ),
  const SocialMedias(
    id: 0,
    socialMedia: "other",
    url: '',
  ),
];