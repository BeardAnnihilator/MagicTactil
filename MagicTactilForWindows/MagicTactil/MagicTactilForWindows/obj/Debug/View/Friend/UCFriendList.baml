   M S B A M L   `   `   `  ����  MagicTactilForWindows(    "MagicTactilForWindows.UCFriendList   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      -   5          >�Name$  UserControl��5	       � 	Resources 5         ItemTemplate �Name;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  Name J� RenderTransformOrigin �� ImageSource  SelectedTemplate �� 
TargetType  ContainerStyle �� Property �� Value	 �� Triggers
 P� Property P� Value��%�  &	        &	 �    &	 �    7   7  �� 5   
   .R�5      � $ friendtemplate��6+   $	��230��6   $��30��6   .+�5        $ deleteFriendButton��6#   -   5        $��SurfaceButton��5   ?   $��Right=�6W   $��0,8,8,0q�6s   $��10��6�   $��10��6�   $	��Top=�6�   $��15��6�   $��15��6�   $ 
7.64,0.667&�6�   ��5      �� 5      $; 5/MagicTactilForWindows;component/Resources/delete.png��6   5      �� 5      
�������$��16(�6<   $��Rockwell)�6J   ��6   �� 6J   5      5      �� 5   
   .R�5      � $ friendtemplate��6/   $	��230��6   $��30��6#   .+�5        $ deleteFriendButton��6+   -   5        $��SurfaceButton��5   G   $��Right=�6_   $��0,8,8,0q�6{   $��10��6�   $��10��6�   $	��Top=�6�   $��15��6�   $��15��6�   $ 
7.64,0.667&�6   ��5      �� 5      $; 5/MagicTactilForWindows;component/Resources/delete.png��6   5      �� 5       
���   �$��16(�6=   $��Rockwell)�6K   ��6   �� 6K   5!      5$      �� 5&   
   " ��6   .�5'      -   5        �� 5(       � ��8   60   	 5)      P� 5*      
 �@��
IsSelected . . �5+      ��  � ��8  68   5,      50      52      .��54      � -   5        $ 
LayoutRoot��54      ���	#FF0D37A8 � ColumnDefinitions 55      �� 56      $��0.498* �6   �� 57      $��0.25* �6   �� 58      $��0.25* �6   .+�5:      @  :Microsoft.Surface.Presentation.Controls.SurfaceRadioButton  -   5        $��
Black List��5:      $��0q�63   $	��Top=�6>   $��1��6V   $��2��6f   6z     5;   
   -   5        $��Friend List��5;   $   $��0q�6:   $	��Top=�6E    d� 	IsChecked 6]   �� *frORbl+6z   <  6Microsoft.Surface.Presentation.Controls.SurfaceListBox  5<   
   -   5          Name$ friendListBox��5<       $��
0,77.2,0,0q�6Z   $��3��6n   #��[ 6�   ��67   �� *
frORblList+6�   <  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  5=   
   $��0,38,0,0q�6     �� TextWrapping$
 Wrap=�62   $
��26.8��6�   $	��Top=�6�   $��2��6�   ��6F   �� *entry+ �� UpdateSourceTrigger$ PropertyChanged=�6�     5>      $��+��6   $��2��6%   $��0,38,0,0q�6U   $	��Top=�6g   $
��39.2��6   $��0��6�   $��0��6�    �� 	IsDefault . ��65   �� *friendenter+6�   5?      5@      