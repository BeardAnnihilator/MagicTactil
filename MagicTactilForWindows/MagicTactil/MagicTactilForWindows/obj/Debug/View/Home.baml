   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullQ-clr-namespace:MagicTactilForWindows.ViewModelMagicTactilForWindows.ViewModel  5      =#clr-namespace:MagicTactilForWindowsMagicTactilForWindows  5      %    MagicTactilForWindows.View.Home   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      6VM-clr-namespace:MagicTactilForWindows.ViewModel  5      ?MagicTactilForWindows#clr-namespace:MagicTactilForWindows  5      -   5          >�Name$  UserControl��5      .��5      � -   5         �Name$ 
LayoutRoot��5      
������� � ColumnDefinitions 5   
   �� 5      $
��290* �6   �� 5      $
��350* �6   .+�5   
   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  -   5          Name$ createEventButton��5   y   $�� + Create Event��6   $��23��69   $��	12,12,0,0q�6f   $	��Top=�6�   $
��Left=�6�   $	��141��6�   
���   ����	#4D000000��6E   �� *create_event+6�   <  6Microsoft.Surface.Presentation.Controls.SurfaceListBox  5   
   -   5          Name$ eventListBox��5   V   $��
12,56,0,12q�6B   ���	#4C000000��6    �� *	eventList+6�     5   
   -   5        $ refreshButton��5   b   $��23��6A   $��0,12,32.8,0q�6M   $	��Top=�6y   $��Right=�6�   $
��33.4��6�   ��6   �� *refresh_event+��5      �� 5       �� ImageSource$< 6/MagicTactilForWindows;component/Resources/refresh.ico��6    j� Stretch$ Uniform=�6\    j� TileMode$
 Tile=�6n   5      '   !MagicTactilForWindows.UCEventInfo  5   
   -   5          Name$ 	eventInfo��5   a   $��1��6,   $��8,8,8,8q�6<   $y�Hidden=�6M   ���	#4C000000
���   �6�   5      5      