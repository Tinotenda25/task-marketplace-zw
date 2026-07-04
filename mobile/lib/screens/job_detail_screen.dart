// lib/screens/job_detail_screen.dart
import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';

class JobDetailScreen extends StatefulWidget {
  final Job job;
  final String userRole;
  final VoidCallback onBack;

  const JobDetailScreen({
    required this.job,
    required this.userRole,
    required this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  bool hasApplied = false;
  bool showChat = false;
  late TextEditingController messageController;
  List<Map<String, String>> messages = [
    {
      'from': 'them',
      'text': 'Hi! I\'m interested in this job. I have 5 years experience.'
    },
  ];

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Color _getAvatarColor(String colorHex) {
    return Color(int.parse(colorHex.replaceFirst('#', '0xff')));
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'from': 'me',
          'text': messageController.text,
        });
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showChat) {
      return _buildChatScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            backgroundColor: AppColors.primary,
            expandedHeight: 100,
            pinned: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: widget.onBack,
              child: const Center(
                child: Text(
                  '←',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.job.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster Info
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppAvatar(
                              initials: widget.job.avatar,
                              backgroundColor:
                                  _getAvatarColor(widget.job.avatarColor),
                              size: 44,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.job.poster,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                  Text(
                                    '${widget.job.posted} · ${widget.job.location}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.light,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Wrap(
                                    spacing: 6,
                                    children: [
                                      AppBadge(label: widget.job.category),
                                      AppBadge(
                                        label: widget.job.urgency,
                                        color: widget.job.urgency == "Today"
                                            ? AppColors.danger
                                            : AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.job.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.mid,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Stats
                  AppCard(
                    child: Row(
                      children: [
                        _buildStat(widget.job.budget, 'Budget'),
                        const SizedBox(width: 1),
                        Container(
                          width: 1,
                          height: 50,
                          color: AppColors.border,
                        ),
                        _buildStat('${widget.job.applicants}', 'Applicants'),
                        const SizedBox(width: 1),
                        Container(
                          width: 1,
                          height: 50,
                          color: AppColors.border,
                        ),
                        _buildStat('Open', 'Status'),
                      ],
                    ),
                  ),
                  // Worker Profile Match
                  if (widget.userRole == 'worker')
                    AppCard(
                      backgroundColor: AppColors.accentLight,
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.25),
                        width: 1.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '⭐ Your Profile Match',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.dark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'You have relevant certifications for this job.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.mid,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            children: [
                              AppBadge(
                                label: '✅ Plumbing Cert',
                                color: AppColors.primary,
                                backgroundColor:
                                    AppColors.white.withOpacity(0.8),
                              ),
                              AppBadge(
                                label: '⭐ 4.8 Rating',
                                color: AppColors.primary,
                                backgroundColor:
                                    AppColors.white.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  AppButton(
                    text: '💬 Message ${widget.job.poster}',
                    onPressed: () => setState(() => showChat = true),
                    variant: ButtonVariant.ghost,
                  ),
                  const SizedBox(height: 10),
                  if (widget.userRole == 'worker')
                    if (!hasApplied)
                      AppButton(
                        text: 'Apply for This Job',
                        onPressed: () {
                          setState(() => hasApplied = true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Application sent!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      )
                    else
                      AppCard(
                        backgroundColor: AppColors.primaryPale,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              '✅ Application Sent! Wait for response.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.light,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => setState(() => showChat = false),
          child: const Center(
            child: Text(
              '←',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
        title: Row(
          children: [
            AppAvatar(
              initials: widget.job.avatar,
              backgroundColor: _getAvatarColor(widget.job.avatarColor),
              size: 34,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.poster,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  '🟢 Online',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color.fromARGB(179, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message =
                    messages[messages.length - 1 - index];
                final isMe = message['from'] == 'me';
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? AppColors.primary : AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isMe ? Colors.white : AppColors.dark,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.border),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message…',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.border),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                AppButton(
                  text: 'Send',
                  onPressed: _sendMessage,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
