/*
 * 粘贴板管理工具页面
 * @Author: lilonglong
 * @Date: 2023-12-14 23:20:52
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-14 16:21:13
 */

import 'package:flutter/material.dart';

class Paster extends StatefulWidget {
  const Paster({Key? key}) : super(key: key);

  @override
  PasterState createState() => PasterState();
}

class PasterState extends State<Paster> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [Text('paster')],
    );
  }
}
