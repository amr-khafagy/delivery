import 'package:delivery/data/model/ordersmodel.dart';

class DemoOrders {
  const DemoOrders._();

  static final pending = <OrdersModel>[
    OrdersModel(
      ordersId: '3028',
      ordersUserid: '101',
      ordersType: '0',
      ordersPricedelivery: '25',
      ordersPrice: '185',
      ordersPaymentmethod: '0',
      ordersTotalprice: '210',
      ordersStatues: '2',
      ordersDatetime: '2026-11-17 17:30:00',
      addressName: 'Maya Adel',
      addressCity: 'Giza',
      addressStreet: 'Zayed Square',
      addressLat: '30.0114',
      addressLang: '31.2060',
    ),
  ];

  static final accepted = <OrdersModel>[
    OrdersModel(
      ordersId: '3019',
      ordersUserid: '102',
      ordersType: '0',
      ordersPricedelivery: '30',
      ordersPrice: '260',
      ordersPaymentmethod: '1',
      ordersTotalprice: '290',
      ordersStatues: '3',
      ordersDatetime: '2026-11-17 17:10:00',
      addressName: 'Omar Ahmed',
      addressCity: 'Giza',
      addressStreet: 'Smart Village',
      addressLat: '30.0587',
      addressLang: '31.0211',
    ),
  ];
}
