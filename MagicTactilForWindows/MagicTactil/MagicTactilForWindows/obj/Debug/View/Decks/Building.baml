   M S B A M L   `   `   `  ����  MagicTactilForWindows)    #MagicTactilForWindows.View.Building   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      .��5      � $��0,0,0.6,-0.6q�6   ��5	      �� 5
        �� ImageSource$  texture_game.jpg��6    � RowDefinitions 5   
   �� 5      $	��57* �6   �� 5      $	��59* �6   �� 5      $
��151* �6   �� 5      $
��134* �6    � ColumnDefinitions 5   
   �� 5      $
��200* �6   �� 5      $
��200* �6   �� 5      $
��100* �6   �� 5      $
��100* �6   .+�5   
   <  6Microsoft.Surface.Presentation.Controls.SurfaceListBox  -   5          Name$ CollectionListBox��5       $��10,13,10,10.8q�6�   $��2��6�    J� RenderTransformOrigin$ 0.667,-0.211&�6�   ���	#19000000$��Disabled=�6�   $��2��6  ��6;   �� *
Collection+ �� SelectedItem 6^   �� *selectedCard+6    5   
   -   5        $ MainDeckListBox��5   �   $��Stretch=�6    $��Stretch=�6C   $��10,10.2,10.2,10.2q�6�   $��2��6�   $��1��6�   $��2��6�   $��2��6  ���	#19000000 6h   �� *selectedCard+��6�   �� *Main+6!  <  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  5   
   -   5          Name$ NameTextBox��5   <   $��
93,10,10,0q�6Q    �� TextWrapping$
 Wrap=�6e   $	��Top=�6�   $��3��6�   $��38��6�   ���	#33000000
�������{�6    �� *isNew+��6y   �� *
deckName+ �� UpdateSourceTrigger$ PropertyChanged=�6  �� 5   
   $��100,0.2,100,2q�6O   $ 1.266,0.523&�6f   $��1��6�   $��1��6�   $��2��6�   $��Center=�6�   	 � DataContext	 6   �� *selectedCard+��65   �� *Bitmap+6�   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5!   
   $��Add to main ->��6:   $��25,0,25,92.8q�6V   $��3��6l   $��38��6y   ���	#7F0FAB63
�������$��Center=�6�   $	��150��6�   $��Bottom=�6�   $��1��6�   ��6   �� *toMain+6�     5"   
   -   5        $ SearchTextBox��5"       $��10,10.2,10,0q�67   $
 Wrap=�6M   $	��Top=�6�   $��42��6�   $��1��6�   ���	#33000000
���������6a   �� *Filter+$ PropertyChanged=�6�     5#   
   $��<-��68   $��	10,10,0,0q�6H   $
��Left=�6[   $��78��6v   $��38��6�   $	��Top=�6�   ���	#7FDAA118
���������6   �� *back+6�     5$   
   $
��Save��68   $��0,10,10.2,0q�6G   $	��Top=�6\   $��3��6t   $��38��6�   
����������	#7F0FAB63$��Right=�6�   $��79��6�   ��6   �� *save+6�   5'      5(      