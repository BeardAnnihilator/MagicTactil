   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null=#clr-namespace:MagicTactilForWindowsMagicTactilForWindows  5   C   ,    &MagicTactilForWindows.View.ModifyEvent   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e352my)http://schemas.microsoft.com/surface/2008  5      ?MagicTactilForWindows#clr-namespace:MagicTactilForWindows  6C   .��5      � -   5          �Name$  
LayoutRoot��5      ��5	      �� 5
       �� ImageSource$; 5pack://siteoforigin:,,,/View/Game/texture_game_03.jpg��6    � ColumnDefinitions 5   
   �� 5      $
��184* �6   �� 5      $
��456* �6    � RowDefinitions 5   
   �� 5      $	��55* �6   �� 5      $	��44* �6   �� 5      $	��51* �6   �� 5      $
��330* �6   .+�5   
   <  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  -   5        $��nameTextBox��5   o   $��	7,14,12,3q�6\   $��1��6�    �� 
IsReadOnly . ���	#CC000000���	#E6FFFFFF
���   ���6   �� *	eventName+ �� UpdateSourceTrigger$ PropertyChanged=�6�     5   
   -   5        $��dateTextBox��5   n   $��7,3,12,3q�6\   $��1��6�   $��1��6�   ���	#CC000000���	#E6FFFFFF
���   ���6   �� *	eventDate+$ PropertyChanged=�6�     5   
   -   5        $��locationTextBox��5   s   $��	7,3,12,10q�6`   $��1��6�   $��2��6�   ���	#CC000000���	#E6FFFFFF
���   ���6   �� *eventLocation+$ PropertyChanged=�6�     5   
   -   5        $��contentTextBox��5   s   $��
7,11,12,67q�6_   $��1��6�   $��3��6�    �� AcceptsReturn .  �� 	MaxLength$
 2000��6�   ���	#CC000000���	#E6FFFFFF
���   ���6   �� *eventContent+$ PropertyChanged=�6�   �� 5   
   -   5        $��	nameLabel��5   8   $��
Event Name��6   $��	11,12,0,0q�6%   $��40��6I   
���   �6U   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5   
   -   5        $��createButton��5   U   $
��Edit��6   $��7,0,0,12q�6C   $��38��6i   $��Bottom=�6u   $
��Left=�6�   $	��101��6�   $��3��6�   $��1��6�   ���	#7F0FAB63��6*   �� *edit+6�     5   
   -   5        $��cancelButton��5   [   $��Cancel��6   $��
157,0,0,12q�6G   $��38��6o   $��Bottom=�6{   $��3��6�   $��1��6�   $
��Left=�6�   $	��101��6�   ���	#7FDAA118��6,   �� *cancel+6�   �� 5   
   -	   5        $��	dateLabel��5   C   $��
Event Date��6   $��40��6%   $��12,3,0,0q�61   $	��Top=�6T   $��1��6l   
���   �6y   �� 5   
   -
   5        $��locatioLabel��5   P   $��Location��6   $
��Left=�6#   $��11,3,0,0q�6>   $	��173��6d   $��2��6p   $��48��6}   
���   �6�   �� 5   
   -   5        $��contentLabel��5   f   $��Event Description��6   $��40��6,   $
��Left=�68   $��	11,11,0,0q�6S   $	��Top=�6z   $	��173��6�   $��3��6�   
���   �6�   �� 5    
   -   5        $��errLabel��5    1   $��3��6   $��
11,57,16,0q�6   
���  �����	#FF3C3434y�6i   �� *errVisibility+.��5!      �� ��6   �� *	errMess+5"      5#      5$      