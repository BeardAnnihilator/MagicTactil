   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null=#clr-namespace:MagicTactilForWindowsMagicTactilForWindows  5   ;   %    MagicTactilForWindows.View.Game   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      /local#clr-namespace:MagicTactilForWindows  6;   -   5          >�Name$  UserControl��5	       J� 	AllowDrop . .��5      � -   5         �Name$ 
LayoutRoot��5      ���	#FF4995B7 � ColumnDefinitions 5   
   �� 5      $
��110* �6   �� 5      $
��110* �6   �� 5      $��1000* �6    � RowDefinitions 5   
   �� 5      $
��250* �6   �� 5      $
��250* �6   �� 5      $
��125* �6   .+�5   
   �� $��2��6   $��0,0,0.2,0.4q�6(   $��3��6=   ���	#FFC1D0D06N   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5   
   -   5          Name$ 
DeckButton��5   8   $��14,123.6,0,9.8q�6j   $
��Left=�6�   $��85��6�   
������� . $��1��6�   ��6   �� *draw+��6L   �� *	DeckCount+��5      �� 5       �� ImageSource$ card back.png��6   5        5   
   -   5        $ ExileButton��5      $��Exiled��64   $��0,1.8,10.2,10.4q�6E   
���   �
���   �$��2q�6�   $��1��6�    J� RenderTransformOrigin$ -1.08,0.332&�6�   $��Right=�6�   $��94��6�    . $��2��6  ��5      �� 5       $ jail.png��6   5"        5#   
   -   5        $ GraveyardButton��5#      $��Grave��68   $��10,1.8,0,10.4q�6H   $��89��6_   $
��Left=�6j   
������� . $��2��6�   ��5$      �� 5%      $ graveyard.png��6   5'      #   MagicTactilForWindows.UCBoard  5*   
   -   5          Name$ MyBoard��5*      $��9.8,10.4,10.4,9.6q�6I   $��2��6d   $��1��6t   	 � DataContext	 6)   �� *	MyBoard+6t     5+   
   -   5        $ OppBoard��5+      $��9.8,10,10.4,8.6q�6K   ���	#FF70EA59
   AutomaticPositionElement
 . $��2��6�   	 6*   �� *
OppBoard+6�     5,   
   -   5        $ ExileButton_Copy��5,      $��Exiled��69   $��0,10,10.2,158.6q�6J   
���   �
���   �$��2q�6�   $��Right=�6�   $��94��6�   $��1��6�   ��5-      �� 5.      $ jail.png��6   50        51   
   -	   5        $ GraveyardButton_Copy��51      $��Grave��6=   $��10,10,0,158.6q�6M   $��89��6d   $
��Left=�6o   
�������$ -4.672,-0.682&�6�   ��52      �� 53      $ graveyard.png��6   55        56   
   -
   5        $ 
BackButton��56      $��	Surrender��6O   $
��Left=�6c   $��10.2,212.6,0,0q�6~   $	��Top=�6�   ���	#CCEF1919
���   �$��44��6�   $��95��6�   $��1��6�   $��1��6�   ��63   �� *	surrend+6�   �� 57   
   $��30.2,113,31.6,0q�6*   $	��Top=�6C   ���	#FFFE0303$��36(�6r   $
��Bold"�6�   $��53��6�   $��1��6�   ��6   �� *HISPV+6�   �� 58   
   $��30.2,106.6,31.6,0q�6)   $	��Top=�6D   
���  ��$
��Bold"�6m   $��36(�6   $��52��6�   $��1��6�   $ -0.428,0.492&�6�   $��1��6�   ��6   �� *MYPV+6�     59   
   $��+��6:   $��Center=�6F   $��64.2,163.6,10.6,0q�6c   $	��Top=�6~   $��38��6�   $
��Bold"�6�   $��24(�6�   $��44��6�   $��1��6�   $��1��6�   ��6   �� *morepv+6�     5:   
   $��-��6;   $��Center=�6G   $��10.2,163.6,64.6,59.8q�6d   $��Center=�6�   $��38��6�   $
��Bold"�6�   $��24(�6�   $ 0.468,0.451&�6�   $��43��6�   $��1��6�   $��1��6  ��6    �� *lesspv+6  "   MagicTactilForWindows.UCHand  5;   
   $��2��6   $��11.4,10.2,8.4,0q�6'   $��2��6@   $	��Top=�6M   $	��108��6e   5H      5I      