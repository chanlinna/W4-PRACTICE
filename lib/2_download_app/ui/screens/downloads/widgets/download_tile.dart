import 'package:flutter/material.dart';
import 'package:w4_practice/2_download_app/ui/theme/theme.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final resourse = controller.ressource;
        final progress = controller.progress;
        final status = controller.status;
        final downloadedSize = resourse.size * progress;
        final percentage = progress * 100;

        return GestureDetector(
          onTap: status == DownloadStatus.notDownloaded
              ? controller.startDownload
              : null,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resourse.name,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.neutralDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${percentage.toStringAsFixed(1)} % completed - ${downloadedSize.toStringAsFixed(1)} of ${resourse.size} MB',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.neutral,
                      ),
                    ),
                  ],
                ),
                _buildStatusIcon(status),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return const Icon(Icons.download);
      case DownloadStatus.downloading:
        return const Icon(Icons.downloading);
      case DownloadStatus.downloaded:
        return const Icon(Icons.folder);
    }
  }
}
