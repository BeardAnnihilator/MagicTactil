   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullG(clr-namespace:MagicTactilForWindows.ViewMagicTactilForWindows.View  5      Q-clr-namespace:MagicTactilForWindows.ViewModelMagicTactilForWindows.ViewModel  5      =#clr-namespace:MagicTactilForWindowsMagicTactilForWindows  5      +    %MagicTactilForWindows.View.InnerBoard   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9View(clr-namespace:MagicTactilForWindows.View     5      <VM-clr-namespace:MagicTactilForWindows.ViewModel     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      ?MagicTactilForWindows#clr-namespace:MagicTactilForWindows  5        � 	Resources  5       �� DataType,   &MagicTactilForWindows.ViewModel.VMHome%   MagicTactilForWindows.View.Home/   )MagicTactilForWindows.ViewModel.VMProfile(   "MagicTactilForWindows.View.Profile3   -MagicTactilForWindows.ViewModel.VMCreateEvent,   &MagicTactilForWindows.View.CreateEvent3   -MagicTactilForWindows.ViewModel.VMModifyEvent,   &MagicTactilForWindows.View.ModifyEvent2	   ,MagicTactilForWindows.ViewModel.VMInnerRooms+
   %MagicTactilForWindows.View.InnerRooms2   ,MagicTactilForWindows.ViewModel.VMInnerDecks+   %MagicTactilForWindows.View.InnerDecks��%�  (��       5      *, +)(�� 2     5      *, +)(�� d     5      *, +)(�� �     5"      *, +)(�� �     5'      *,	 +)(�� �     5,      *, +)�� 5   
   "  6   .R�5        5      �� 5   
   "  6   .R�5        5      �� 5   
   "  6   .R�5        5      �� 5"   
   "  6   .R�5#        5$      �� 5'   
   " 	 6   .R�5(      
  5)      �� 5,   
   "  6   .R�5-        5.      50      .��53      �  � RowDefinitions 54   
   �� 55      $��0.46* �6   �� 56      $��0.54* �6    � ColumnDefinitions 58   
   �� 59      $��0.368* �6   �� 5:      $��0.632* �6   ��5<   
   �� 5=       �� ImageSource$ linesblue.jpg��6   .+�5@   
   �� $��	0,67,0,43q�6{   $��2��6�   $��2��6�   ��6   �� *ViewModelView.CurrentItem+ � DataContext 6I   �� *ViewModelView.CurrentItem+6�   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5A   
   -   5          Name$ DisconectButton��5A      $��0,0,8,0q�6x   $	��Top=�6�   $��Right=�6�   ���	#FFF60E0E
���   �$��1��6�      SurfaceButtonStyle1#���   6�   $��60��6%  $��60��6X  ��68   �� *LogOut_label+��6Y   �� *
disconnect+6X    5B   
   -   5        $ ProfileButton��5B      $��
90.4,0,0,0q�6t   $	��Top=�6�   ���	#FF868B86
���   �$��1��6�   #���   6�   $��60��6  $
��Left=�6  $��60��6/  ��66   �� *Profile_label+��6X   �� *	profile+6/    5C   
   -   5        $ 
HomeButton��5C      $��
74.2,0,0,0q�6k   $	��Top=�6   ���	#FF1457FC
���   �$
��Left=�6�   $��60��6�   #���   6�   $��60��6  ��63   �� *
Home_label+��6R   �� *home+6    5D   
   -   5        $ 
LogoButton��5D      $�� ��63   $
��Left=�6W   $��21.293,12,0,0q�6r   $	��Top=�6�   ��6>   �� *home+��5E      �� 5F      $E ?/MagicTactilForWindows;component/Resources/Logo Magictactil.ico��6   5H        5I   
   -   5        $ friendButton��5I   R   $��0,0,0,1q�6A   $��38��6h   $��Bottom=�6t   $��Right=�6�   $��144.1��6�   
���   ����	#FF301EBE$��1��6�   $��1��66  ��6   �� *Friends_label+66  (   "MagicTactilForWindows.UCFriendList  5J   
   -   5          Name$ 
FriendList��5J   �   $��	0,67,0,43q�6M   $��Right=�6`   $	��250��6|   $y�Hidden=�6�   $��2��6�   $��1��6�    6-   �� *Friend+6�     5K   
   -   5        $ 
RoomButton��5K   �   ���	#FFCC19E3
���   �$��174.6,0,0,0q�6�   $	��Top=�6�   $
��Left=�6�   $��60��6�   #���   6�   $��60��6  ��66   �� *rooms+��6P   �� *Rooms_label+6  %   MagicTactilForWindows.UCChatBox  5L   
   $��7.6,8,0.4,43q�6�   $��1��6�   y�6*   �� *%#ConversationManager.privateChatVisi+ 6e   �� *ConversationManager.focus+6�   (   "MagicTactilForWindows.UCDiscutions  5N   
   $��7.6,0,156.1,0q�6-   $��1��6D   $��39��6Q   $��Bottom=�6]   $��2��6x    6�   �� *ConversationManager+  5O   
   -   5        $ DecksButton��5O   �   ���	#FF26D424$��Decks��6P   
���   �$��8,0,0,0q�6s   $	��Top=�6�   $
��Left=�6�   $��60��6�   $��1��6�   #���   6�   $��60��6  ��66   �� *decks+6    5P   
   $��1��6Z   $��	0,12,92,0q�6j   $	��Top=�6}   $��40��6�   $��Right=�6�   $	��100��6�   ��6   �� *
language+��6<   �� *	translate+6�   5Q      5R      