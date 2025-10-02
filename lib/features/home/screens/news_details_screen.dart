// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:news_app/features/home/data/home_model.dart';

// class NewsDetailsScreen extends StatelessWidget {
//   const NewsDetailsScreen({super.key, required this.articaleModel});
//   final ArticaleModel articaleModel;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.transparent),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12.r),
//               child: CachedNetworkImage(
//                 height: 240.h,
//                 width: double.infinity,
//                 imageUrl: articaleModel.urlToImage!,
//                 placeholder: (context, url) =>
//                     const Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               articaleModel.title,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   articaleModel.author ?? 'Unknown',
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 const SizedBox(width: 16),
//                 Text(
//                   articaleModel.publishedAt != null
//                       ? '${articaleModel.publishedAt!.day}/${articaleModel.publishedAt!.month}/${articaleModel.publishedAt!.year}'
//                       : 'Unknown date',
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               articaleModel.description ?? '',
//               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 16.h),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   articaleModel.content ?? '',
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
