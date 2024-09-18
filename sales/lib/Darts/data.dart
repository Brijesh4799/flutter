import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:salescrm/Darts/expensedata.dart';
import 'package:salescrm/Darts/salepipedetaildata.dart';
import 'package:salescrm/Darts/salepipeheaderdata.dart';
import 'package:salescrm/Models/itemodel.dart';

import 'calldatedata.dart';
import 'calltodaydata.dart';
import 'calltomorrowdata.dart';
import 'items.dart';

var itemscity =[
  new Items(customer: "Pratibha Ratta", prod: "T-INB", imageurl: "call.png",status: "+ Action"),
  new Items(customer: "Advik Sant", prod: "T-OUT", imageurl: "meeting.png",status: "+ Action"),
  new Items(customer: "Vasu Dalal", prod: "T-M", imageurl: "call.png",status: "+ Action"),
  new Items(customer: "Rashmi Sub..", prod: "T-ERP", imageurl: "meeting.png",status: "+ Action"),

];


var calltodaydata =[
  new CallTodayData(name: "Gaurav Dasgupta",company: "Wayne Enterprises",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "9455561136",meetingtime: "09:00 AM to 11:00 AM",location: "Zoom Call",priority: "MEDIUM", imageurl: "meeting.png",date: "06-09-2022",time: "9:00 AM"),
  new CallTodayData(name: "Ashita Singhal",company: "Boehm and Sons Travel",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "9455561136",meetingtime: "11:00 AM to 01:00 AM",location: "201 A, Shivam Satyam, M G Rd, Ghathkoper(east)",priority: "LOW",imageurl: "meeting.png",date: "07-09-2022",time: "10:00 AM"),
  new CallTodayData(name: "Advay Chatterjee",company: "Bernhard Inc",agenda: "Meeting",status: "CANCELED", mobileno: "+91-9255576569",whatsappno: "9455561184",meetingtime: "01:00 AM to 03:00 AM", location: "Zoom Call",priority: "MEDIUM",imageurl: "meeting.png",date: "08-09-2022",time: "11:45 AM"),
  new CallTodayData(name: "Rupa Gaungly",company: "Huel PLC",agenda: "Follow-up",status: "HELD", mobileno: "+91-9255576493",whatsappno: "3858650214",meetingtime: "03:00 AM to 05:00 AM", location: "Zoom Call",priority: "HIGH",imageurl: "meeting.png",date: "12-09-2022",time: "12:30 AM"),
  new CallTodayData(name: "Kavika Bose",company: "Friesen Travel Ltd",agenda: "Online Meeting",status: "RESCHEDULED", mobileno: "9255576493",whatsappno: "9455561136",meetingtime: "05:00 AM to 07:00 AM", location: "24/4, Kailash Estate,Opp Sugnan High School Viratnagar, Odhav",priority: "MEDIUM",imageurl: "meeting.png",date: "13-09-2022",time: "01:00 PM"),
  new CallTodayData(name: "Disha Gulati",company: "Metz Travel",agenda: "Call",status: "SCHEDULED", mobileno: "+91-8555007711",whatsappno: "3855908823",meetingtime: "07:00 AM to 09:00 AM",location: "2nd Flr, 187, Mapla Building, Rehman Street Mandvi",priority: "LOW", imageurl: "meeting.png",date: "14-09-2022",time: "7:00 PM"),
];

var expensedata =[
  new ExpenseData(company: "Safari Travel Services",name: "Apurva Kaul",email: "apurvaka@gmail.com",mobileno: "+91-855063621",whatsappno: "+91-855063621",clientname: "PRAVEEN KUMAR",status: "Active",address: "950, Sagar Kutir, Versova Road,Behind Sea Pearl, 7 Bunglow Andheri(west)"),
  new ExpenseData(company: "Destiny Travel International",name: "Samir Mistry",email: "samirmist@gmail.com",mobileno: "+91-9255576493",whatsappno: "+91-9255576493", clientname: "ADVIK JAIN",status: "Active",address: "323B, Tumkur Rd ,Near Bus Stop,T Dasarhalli, Bangalore"),
  new ExpenseData(company: "Sites & Sounds Tourism",name: "Indra Ganguly",email: "indragang@gmail.com",mobileno: "+91-7555033109",whatsappno: "+91-7555033109",clientname: "ADVIK JAIN",status: "Active",address: "209, Devrata, Sector 17, Vashi, Mumbai"),
  new ExpenseData(company: "Coastline Corporate Travel Co.",name: "Navin Chaudhary",email: "navincho@gmail.com",mobileno: "+91-9655524408",whatsappno: "+91-9655524408",clientname: "MAHENDRA SONI",status: "Active",address: "6-33,Balaji Mansion, Moonsapet Hydrabad"),
  new ExpenseData(company: "Titan Company",name: "Priti BalaKrishnan",email: "pritibalak@gmail.com",mobileno: "+91-90555533900",whatsappno: "+91-90555533900",clientname: "PRAVEEN KUMAR",status: "Active",address: "8/16, 2nd Floor Patel Building MK Amin Nagar Mumbai"),
  new ExpenseData(company: "Destination Vacation",name: "Ayaan Raval",email: "ayaanrav@gmail.com",mobileno: "+91-8555152896",whatsappno: "+91-8555152896",clientname: "NIKHIL AGARWAL",status: "Active",address: "B 34/04, Sector 8,Sanpada,Navi Mumbai"),
  new ExpenseData(company: "World Wide Travel",name: "Amitabh Panchal",email: "amitpan@gmail.com",mobileno: "+91-70555153806",whatsappno: "+91-7055515386",clientname: "ADVIK JAIN",status: "Active",address: "B-61, MahaDevPura Sector 15 Amit Apartment Mumbai"),
];


var calltomorrowdata =[
  new CallTomorrowData(name: "Advay Chatterjee",company: "Bernhard Inc",agenda: "Meeting",status: "CANCELED", mobileno: "+91-9255576569",whatsappno: "+91-9455561184"),
  new CallTomorrowData(name: "Rupa Gaungly",company: "Huel PLC",agenda: "Follow-up",status: "CANCELED", mobileno: "+91-9255576493",whatsappno: "+91-3858650214"),
  new CallTomorrowData(name: "Gaurav Dasgupta",company: "Wayne Enterprises",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallTomorrowData(name: "Ashita Singhal",company: "Boehm and Sons Travel",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallTomorrowData(name: "Kavika Bose",company: "Friesen Travel Ltd",agenda: "Online Meeting",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallTomorrowData(name: "Disha Gulati",company: "Metz Travel",agenda: "Call",status: "SCHEDULED", mobileno: "+91-8555007711",whatsappno: "+91-3855908823"),
];


var calldatedata =[
  new CallDateData(name: "Kavika Bose",company: "Friesen Travel Ltd",agenda: "Online Meeting",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallDateData(name: "Disha Gulati",company: "Metz Travel",agenda: "Call",status: "SCHEDULED", mobileno: "+91-8555007711",whatsappno: "+91-3855908823"),
  new CallDateData(name: "Gaurav Dasgupta",company: "Wayne Enterprises",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallDateData(name: "Ashita Singhal",company: "Boehm and Sons Travel",agenda: "Follow-up",status: "RESCHEDULED", mobileno: "+91-9255576493",whatsappno: "+91-9455561136"),
  new CallDateData(name: "Advay Chatterjee",company: "Bernhard Inc",agenda: "Meeting",status: "CANCELED", mobileno: "+91-9255576569",whatsappno: "+91-9455561184"),
  new CallDateData(name: "Rupa Gaungly",company: "Huel PLC",agenda: "Follow-up",status: "CANCELED", mobileno: "+91-9255576493",whatsappno: "+91-3858650214"),
  ];

var salepipeheaderdata =[
  new SalePipeHeaderData(name: "Assigned",percent: "20%"),
  new SalePipeHeaderData(name: "Reverted",percent: "08%"),
  new SalePipeHeaderData(name: "Option Sent",percent: "10%"),
  new SalePipeHeaderData(name: "Follow-up",percent: "10%"),
  new SalePipeHeaderData(name: "Confirmed",percent: "50%"),
  new SalePipeHeaderData(name: "Query Lost",percent: "2%"),
];

var salepipedetaildatassign =[
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(company: "Safari Travel Services",clientname: "Apurva Kaul",date: "02-11-2022"),
  new SalePipeDetailData(company: "Destiny Travel International",clientname: "Samir Mistry",date: "02-11-2022"),
  new SalePipeDetailData(company: "Sites & Sounds Tourism",clientname: "Indra Ganguly",date: "06-11-2022"),
  new SalePipeDetailData(company: "Coastline Corporate Travel Co.",clientname: "Navin Chaudhary",date: "06-11-2022"),
  new SalePipeDetailData(company: "Titan Company",clientname: "Priti BalaKrishnan",date: "10-11-2022"),
  new SalePipeDetailData(company: "Destination Vacation",clientname: "Ayaan Raval",date: "10-11-2022"),
  new SalePipeDetailData(company: "World Wide Travel",clientname: "Amitabh Panchal",date: "12-11-2022"),
];

var salepipedetaildatarevert =[
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(date: "12-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
  new SalePipeDetailData(date: "14-11-2022",clientname: "World Wide Travel",company: "Amitabh Panchal"),
  new SalePipeDetailData(date: "16-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
];

var salepipedetaildatafollow =[
  new SalePipeDetailData(company: "Sites & Sounds Tourism",clientname: "Indra Ganguly",date: "06-11-2022"),
  new SalePipeDetailData(company: "Coastline Corporate Travel Co.",clientname: "Navin Chaudhary",date: "06-11-2022"),
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(date: "12-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
  new SalePipeDetailData(date: "14-11-2022",clientname: "World Wide Travel",company: "Amitabh Panchal"),
  new SalePipeDetailData(date: "16-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
];

var salepipedetaildataconfirm =[
  new SalePipeDetailData(company: "Sites & Sounds Tourism",clientname: "Indra Ganguly",date: "06-11-2022"),
  new SalePipeDetailData(company: "Coastline Corporate Travel Co.",clientname: "Navin Chaudhary",date: "06-11-2022"),
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(date: "12-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
  new SalePipeDetailData(date: "14-11-2022",clientname: "World Wide Travel",company: "Amitabh Panchal"),
  new SalePipeDetailData(date: "16-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
];

var salepipedetaildataoptionsent =[
  new SalePipeDetailData(company: "Destination Vacation",clientname: "Ayaan Raval",date: "10-11-2022"),
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(date: "12-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
  new SalePipeDetailData(date: "14-11-2022",clientname: "World Wide Travel",company: "Amitabh Panchal"),
  new SalePipeDetailData(date: "16-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
];

var salepipedetaildataoptionquery =[
  new SalePipeDetailData(company: "World Wide Travel",clientname: "Amitabh Panchal",date: "12-11-2022"),
  new SalePipeDetailData(company: "Destination Vacation",clientname: "Ayaan Raval",date: "10-11-2022"),
  new SalePipeDetailData(date: "10-11-2022",clientname: "Titan Company",company: "Priti BalaKrishnan"),
  new SalePipeDetailData(date: "12-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
  new SalePipeDetailData(date: "14-11-2022",clientname: "World Wide Travel",company: "Amitabh Panchal"),
  new SalePipeDetailData(date: "16-11-2022",clientname: "Destination Vacation",company: "Ayaan Raval"),
];

var alertdatapay =[
  new AlertModel(status: "0", img: "paycolor.png", time: "Payment follow up time 2:00 pm", name: "Pratibha Ratta", period: "10 min ago", date: "24 Apr 2023",arrow: "payarrow.png"),
  new AlertModel(status: "0", img: "paycolor.png", time: "Payment follow up time 2:00 pm", name: "Harshit Garg", period: "10 min ago", date: "24 Apr 2023",arrow: "payarrow.png"),
  new AlertModel(status: "0", img: "paycolor.png", time: "Payment follow up time 2:00 pm", name: "A.K. Modi", period: "10 min ago", date: "24 Apr 2023",arrow: "payarrow.png"),
  new AlertModel(status: "0", img: "paycolor.png", time: "Payment follow up time 2:00 pm", name: "Prarena Goswami", period: "10 min ago", date: "24 Apr 2023",arrow: "payarrow.png"),
  new AlertModel(status: "0", img: "paycolor.png", time: "Payment follow up time 2:00 pm", name: "Anupma Singh", period: "10 min ago", date: "24 Apr 2023",arrow: "payarrow.png"),
  new AlertModel(status: "1", img: "paybw.png", time: "Payment follow up time 2:00 pm", name: "Pratibha Ratta", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "paybw.png", time: "Payment follow up time 4:30 pm", name: "David George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "paybw.png", time: "Payment follow up time 4:30 pm", name: "Tom Michael", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "paybw.png", time: "Payment follow up time 4:30 pm", name: "Tom Michael", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")

];

var alertdatameet =[
  new AlertModel(status: "0", img: "meetcolor.png", time: "Meeting Schedule at 6:00 pm", name: "Pratibha Ratta", period: "10 min ago", date: "24 Apr 2023",arrow: "meetarrow.png"),
  new AlertModel(status: "0", img: "meetcolor.png", time: "Payment follow at 1:00 pm", name: "Harshit Garg", period: "10 min ago", date: "24 Apr 2023",arrow: "meetarrow.png"),
  new AlertModel(status: "0", img: "meetcolor.png", time: "Payment follow at 4:00 pm", name: "A.K. Modi", period: "10 min ago", date: "24 Apr 2023",arrow: "meetarrow.png"),
  new AlertModel(status: "0", img: "meetcolor.png", time: "Payment follow at 9:00 pm", name: "Prarena Goswami", period: "10 min ago", date: "24 Apr 2023",arrow: "meetarrow.png"),
  new AlertModel(status: "0", img: "meetcolor.png", time: "Payment follow at 8:00 pm", name: "Anupma Singh", period: "10 min ago", date: "24 Apr 2023",arrow: "meetarrow.png"),
  new AlertModel(status: "1", img: "meetbw.png", time: "Payment follow at 6:00 pm", name: "Pratibha Ratta", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "meetbw.png", time: "Payment follow at 5:00 pm", name: "David George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
 // new AlertModel(status: "1", img: "meetbw.png", time: "Payment follow at 4:00 pm", name: "Tom Michael", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")
 // new AlertModel(status: "1", img: "meetbw.png", time: "Payment follow at 3:30 pm", name: "Tim George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")

];

var alertdatatask =[
  new AlertModel(status: "0", img: "taskcolor.png", time: "Task Schedule at 6:00 pm", name: "Pratibha Ratta", period: "10 min ago", date: "24 Apr 2023",arrow: "taskarrow.png"),
  new AlertModel(status: "0", img: "taskcolor.png", time: "Task follow at 3:00 pm", name: "Harshit Garg", period: "10 min ago", date: "24 Apr 2023",arrow: "taskarrow.png"),
  new AlertModel(status: "0", img: "taskcolor.png", time: "Task follow at 8:00 pm", name: "A.K. Modi", period: "10 min ago", date: "24 Apr 2023",arrow: "taskarrow.png"),
  new AlertModel(status: "0", img: "taskcolor.png", time: "Task follow at 4:00 pm", name: "Prarena Goswami", period: "10 min ago", date: "24 Apr 2023",arrow: "taskarrow.png"),
  new AlertModel(status: "0", img: "taskcolor.png", time: "Task follow at 9:00 pm", name: "Anupma Singh", period: "10 min ago", date: "24 Apr 2023",arrow: "taskarrow.png"),
  new AlertModel(status: "1", img: "taskbw.png", time: "Task follow at 2:00 pm", name: "Pratibha Ratta", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "taskbw.png", time: "Task follow at 4:00 pm", name: "David George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "taskbw.png", time: "Task follow at 3:30 pm", name: "Tom Michael", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")
 // new AlertModel(status: "1", img: "taskbw.png", time: "Task follow at time 3:00 pm", name: "Tim George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")

];

var alertdataover =[
  new AlertModel(status: "0", img: "overduecolor.png", time: "Payment Overdue up time 6:00 pm", name: "Pratibha Ratta", period: "10 min ago", date: "24 Apr 2023",arrow: "overduearrow.png"),
  new AlertModel(status: "0", img: "overduecolor.png", time: "Payment Overdue up time 4:00 pm", name: "Harshit Garg", period: "10 min ago", date: "24 Apr 2023",arrow: "overduearrow.png"),
  new AlertModel(status: "0", img: "overduecolor.png", time: "Payment Overdue up time 3:00 pm", name: "A.K. Modi", period: "10 min ago", date: "24 Apr 2023",arrow: "overduearrow.png"),
  new AlertModel(status: "0", img: "overduecolor.png", time: "Payment Overdue up time 8:00 pm", name: "Prarena Goswami", period: "10 min ago", date: "24 Apr 2023",arrow: "overduearrow.png"),
 // new AlertModel(status: "0", img: "overduecolor.png", time: "Payment Overdue up time 7:00 pm", name: "Anupma Singh", period: "10 min ago", date: "24 Apr 2023",arrow: "overduearrow.png"),
  new AlertModel(status: "1", img: "overduebw.png", time: "Payment Overdue up time 3:30 pm", name: "Pratibha Ratta", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png"),
  new AlertModel(status: "1", img: "overduebw.png", time: "Payment Overdue up time 4:00 pm", name: "David George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")
 // new AlertModel(status: "1", img: "overduebw.png", time: "Payment Overdue up time 1:00 pm", name: "Pratibha Ratta", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")
 // new AlertModel(status: "1", img: "overduebw.png", time: "Payment Overdue up time 2:00 pm", name: "David George", period: "57 min ago", date: "04 Dec 2022",arrow: "alertarrow.png")

];


// Image.asset("image/akshardham.jpg",height: 100, width: 100,)