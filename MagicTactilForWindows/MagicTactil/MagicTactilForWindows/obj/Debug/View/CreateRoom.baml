   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullQ-clr-namespace:MagicTactilForWindows.UtilitiesMagicTactilForWindows.Utilities  5      +    %MagicTactilForWindows.View.CreateRoom   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      C	Utilities-clr-namespace:MagicTactilForWindows.Utilities     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e352my)http://schemas.microsoft.com/surface/2008  5   7   .��5	      � 
�������  � RowDefinitions  5
   
   �� 5      $	��50* �6   �� 5      $	��51* �6   �� 5      $	��57* �6   �� 5      $	��53* �6   �� 5      $	��89* �6    � ColumnDefinitions 5   
   �� 5      $
��174* �6   �� 5      $
��216* �6   �� 5      $
��210* �6   .+�5   
   �� -   5        $��label1��5   &   $��Create Room��6   $��3��64   $��Center=�6H   $��50��6l   $��Center=�6x   
���   �6�   �� 5   
   -   5        $��label2��5   =   $��	Room Name��6   $��1��6$   $��40��61   $��Center=�6K   $��Center=�6f   $��Center=�6�   
���   �$��	12,1,4,10q�6�   $��Center=�6�   �� 5   
   -   5        $��label3��5   Q   $��Format��6   $��54��6!   $��Center=�6-   $��Center=�6_   $��Center=�6z   $��2��6�   
���   �$��Center=�6�   �� 5   
   -   5        $��label4��5   @   $��51��6   $��Center=�6   $��Center=�6N   $��Center=�6i   $��3��6�   $��0,2,0,0q�6�   $��Center=�6�   .��5      �� $��Maximum number of player��6   $��Center=�68   $��Center=�6U   $��LeftToRight=�6p   
���   �6�   5      <  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  5   
   -   5        $��surfaceTextBox1��5   h   $��1��6   
���   ����	#7BFFFFFF
���   �$��1��6�   $��2��6�   $��1,1,1,0q�6�   $��Center=�6�   $��50��6  ��6)   �� *
RoomName+ �� UpdateSourceTrigger$ PropertyChanged=�6    5   
   -   5        $��format��5   )   $��4��6   $y�Hidden=�6t   $��77��6�   $	��160��6�   $��7,0,0,0q�6�    �� 
IsReadOnly . ��67   �� *Format+$ PropertyChanged=�6�   2   ,MagicTactilForWindows.Utilities.ModeSelector  5      -   5          Name$ _ModeSelector��5   %      SelectorStyle#��[  6V   $	��242��6}      SelectedIndex$ 0��6�   $
��Left=�6�   {�. $��1��6�   $��2��6�   $��2��6�   $��0,0,1,0q�6  $	��250��6  $
��2000��6#  $��40��63  
���   �
���   �6U  �� 5   
   -   5        $��label5��5   7   $��Not enabled yet��6   $��3��6*   ���	#FFCF1D1D$��Center=�6\   $��Center=�6�   $��1,0,-1,0q�6�   $��1��6�   $��51��6�   $��2��6�   $��Stretch=�6�   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5    
   -	   5        $��createButton��5    �   $��Create��66   $��1��6G   $��4��6W   $��23��6d   $��0,27,8,0q�6p   $	��Top=�6�   $��Right=�6�   $��75��6�   ���	#1E000000��6   �� *create+6�     5!   
   -
   5        $��CancelButton��5!   �   $��Cancel��66   $��23��6G   $
��Left=�6S   $��8,27,0,0q�6n   $	��Top=�6�   $��75��6�   $��2��6�   $��4��6�   ���	#1E000000��6   �� *cancel+6�   �� 5"   
   -   5        $��errLabel��5"   1   $��4��6   $��
15,15,12,0q�6   
���  �����	#FF3C3434y�6i   �� *errVisibility+.��5#      �� ��6   �� *	errMess+5$      5%      5&      