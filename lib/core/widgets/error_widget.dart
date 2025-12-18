import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/core/error/failures.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    super.key,
    required this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              failure.message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text('common.retry'.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

