   M S B A M L   `   `   `  ����  MagicTactilForWindows!    MagicTactilForWindows.UCReg   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      -   5          >�Name$  UserControl��5	      $	��300��6   $	��500��6$   .��5      �� $��10q�6
   ���	#FF095EA7$	��300��67   $	��500��6D   ._�5      � -   5         �Name$ 
LayoutRoot��5   	    J� RenderTransformOrigin$ 0.5,0.5&�6   ���	#FF24A9E9 � RowDefinitions 5      �� 5      $��0.173* �6     � ColumnDefinitions 5      �� 5      $
��142* �6   �� 5      $
��196* �6#   �� 5      $
��142* �6#   .+�5      ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  -   5          Name$ ConnectButton��5   b   $��Confirm��6?   $��8,0,7,6q�6Q   $��9��6y   $��1��6�   $��40��6�   $��Bottom=�6�    �� 	IsDefault . ��6#   �� *	connect+6�   <  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  5      -   5        $��EmailBox��5   h    �� 
AcceptsTab .   � ForceCursor . $��40��6J   $��8,0,7,77q�6V   $��2��6x   $��Bottom=�6�   $��1��6�   ��6�   �� *mail+	 �� UpdateSourceTrigger$	 PropertyChanged=�6�     5      -   5        $��NameBox��5   V    .  $��40��67   $��	8,0,7,215q�6C   $��0��6e   $��Bottom=�6�   $��1��6�   ��6r   �� *name+$	 PropertyChanged=�6�   @  :Microsoft.Surface.Presentation.Controls.SurfacePasswordBox  5      -   5        $��PasswordBox��5   G   $��40��6(   $��	8,0,7,169q�64   $��1��6Z   $��Bottom=�6g   $��1��6�   6�   �� 5      -   5        $��UsernameLabel��5   �   $��
username *��6   $��13.333(�6)   $
��Bold"�6;   
�������$��Right=�6`   $��	0,25,10,0q�6|   $	��126��6�   �� 5      -   5        $��label1��5   s   $��
password *��6   $��13.333(�6)   $
��Bold"�6;   
�������$��	6,71,10,0q�6`   $ 
0.51,0.472&�6�   �� 5      -	   5        $��label2��5   �   $��e-mail address *��6   $��13.333(�6/   $
��Bold"�6A   
�������$
��Left=�6f   $��	6,163,0,0q�6�   $	��126��6�   �� 5      -
   5        $��label3��5   |   $��confirm password *��6   $��13.333(�61   $
��Bold"�6C   
�������$��
6,117,10,0q�6h   $ 
0.51,0.472&�6�     5      -   5        $��confirmPassbox��5   G   $��40��6(   $��	8,117,7,0q�64   $��1��6]   $	��Top=�6j   $��1��6�   6�   5      5       5!      