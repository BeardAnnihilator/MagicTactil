   M S B A M L   `   `   `  ����   MagicTactilForWindows!    MagicTactilForWindows.UCReg   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  -     >�Name$  UserControl��$	��300��$	��500��.���� $��10q����	#FF095EA7$	��300��$	��500��._�� -    �Name$ 
LayoutRoot�� J� RenderTransformOrigin$ 0.5,0.5&����	#FF24A9E9 � RowDefinitions �� $��0.173* � � ColumnDefinitions �� $
��142* ��� $
��196* ��� $
��142* �.+�;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  -     Name$ ConnectButton��$��Confirm��$��8,0,7,6q�$��9��$��1��$��40��$��Bottom=� �� 	IsDefault . ���� *	connect+<  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  -   $��EmailBox�� �� 
AcceptsTab .   � ForceCursor . $��40��$��8,0,7,77q�$��2��$��Bottom=�$��1������ *mail+	 �� UpdateSourceTrigger$	 PropertyChanged=�  -   $��NameBox�� .  $��40��$��	8,0,7,215q�$��0��$��Bottom=�$��1������ *name+$	 PropertyChanged=�@  :Microsoft.Surface.Presentation.Controls.SurfacePasswordBox  -   $��PasswordBox��$��40��$��	8,0,7,169q�$��1��$��Bottom=�$��1���� -   $��UsernameLabel��$��
username *��$��13.333(�$
��Bold"�
�������$��Right=�$��	0,25,10,0q�$	��126���� -   $��label1��$��
password *��$��13.333(�$
��Bold"�
�������$��	6,71,10,0q�$ 
0.51,0.472&��� -	   $��label2��$��e-mail address *��$��13.333(�$
��Bold"�
�������$
��Left=�$��	6,163,0,0q�$	��126���� -
   $��label3��$��confirm password *��$��13.333(�$
��Bold"�
�������$��
6,117,10,0q�$ 
0.51,0.472&�  -   $��confirmPassbox��$��40��$��	8,117,7,0q�$��1��$	��Top=�$��1��