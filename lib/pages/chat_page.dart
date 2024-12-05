import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamer_tag_task/cubits/chat_cubit.dart';
import 'package:gamer_tag_task/cubits/chat_state.dart';
import 'package:gamer_tag_task/models/chat_model.dart';
import 'package:gamer_tag_task/utilities/consts.dart';
import 'package:gamer_tag_task/utilities/enums/chat_container_type.dart';
import 'package:gamer_tag_task/utilities/extensions/size_extension.dart';
import 'package:gamer_tag_task/utilities/helpers.dart';
import 'package:gamer_tag_task/widgets/chat_container.dart';
import 'package:gamer_tag_task/widgets/custom_bloc_provider.dart';
import 'package:gamer_tag_task/widgets/custom_text.dart';
import 'package:gamer_tag_task/widgets/image_viewer.dart';
import 'package:gamer_tag_task/widgets/svg_viewer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  late final ChatCubit chatCubit;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appBarColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    chatCubit = ChatCubit();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    chatCubit.scrollController.jumpTo(
      chatCubit.scrollController.position.maxScrollExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBlocProvider.provide(
      bloc: chatCubit,
      builder: (context) => BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) => SafeArea(
          child: Scaffold(
            backgroundColor: whiteTextColor,
            body: Stack(
              children: [
                CustomScrollView(
                  controller: chatCubit.scrollController,
                  slivers: <Widget>[
                    appBar(state),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 58.0.h,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.0.w, 0, 20.0.w, 110.0.h),
                      sliver: SliverList.builder(
                        itemBuilder: (context, index) =>
                            buildChatContainer(state, index),
                        itemCount: state.messages.length,
                      ),
                    ),
                  ],
                ),
                buildBottomBar(state)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar(ChatState state) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: whiteTextColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.0.w, 0, 12.0.w, 4.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: chatCubit.changeTimerState,
                child: SvgViewer(
                  source: !state.isTimerEnabled
                      ? 'assets/icons/clock-stopwatch.svg'
                      : 'assets/icons/clock-stopwatch-active.svg',
                  size: 36.0.w,
                ),
              ),
              SizedBox(width: 12.0.w),
              Expanded(
                child: Stack(
                  children: [
                    TextField(
                      controller: chatCubit.messageController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          13.0.w,
                          8.0.h,
                          4.0.w,
                          10.0.h,
                        ),
                        hintText: 'iMessage',
                        hintStyle: regular17.copyWith(color: greyColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: greyColor),
                        ),
                        suffixIcon: state.showSendButton
                            ? IconButton(
                                onPressed: chatCubit.addMessage,
                                icon: const Icon(Icons.send))
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatContainer(ChatState state, int index) {
    final message = state.messages[index];
    final isAnimating = state.animatingMessageId == message.id;
    final shouldShowDate = index == 0 ||
        !isSameDay(state.messages[index - 1].timestamp, message.timestamp);

    String lastReadMessageId = '';
    for (int i = state.messages.length - 1; i >= 0; i--) {
      if (state.messages[i].receiver == state.currentReceiver &&
          state.messages[i].readAt != null) {
        lastReadMessageId = state.messages[i].id;
        break;
      }
    }
    final isLastReadMessage = lastReadMessageId == message.id;

    return Column(
      children: [
        if (shouldShowDate)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.h),
            child: CustomText(
              formatMessageDate(message.timestamp),
              style:
                  medium11.copyWith(color: greyColorNoOpacity.withOpacity(0.6)),
            ),
          ),
        buildMessageContainer(state, message, isAnimating, index),
        if (isLastReadMessage)
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: CustomText(
                'Read ${formatMessageDate(message.readAt!)}',
                style: regular11.copyWith(
                    color: greyColorNoOpacity.withOpacity(0.6)),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildMessageContainer(
      ChatState state, ChatModel chatModel, bool isAnimating, int index) {
    var container = ChatContainer(
      chatType: chatModel.receiver == state.currentReceiver
          ? ChatContainerType.send
          : ChatContainerType.receive,
      backgroundColor: chatModel.receiver == state.currentReceiver
          ? (chatModel.isDeletable ? orangeColor : blueColor)
          : chatBackgroundColor,
      text: chatModel.message,
      id: chatModel.id,
      isAnimating: isAnimating,
      clip: !(state.messages.length > index + 1 &&
          state.messages[index + 1].receiver == chatModel.receiver),
    );

    if (chatModel.receiver == state.currentReceiver) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Dismissible(
          key: Key('${chatModel.id}dismissible'),
          background: Container(
            color: Colors.red.withOpacity(0.4),
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            chatCubit.deleteMessage(chatModel.id);
          },
          direction: DismissDirection.endToStart,
          child: container,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: container,
    );
  }

  Widget appBar(ChatState state) {
    return SliverAppBar(
      titleSpacing: 0,
      collapsedHeight: 76.0.h,
      toolbarHeight: 76.0.h,
      backgroundColor: appBarColor,
      pinned: true,
      shape: const Border(bottom: BorderSide(color: greyColor)),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgViewer(
              source: 'assets/icons/chevron-left.svg',
              color: blueColor,
              size: 18.0.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    chatCubit.changeReceiver();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: ImageViewer(
                      asset:
                          'assets/${state.currentReceiver.replaceAll(' ', '')}.jpg',
                      height: 50.0.h,
                      width: 50.0.w,
                    ),
                  ),
                ),
                SizedBox(height: 5.0.h),
                Row(
                  children: [
                    CustomText(
                      state.currentReceiver,
                      style: regular11.copyWith(color: blackTextColor),
                    ),
                    SizedBox(
                      width: 2.0.w,
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14159),
                      child: SvgViewer(
                        source: 'assets/icons/chevron-left.svg',
                        color: greyColor,
                        size: 8.0.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SvgViewer(
              source: 'assets/icons/video.svg',
              color: blueColor,
            ),
          ],
        ),
      ),
    );
  }
}
