import 'dart:convert';

import 'package:edupluz_future/core/models/courses/exam_model.dart';

var _fakeExam = {
  "id": "67ea20917e73bd4e42b8441b",
  "type": "EXAM",
  "name": "แบบทดสอบหลังเรียน",
  "is_free": false,
  "sequence": 9,
  "content": {
    "exam": {
      "questions": [
        {
          "id": "67ea20917e73bd4e42b84420",
          "title":
              "สิ่งแรกที่คุณต้องรู้ ก่อนเริ่มสร้างแคมเปญโฆษณาสำหรับ Facebook เสมอ คืออะไร",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b8441c",
              "choice": "A",
              "title": "การใส่จำนวนเงินงบประมาณในการยิงแอดโฆษณา",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8441d",
              "choice": "B",
              "title":
                  "การกำหนด Ad Set ตั้งกลุ่มเป้าหมายว่าสำหรับใคร พื้นที่ไหน",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8441e",
              "choice": "C",
              "title": "การเลือกรูปแบบโฆษณาว่าต้องการให้ลูกค้ามองเห็นอะไรบ้าง",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8441f",
              "choice": "D",
              "title": "วัตถุประสงค์ของแคมเปญโฆษณา",
              "is_correct": null
            }
          ],
          "sequence": 1
        },
        {
          "id": "67ea20917e73bd4e42b84425",
          "title":
              "สาเหตุที่ Facebook ลดการมองเห็นของเรามาจากหลายปัจจัยด้วยกัน แต่ในคำตอบต่อไปนี้ อะไรที่ไม่ใช่สาเหตุ",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84421",
              "choice": "A",
              "title": "ใส่ลิ้งค์เว็บไซต์ของเราลงไปในโพสต์ Facebook",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84422",
              "choice": "B",
              "title": "ใส่สิงค์ออกไปที่หน้าร้านออนไลน์ของเรา เช่นทาง Shopee",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84423",
              "choice": "C",
              "title": "ทำไลฟ์สดผ่านทาง Facebook",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84424",
              "choice": "D",
              "title": "ไม่มีข้อใดถูก",
              "is_correct": null
            }
          ],
          "sequence": 2
        },
        {
          "id": "67ea20917e73bd4e42b8442a",
          "title": "ROAS (Return on Ad Spend) ควรใช้เพื่อเป้าหมายอะไร",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84426",
              "choice": "A",
              "title": "เพื่อวัดผลแคมเปญโฆษณาว่ามีประสิทธิภาพยังไง",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84427",
              "choice": "B",
              "title": "เพื่อตรวจสอบการทำงานของแคมเปญโฆษณาว่าละเมิดนโยบายไหม่",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84428",
              "choice": "C",
              "title": "เพื่อวัดผลการเข้าถึงลูกค้าในโฆษณา",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84429",
              "choice": "D",
              "title": "เพื่อตรวจสอบการยืนยันตัวตนในการทำแคมเปญโฆษณา",
              "is_correct": null
            }
          ],
          "sequence": 3
        },
        {
          "id": "67ea20917e73bd4e42b8442f",
          "title":
              "ROI (Return on Investment) ควรใช้เพื่อเป้าหมายในการค้นหาอะไร",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b8442b",
              "choice": "A",
              "title": "หาผลตอบแทนจากการใช้จ่ายค่าโฆษณาเป็นหลัก",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8442c",
              "choice": "B",
              "title": "หาผลตอบแทนที่จะเกิดขึ้นจากการลงทุนในค่าใช้จ่ายทั้งหมด",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8442d",
              "choice": "C",
              "title": "หากลยุทธ์ในการใช้จ่ายสำหรับโฆษณา",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8442e",
              "choice": "D",
              "title": "หาค่าค่าใช้จ่ายโฆษณาแบบเจาะจงเฉพาะแคมเปญ",
              "is_correct": null
            }
          ],
          "sequence": 4
        },
        {
          "id": "67ea20917e73bd4e42b84434",
          "title":
              "อะไรที่คือปัญหาที่จะเกิดขึ้นในการวิเคราะห์ค่า ROI เมื่อเปรียบเทียบกับ ROAS",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84430",
              "choice": "A",
              "title": "ไม่สามารถระบุถึงค่าใช้จ่ายภาพรวมในแคมเปญทั้งหมดได้",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84431",
              "choice": "B",
              "title": "เป็นการวัดผลที่ง่ายกว่า ROAS",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84432",
              "choice": "C",
              "title":
                  "ไม่ได้รู้รายละเอียดผลตอบแทนจากแคมเปญโฆษณาแบบเฉพาะเจาะจง",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84433",
              "choice": "D",
              "title": "ไม่มีข้อใดถูก",
              "is_correct": null
            }
          ],
          "sequence": 5
        },
        {
          "id": "67ea20917e73bd4e42b84439",
          "title":
              "วิธีการคำนวณต่อไปนี้ คือสูตรการคำนวณสำหรับหาค่าอะไร (รายได้ทั้งหมด – เงินลงทุนทั้งหมดที่ใช้ไป) / เงินลงทุนทั้งหมดที่ใช้ไป x 100 = %",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84435",
              "choice": "A",
              "title": "ROAS",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84436",
              "choice": "B",
              "title": "ROI",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84437",
              "choice": "C",
              "title": "Audience Targeting",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84438",
              "choice": "D",
              "title": "ไม่มีข้อใดถูก",
              "is_correct": null
            }
          ],
          "sequence": 6
        },
        {
          "id": "67ea20917e73bd4e42b8443e",
          "title": "ค่าใช้จ่ายอะไรบ้างที่ ใช้สำหรับหา ROAS",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b8443a",
              "choice": "A",
              "title": "ต้นทุนค่าใช้จ่ายทั้งหมด",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8443b",
              "choice": "B",
              "title": "ต้นทุนของราคาสินค้า",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8443c",
              "choice": "C",
              "title": "ค่าใช้จ่ายในการโฆษณา",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8443d",
              "choice": "D",
              "title": "ถูกทุกข้อ",
              "is_correct": null
            }
          ],
          "sequence": 7
        },
        {
          "id": "67ea20917e73bd4e42b84443",
          "title": "อะไรคือข้อดีของการวัดผล ROAS",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b8443f",
              "choice": "A",
              "title": "แสดงภาพรวมของผลตอบแทนจากการลงทุนได้ทั้งหมด",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84440",
              "choice": "B",
              "title":
                  "สามารถบอกได้ว่าแคมเปญที่เราทำนั้นมีคนคลิกเข้าเยอะหรือไม่",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84441",
              "choice": "C",
              "title":
                  "มองหาผลตอบแทนของการลงทุนโดยรวมแต่มีการวัดผลที่ค่อนข้างยาก",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84442",
              "choice": "D",
              "title": "วัดผลได้ง่ายและเหมาะสำหรับการวัดผลแคมเปญโฆษณา",
              "is_correct": null
            }
          ],
          "sequence": 8
        },
        {
          "id": "67ea20917e73bd4e42b84448",
          "title":
              "การกำหนด Audience Target ควรต้องรู้สิ่งเหล่านี้ แต่อะไรที่ไม่ใช่",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84444",
              "choice": "A",
              "title": "ตำแหน่ง สถานที่ เช่น กรุงเทพมหานคร, ปทุมธานี, นนทบุรี",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84445",
              "choice": "B",
              "title": "ช่วงอายุ เช่น 25 - 45 ปี",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84446",
              "choice": "C",
              "title": "ภาษาที่ใช้ เช่น ภาษาไทย, ภาษาอังกฤษ",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b84447",
              "choice": "D",
              "title": "วัตถุประสงค์ของแคมเปญโฆษณา",
              "is_correct": null
            }
          ],
          "sequence": 9
        },
        {
          "id": "67ea20917e73bd4e42b8444d",
          "title": "วิธีคิดค่า Cost per inbox แบบใดถูกต้อง",
          "choices": [
            {
              "id": "67ea20917e73bd4e42b84449",
              "choice": "A",
              "title":
                  "ต้นทุนค่าโฆษณา 500 บาท x จำนวนลูกค้าที่ทักเข้ามา 10 คน = ค่าโฆษณา 5,000 บาท",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8444a",
              "choice": "B",
              "title":
                  "ต้นทุนค่าโฆษณา 500 บาท x จำนวนลูกค้าที่สั่งซื้อ 2 คน = ค่าโฆษณา 1,000 บาท",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8444b",
              "choice": "C",
              "title":
                  "ต้นทุนค่าโฆษณา 500 บาท x จำนวนลูกค้าที่ทักเข้ามา 10 คน x จำนวนลูกค้าที่สั่งซื้อ 2 คน = ค่าโฆษณา 10,000 บาท คิดเป็นสมการ",
              "is_correct": null
            },
            {
              "id": "67ea20917e73bd4e42b8444c",
              "choice": "D",
              "title": "ไม่มีข้อใดถูก",
              "is_correct": null
            }
          ],
          "sequence": 10
        }
      ]
    }
  }
};

ExamModel fakeExam = examModelFromJson(jsonEncode(_fakeExam));
