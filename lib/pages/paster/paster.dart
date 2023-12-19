/*
 * 粘贴板管理工具页面
 * @Author: lilonglong
 * @Date: 2023-12-14 23:20:52
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-19 16:26:59
 */

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:super_clipboard/super_clipboard.dart';

class Paster extends StatefulWidget {
  const Paster({Key? key}) : super(key: key);

  @override
  PasterState createState() => PasterState();
}

class PasterState extends State<Paster> with ClipboardListener {
  List<ClipboardHistoryItem> historyList = [];

  bool tempDisableListener = false;

  @override
  void initState() {
    clipboardWatcher.addListener(this);
    // start watch
    clipboardWatcher.start();
    super.initState();
  }

  @override
  void dispose() {
    clipboardWatcher.removeListener(this);
    // stop watch
    clipboardWatcher.stop();
    super.dispose();
  }

  @override
  void onClipboardChanged() async {
    if (tempDisableListener) {
      return;
    }

    String? text = '';

    final reader = await ClipboardReader.readClipboard();

    if (reader.canProvide(Formats.plainText)) {
      text = await reader.readValue(Formats.plainText);
      ClipboardHistoryItem item = ClipboardHistoryItem(text: text);
      setState(() {
        historyList.insert(0, item);
      });
    } else if (reader.canProvide(Formats.png)) {
      /// Binary formats need to be read as streams
      reader.getFile(Formats.png, (file) async {
        // Do something with the PNG image
        final imageBytes = await file.readAll();
        ClipboardHistoryItem item =
            ClipboardHistoryItem(imageBytes: imageBytes);
        setState(() {
          historyList.insert(0, item);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8), child: Text('粘贴板历史')),
        const Divider(),
        Flexible(
            child: Align(
                alignment: Alignment.topLeft,
                child: _buildClipboardHistoryList(context))),
      ],
    );
  }

  Widget _buildClipboardHistoryList(BuildContext context) {
    // 横向滚动
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: historyList.length,
          itemBuilder: (BuildContext context, int index) {
            final historyItem = historyList[index];

            late Widget title;
            switch (historyItem.contentType) {
              case ClipboardContentType.text:
                title = Text(historyItem.text!);
                break;
              case ClipboardContentType.image:
                title = Image.memory(historyItem.imageBytes!);
                break;
              default:
                title = const Text('未知类型');
            }

            return Container(
                width: 280,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                                '${historyItem.timestamp!.hour}:${historyItem.timestamp!.minute}:${historyItem.timestamp!.second}')),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                historyList.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                    const Divider(),
                    Expanded(
                        child: ListTile(
                            title: title,
                            onTap: () async {
                              // 临时禁用监听
                              tempDisableListener = true;
                              // 写入剪贴板
                              await historyItem.writeToClipboard();
                              // TODO 待解决：首先需要使应用进入后台，然后激活之前的应用（有输入框的应用）
                              // 然后进行粘贴操作
                              // await FlutterClipboard.paste();
                              // 延迟后再次启用监听
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                tempDisableListener = false;
                                // 并将当前的历史记录移动到第一位
                                setState(() {
                                  historyList.removeAt(index);
                                  historyList.insert(0, historyItem);
                                });
                              });

                              // 展示提示信息
                              const snackBar = SnackBar(
                                content: Text('已复制到粘贴板～'),
                                duration: Duration(seconds: 2),
                                showCloseIcon: true,
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }))
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const VerticalDivider(width: 10, color: Colors.transparent),
        ));
  }
}

enum ClipboardContentType { empty, text, image }

class ClipboardHistoryItem {
  String? text;
  Uint8List? imageBytes;
  DateTime? timestamp;

  late ClipboardContentType contentType;

  ClipboardHistoryItem({this.text, this.imageBytes}) {
    if (text != null) {
      contentType = ClipboardContentType.text;
    } else if (imageBytes != null) {
      contentType = ClipboardContentType.image;
    } else {
      contentType = ClipboardContentType.empty;
    }
    timestamp = DateTime.now();
  }

  Future<void> writeToClipboard() async {
    final item = DataWriterItem();
    if (imageBytes != null) {
      item.add(Formats.png(imageBytes!));
    }
    if (text != null) {
      item.add(Formats.plainText(text!));
    }
    await ClipboardWriter.instance.write([item]);
  }
}
