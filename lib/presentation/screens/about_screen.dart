import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giới thiệu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'News App',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Ứng dụng quản lý tin tức cá nhân được xây dựng bằng Flutter.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Chức năng:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('- Xem danh sách tin tức'),
            Text('- Xem chi tiết bài viết'),
            Text('- Đánh dấu yêu thích'),
            Text('- Tìm kiếm bài viết'),
            SizedBox(height: 20),
            Text(
              'Sinh viên thực hiện:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Tên: Mai Thành Đạt'),
            Text('Mã Sinh Viên 20221720'),
          ],
        ),
      ),
    );
  }
}