   M S B A M L   `   `   `  ����  MagicTactilForWindows    MagicTactilForWindows.App   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     6P   e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  6�   :d2http://schemas.microsoft.com/expression/blend/2008  6�   Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  6�     �� 	Resources  5       �� MergedDictionaries �� Source   SurfaceButtonStyle1 �� 
TargetType;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  ControlBaseStyle �� BasedOn �� Property �� Value2  ,Microsoft.Surface.Presentation.SurfaceColors   ButtonBackgroundBrushKey   ButtonForegroundBrushKey	 �� 
TargetType
 � 	Resources  Key �Name J� SnapsToDevicePixels J� RenderTransformOrigin �� ScaleY F�Name �� Stretch&   ButtonBackgroundPressedBrushKey J� Opacity ��Name �� Triggers P� Property P� Value N� EnterActions 	 Press N� ExitActions  Release&   ButtonForegroundPressedBrushKey �� 
TargetName'    ButtonForegroundDisabledBrushKey�� 5       5   
   �� 5      $d ^/Microsoft.Surface.Presentation.Generic;v2.0.0.0;31bf3856ad364e35;component/themes\styles.xaml?�6   �� 5      $ Simple Styles.xaml?�6   �� 5	      $ Dictionary1.xaml?�6   %�  &	        7  7  7  �� 5   	   "  5   	   8   .�5   
   ��  � �� .  5   
   �� 5   
    � |� . 5   
   �� 5   
    � ��# �  5   
   �� 5   
    � ��# �  5   
   �� 5   
    � �� 5      �� 5      "	  6   
 5      ���� 5      	Press 6   �� 5      Release 6   5      .R�5      � $
 Grid��6   # z 5      $��0,0.7,0,-0.1q�6I   $
��Auto��6_   $ 0.5,0.5&�6m   $��Stretch=�6�   z�5       V� 5!      .~�5"      �� $ 1Q�6   �� 5#      �� 5$      T� 5%      5&      .+�5(      F� $ 
ButtonBody��6   =����     -1р��    � �� -1� �� ��р�� ���     ��	#��z��6T   $
 Fill=�6x   # z 6�   $��-0.333,0,0.333,0q�6�   $
��Auto��6�   F� 5)      $ PressOverlay��6   =����     -1р��    � �� -1� �� ��р�� ���     ��	#���  5+      $
��Auto��5,      $ 0Q�5-      $
 Fill=�5.      # z 5/      $��Stretch=�6K   �� 50      $ Content��6    $��-0.333,0,0.333,0q�51      # z 52      $��Center=�6J   $��Center=�6g   53       55      P� 56       � �� .  58      �� 59      8�� 6     5;      �� 5<      8�� 6    . �5>      �� # �  5?       � ���� 5@      $ PressOverlay��6)    �@J�Opacity$
 0.33Q�6C   5A      P� 5B       � {� .  . �5D      �� # �  5E       � ���� 5F      $ Content��5H       �@J�Opacity$
 0.33Q�5G      5H      5I      5K      5M      5N   
   5P   	   5R      