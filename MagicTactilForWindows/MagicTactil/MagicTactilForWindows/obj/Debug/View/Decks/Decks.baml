   M S B A M L   `   `   `  ����  MagicTactilForWindows&     MagicTactilForWindows.View.Decks   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      .��5      � ��5	      �� 5
        �� ImageSource$  texture_game.jpg��6    � ColumnDefinitions 5   
   �� 5      $
��100* �6   �� 5      $
��100* �6   �� 5      $	��50* �6   .+�5   
   <  6Microsoft.Surface.Presentation.Controls.SurfaceListBox  -   5          Name$ 	DecksList��5       $��10,53,10,10q�6T   ���	#19000000��63   �� *
deckList+6i     5   
   $��9.8,10,10.4,10q�6    $��1��68   ���	#190000006H   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5   
   -   5          Name$ 	newButton��5      $	��New��6J   $��2��6X   $��10.4,10,10,0q�6h   $	��Top=�6~    J� RenderTransformOrigin$ 	0.503,0.5&�6�   ���	#7F0FAB63
���������62   �� *New+6�     5   
   $
��Edit��6   $��2��6.   $��10.4,53,10,0q�6>   $	��Top=�6T   ���	#7F256EDB
�������$y�Hidden=�6�     5   
   $��Delete��6   $��2��60   $��10.4,96,10,0q�6@   $	��Top=�6V   ���	#7FF12121
�������$y�Hidden=�6�   �� 5   
   -   5         ��Name$ Label��5      $��Your decks :��6   $
��Left=�66   $��	10,10,0,0q�6Q   $	��Top=�6d   $	��220��6|   $��38��6�   $��22(�6�   
���������6�   Z� 5      5      