   M S B A M L   `   `   `  ����  MagicTactilForWindows&     MagicTactilForWindows.View.Rooms   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e352my)http://schemas.microsoft.com/surface/2008  5   7   .��5      � 
�������  � ColumnDefinitions  5	   
   �� 5
      $
��511* �6   �� 5      $
��289* �6   .+�5   
   <  6Microsoft.Surface.Presentation.Controls.SurfaceListBox  -   5        $��RoomsListBox1��5   x   $��17,63,12,12q�6c   ���	#4C000000��6   �� *
roomList+ �� SelectedItem 6=   �� *selectedRoom+6�   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5   
   -   5        $��CreateButton��5   �   $��+ Create a room��67   $��23��6Q   $
��Left=�6]   $��	17,12,0,0q�6x   $	��Top=�6�   $	��148��6�   ���	#4D000000��6   �� *	cr_room+6�     5   
   -   5        $��RefreshButton��5   a   $�� ��67   $��23��6B   $��	0,12,12,0q�6N   $	��Top=�6v   $��Right=�6�   $��23��6�   ��6   �� *	refresh+��5      �� 5       �� ImageSource$< 6/MagicTactilForWindows;component/Resources/refresh.ico��6   5        5   
   -   5        $��
JoinButton��5   u   $
��Join��6   $��1��6F   $��23��6V   $��	0,12,12,0q�6b   $	��Top=�6�   $y�Hidden=�6�   $��Right=�6�   $��75��6�   ���	#4D000000��6*   �� *	jo_room+6�     5   
   -   5        $��playerListBox��5   d   $��1��6?   $��16,63,12,12q�6O   ���	#4C000000$y�Hidden=�6�   ��6   �� *
playerList+6�   5      5      