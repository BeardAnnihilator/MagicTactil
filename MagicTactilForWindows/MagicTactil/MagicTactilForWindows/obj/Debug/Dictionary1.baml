   M S B A M L   `   `   `  ����P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullQ-clr-namespace:MagicTactilForWindows.UtilitiesMagicTactilForWindows.Utilities  5      Q-clr-namespace:MagicTactilForWindows.UtilitiesMagicTactilForWindows.Utilities  5      c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35qPclr-namespace:System.Windows.Interactivity;assembly=System.Windows.InteractivitySystem.Windows.Interactivity 5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35<    6MagicTactilForWindows.Utilities.SelectorLabelConverter   SelectorLabelConverter  ControlHitAreaBrush  �� Color �� 
TargetType  ControlBaseStyle �� Property �� Value  InvisibleButtonStyle;  5Microsoft.Surface.Presentation.Controls.SurfaceButton �� BasedOn �� 
TargetType �Name  SelectorStyle2   ,MagicTactilForWindows.Utilities.ModeSelector � 	Resources  Key<  6Microsoft.Surface.Presentation.Controls.SurfaceListBox �� 	Resources	 �� EndPoint
 �� 
StartPoint � Color � OffsetA  ;Microsoft.Surface.Presentation.Controls.SurfaceScrollViewer ��Name J� SnapsToDevicePixels J� OpacityMask  Name  SurfaceScrollViewerStyle.  (System.Windows.Interactivity.Interaction   	Behaviors:   4MagicTactilForWindows.Utilities.ShadowScrollBehavior@   :MagicTactilForWindows.Utilities.ScrollViewerOffsetMediator  Name   ScrollViewer �� ElementName �� Triggers �� Value �� Binding �� Path �� RelativeSource �� Mode �� AncestorType N� EnterActions �� 
TargetName �� TargetProperty	 �� To  g� Duration! N� ExitActions" J� Opacity# ��Name$ `� 	Converter	% W� To& P� Property' P� ValueL  FMicrosoft.Surface.Presentation.Controls.Primitives.SurfaceRepeatButton( ��Name2	  ,Microsoft.Surface.Presentation.SurfaceColors) 	  TrackBackgroundBrushKey* �� 
TargetName+ 	  ThumbDisabledBrushKeyE
  ?Microsoft.Surface.Presentation.Controls.Primitives.SurfaceThumb  SurfaceHitAreaBaseStyle, 	  ThumbEnabledBrushKey	- t� To:  4Microsoft.Surface.Presentation.Input.TouchExtensions 	 Touch 	 ReleaseI  CMicrosoft.Surface.Presentation.Controls.Primitives.SurfaceScrollBar. ]�Name/ ]� IncreaseRepeatButton0  Name $
  SurfaceVertScrollBarRepeatButton1 ]� DecreaseRepeatButton2 ]� Thumb3 
 Name  SurfaceScrollBarThumbStyle4 �� ResourceKey5 �� Triggers $  SurfaceHorzScrollBarRepeatButton # SurfaceScrollBarHorizThumbStyle'  !System.Windows.VisualStateManager6   VisualStateGroups%  System.Windows.VisualStateGroup7   Transitions%  System.Windows.VisualTransition8   GeneratedDuration9   States   System.Windows.VisualState:   
Storyboard; �� KeyTime< �� Value= �� CanContentScroll> �� CanHorizontallyScroll? �� CanVerticallyScroll@  Name*A �� #ComputedVerticalScrollBarVisibilityB �� OrientationC �� ScrollableHeightD � MaximumE � Minimum4  .System.Windows.Automation.AutomationPropertiesF   AutomationId  SurfaceScrollBarStyleG � LargeChangeH �� ViewportHeightI �� ViewportSizeJ J� IsHitTestVisibleK � ValueL �� Mode9  3System.Windows.Media.Animation.EasingDoubleKeyFrameM O� KeyTimeN O� ValueO J� RenderTransformOriginP �� AngleQ  NameR   ItemsSourceS   SelectedItemT �� SelectedItemU   SelectedIndexV �� SelectedIndex  ListBoxStyle  ListBoxItemStyleW  Name�� 5      D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    :x,http://schemas.microsoft.com/winfx/2006/xaml     5      1s)http://schemas.microsoft.com/surface/2008  5      @SelectorSample-clr-namespace:MagicTactilForWindows.Utilities  5      :controls-clr-namespace:MagicTactilForWindows.Utilities  5      ViPclr-namespace:System.Windows.Interactivity;assembly=System.Windows.Interactivity  5      %�2  &	        &	      &	 6     &	 ?    7  &	 �    7   7  7  7  7  7  7  7 	 7 
 7 
 7  0�� 5Q  "   $4 SurfaceHitAreaBaseStyle��61   17  7  7  7  7     5
      6,   �� 5      $  	#00FFFFFF��6/   �� 5      " ��6   .�5   
   ��  �@�FocusVisualStyle 6-   Z� �� 5   
    �@J�SnapsToDevicePixels .  60   �� 5   
    � ��$ Segoe360)�6'   �� 5   
    � ��$ Normal"�6'   �� 5   
    � ��$ 17(�6%   �� 5   
    � ��$ 	6,2,10,10q�6$   �� 5   
    � ��$ 38��6&   �� 5   
    � ��$ 38��6%   �� 5   
    � ��$ 1q�6#   �� 5   
    � ��$
 Left=�67   �� 5   
    � ��$	 Top=�65   �� 5   
    � ��$ 2q�6,   5      �� 5      "  6)   8   .�5   
   ��  � ��$ 0��6%   �� 5   
    � ��$ 0��6&   �� 5   
    � ��$ 0q�6$   �� 5    
    � ��$ 0q�6#   �� 5!   
    � ��$ 0q�6,   �� 5"   
    � �� 5#      �� 5$      "  6"   .R�5%      � $
 Grid��6   
������ 6)   5&      5(      5)      �� 5+      "  6"   .�5,   
   ��  � �� 5-      �� 5.      "  6"    5/      ���� 50      ListBoxStyle "  65    51      ���� 52   "   $	 1,0.5&�6h   $
 0,0.5&�6y   (��       66   * SystemColors.HighlightBrushKey+).��53   &   � $ 	#33000000��63   $ 0Q�6E   � 54   &   $ 	#00000000��63   $ 1Q�6E   55   #   56      .�57      ��  � �� 6;   Z� �� 58       � �� �	#4C0000006<   �� 59       � �� �	#FFFFFFFF6;   �� 5:       � ��$ 0��69   �� 5;       � ��$ 0��6:   �� 5<       � ��$
 Auto=�6[   �� 5=       � ��$
 Auto=�6Y   �� 5>       � �� .  6N   �� 5?       �@ 
Elasticity$ 0,0.4-�6Q   �� 5@       � ��$ Center=�6I   �� 5A       � ��$ 1q�6@   �� 5B       � �� 5C   "   �� 5D   &   "  66   .R�5E   *   � $ 
LayoutRoot��6/   .+�5F   .   �� $ Border��5G   9   #��z��5F   5   }�.  # z 5I   9   ���	#4C000000 5H   9   Z� ._�5K   2     $ scrollViewer��6H   $
��Auto=�6^   $��Disabled=�6�   $��0q�6�   #���  6�    5L   6     5M   :   .��5O   6   �� $��0q�6E   $��0��6P   $��0��6^   }�.  # z 6�    6�   Z� 6�   5P   3   5Q   /     5R   .   $  ScrollViewerOffsetMediator��6R    6v   �� $ scrollViewer��5S   +    5T   *   �� 5U   .   $
 True��6�    6:   �� $ 
IsExpanded� �� $ FindAncestor=�"   5V   2   �� 5W   6   .��5X   :   �� .��5Y   >   �� $ Border��6M   $1 +(Border.Background).(SolidColorBrush.Color)�6l   $ 	#FF4D4D4DX�6�   $  
00:00:00.2D�6�   5Z   ;   5[   7   ! 5]   2   �� 5^   6   .��5_   :   �� .��5`   >   �� $ Border��6M   $1 +(Border.Background).(SolidColorBrush.Color)�6l   $ 	#4C000000X�6�   $  
00:00:00.2D�6�   5a   ;   5b   7   5d   /   5f   '   5h      5i      �� 5k      ListBoxItemStyle " ��69   .�5l      ��  � ��$ 0��6:   �� 5m       � ��$ 0q�67   �� 5n       � �� 6;   Z� �� 5o       � �� 5p   "   �� 5q   &   " ��66   .R�5r   *   � $ 	Container��6;   $��50��6/   .+�5s   .   �� $ PressedBorder��65   ���	#33FFFFFF$" 0Q�6c   �� 5t   .   $ ExpandedBorder��65   $" 0Q�6M   ._�5u   2   �� $ SelectedBorder��69   ���	#33FFFFFF$" 0Q�6h   5v   /   �� 5w   .   $# Label��68   $
��15,0q�6G   $��CharacterEllipsis=�6U   $��Center=�6v   #��z��6�   $��NoWrap=�6�   
�������$��14(�6�   ��5x      `� 5y      8$   .1�5z      �� $ .�6&   �� 5{      $ 
IsExpanded�6&    68   �� $ FindAncestor=�"  5|      5~   /   5   +    5�   *   �� 5�   .   $
 True��6�    6:   �� $ 
IsExpanded� �� $ FindAncestor=�"   5�   2   �� 5�   6   .��5�   :   �� .��5�   >   W� $ ExpandedBorder��6N   $ Opacity�6u   $% 1X�6�   $  00:00:00.12D�6�   5�   ;   5�   7   ! 5�   2   �� 5�   6   .��5�   :   �� .��5�   >   W� $ ExpandedBorder��6N   $ Opacity�6u   $% 0X�6�   $  
00:00:00.2D�6�   5�   ;   5�   7   5�   /   P� 5�   .   & �@��
IsSelected' .  5�   2   �� 5�   6   ��5�   :   �� 5�   >   .��5�   B   W� $ SelectedBorder��6R   $ Opacity�6y   $% 1X�6�   $  00:00:00.12D�6�   5�   ?   5�   7   ! 5�   2   �� 5�   6   ��5�   :   �� 5�   >   .��5�   B   W� $ SelectedBorder��6R   $ Opacity�6y   $% 0X�6�   $  
00:00:00.2D�6�   5�   ?   5�   7   5�   /   P� 5�   .   !& �@J�AreAnyTouchesDirectlyOver' .  5�   2   �� 5�   6   ��5�   :   �� 5�   >   .��5�   B   W� $ PressedBorder��6R   $ Opacity�6x   $% 1X�6�   $  00:00:00.12D�6�   5�   ?   5�   7   ! 5�   2   �� 5�   6   ��5�   :   �� 5�   >   .��5�   B   W� $ PressedBorder��6R   $ Opacity�6x   $% 0X�6�   $  
00:00:00.2D�6�   5�   ?   5�   7   5�   /   5�   '   5�      5�      �� 5�      SurfaceHitAreaBaseStyle " ��6@   .�5�      ��  �@J�SnapsToDevicePixels .  6D   �� 5�       � ��8  6;   �� 5�       � �� .  6:   �� 5�       � |� .  6:   �� 5�       �@�FocusVisualStyle 6A   Z� �� 5�       � ��$ 8��69   �� 5�       � ��$ 0��6:   5�      �� 5�      $ SurfaceVertScrollBarRepeatButton "  6I   .�5�      ��  �@��Interval$	 150��69   �� 5�       � �� 6<   Z� �� 5�       � ��8  6;   �� 5�       �@�OverridesDefaultStyle . 6F   �� 5�       � |� .  6:   �� 5�       � �� .  6:   �� 5�       � �� 5�   "   �� 5�   &   "  66   .R�5�   *   � $��8��6/   #��z��69   .+�5�   .   �� $
( Line��6V   $��Center=�69   $��2��6d   #��� ) 6q   5�   +    5�   *   P� 5�   .   & � {�' .  . �5�   2   �� $
* Line��6I   # � + 6[    � ��5�   /   5�   '   5�      5�      �� 5�      SurfaceScrollBarThumbStyle " 
 6C   8  .�5�      ��  � �� 5�   "   �� 5�   &   " 
 66   .R�5�   *   � $
 Grid��61   #��z��6?   # z 6i   .+�5�   .   �� $( Thumb��69   $
��Auto��6H   $��8��6V   $��Stretch=�6a   $��Stretch=�6   #��� , 6�   5�   +   5�   '   5�      5�      �� 5�      $ SurfaceHorzScrollBarRepeatButton "  6I   .�5�      ��  �@��Interval$	 150��69   �� 5�       � �� 6<   Z� �� 5�       � ��8  6;   �� 5�       �@�OverridesDefaultStyle . 6F   �� 5�       � |� .  6:   �� 5�       � �� .  6:   �� 5�       � �� 5�   "   �� 5�   &   "  66   .R�5�   *   � $��8��6/   #��z��6:   .+�5�   .   �� $
( Line��6S   $��Center=�68   $��2��6a   #��� ) 6o   5�   +    5�   *   P� 5   .   & � {�' .  . �5  2   �� $
* Line��6I   # � + 6[    � ��5  /   5  '   5     5     �� 5	     #SurfaceScrollBarHorizThumbStyle " 
 6H   8  .�5
     ��  � �� 5  "   �� 5  &   " 
 66    5  *   ���� 5  .   	Touch .��5  2   W� $  0:0:0.05D�6B   $ Thumb��6V   $ Height�6t   $% 16X�6�   t� 5  2   $  0:0:0.05D�6E   $ Thumb��6Y   $ Margin�6w   $- 	0,-1,0,-1X�6�   5  /   �� 5  .   Release .��5  2   W� $  0:0:0.1D�6B   $ Thumb��6U   $ Height�6s   $% 14X�6�   t� 5  2   $  0:0:0.1D�6E   $ Thumb��6X   $ Margin�6v   $- 0,0,0,0X�6�   5  /   5  +   .R�5  *   � $
 Grid��6/   #��z��6=   # z 6g   .+�5  .   �� $( Thumb��69   $
��Auto��6H   $��14��6U   $��Stretch=�6a   $��Stretch=�6   #��� , 6�   5  +    5  *   P� 5  .   (& �@  AreAnyInputDevicesCapturedWithin' .  5  2   �� 5  6   8�� 6F   ! 5   2   �� 5!  6   8�� 6F   5#  /   P� 5$  .   & � {�' .  . �5%  2   �� $* Thumb��6I   # � + 6\    � ��5&  /   5(  '   5*     5+     �� 5.     SurfaceScrollBarStyle "  6>   .�5/     ��  �@��IsPressAndHoldEnabled .  6M   �� 50      �@��IsFlicksEnabled .  6G   �� 51      � ��$ 8��66   �� 52      � ��$
 Auto��67   �� 53      � �� 54  "   �� 56  &   "  66   .R�57  *   � $ GridRoot��6/   #��z��6A   .+�58  .   �� $ Track��65   $��Stretch=�6D   $��Stretch=�6`   ._�59  2   ]� $. 
PART_Track��68   ��. / 5:  6     5;  :   $0 IncreaseRepeat��6P   #��z��6h   $��Center=�6�   8�� $��ScrollBar.PageDownCommand��6�   1 5=  6     5>  :   $0 DecreaseRepeat��6P   #��z��6h   $��Center=�6�   8��	 $��ScrollBar.PageUpCommand��6�   2 5@  6   
  5A  :   $3 Thumb��6�   8��
 #��z��6~   $��Center=�6�   6�   5C  3   5D  /   5E  +    5F  *   P� 5H  .   & � {�' .  . �5I  2   �� $* 
PART_Track��6N    � {� .  6f   5J  /   5L  '   5N      5P     2 5 5T     P� 5V  "   & �@��Orientation$' 
Horizontal=�6C   . �5W  &   ��  � ��$
 Auto��6>   �� 5X  &    � ��$ 38��6?   �� 5Z  &    � �� 5[  *   �� 5\  .   "  6>   .R�5]  2   � $ GridRoot��67   #��z��6I   .+�5^  6   �� $ Track��6=   $��Stretch=�6L   $��Stretch=�6h   ._�5_  :   ]� $. 
PART_Track��6@   1 5`  >     5a  B   $0 DecreaseRepeat��6X   #��z��6p   $��Center=�6�   8�� $��ScrollBar.PageLeftCommand��6�   / 5c  >     5d  B   $0 IncreaseRepeat��6X   #��z��6p   $��Center=�6�   8�� $ ��ScrollBar.PageRightCommand��6�   2 5f  >   
  5g  B   $3 Thumb��6�   8�� #��z��6�   $��Center=�6�   6�   5i  ;   5j  7   5k  3    5l  2   P� 5n  6   & � {�' .  . �5o  :   �� $* IncreaseRepeat��6T    �@J�Opacity$
 0.33Q�6p   �� 5p  :   $* DecreaseRepeat��6T    �@J�Opacity$
 0.33Q�6p   �� 5q  :   $* 
PART_Track��6V    � {� .  6n   5r  7   5t  /   5v  '   5w  #   5y     �� 5{     SurfaceScrollViewerStyle "  6A   .�5|     ��  �@ 
Elasticity$ 0.4,0.4-�6;   �� 5}      � ��$
 Auto=�6[   �� 5~      � ��$
 Auto=�6Y   �� 5      � �� 5�  "   �� 5�  &   "  66   .R�5�  *   � #��z��6/   $��Stretch=�6Y   $��Stretch=�6w   6 5�  .     5�  2   TopShadowStates��7 5�  6     5�  :   $8 0:0:0.1D�6K   .9 5�  6     HideTopShadow��.: 5�  :   �� .��5�  >   �� $S M(UIElement.OpacityMask).(GradientBrush.GradientStops)[0].(GradientStop.Color)�6[   $ ShadowContainer��6�   .g�5�  B   �� $; 0��6V   $< Black��6b   5�  ?   5�  ;   5�  7     5�  6   ShowTopShadow��6B   5�  3     5�  2   BottomShadowStates��7 5�  6     5�  :   $8 0:0:0.1D�6K   .9 5�  6     HideBottomShadow��.: 5�  :   �� .��5�  >   �� $S M(UIElement.OpacityMask).(GradientBrush.GradientStops)[1].(GradientStop.Color)�6[   $ ShadowContainer��6�   .g�5�  B   �� $; 0��6V   $< Black��6b   5�  ?   5�  ;   5�  7     5�  6   ShowBottomShadow��6B   5�  3   .+�5�  .   �� $ PART_ConsistentViewport��65   ._�5�  2   �� $ PART_ElasticBorder��69   #��z��6U   ._�5�  6   � $ ShadowContainer��6;   
������  5�  :   �� 5�  >   $	 0.5,1&�6R   $
 0.5,0&�6c   .��5�  B   � $ 	#00000000��6O   $
 0.07Q�6a   � 5�  B   $
 0.93Q�6O   $ 	#00000000��6]   � 5�  B   $ Black��6O   $
 0.88Q�6]   � 5�  B   $ Black��6O   $
 0.12Q�6]   5�  ?   .+�5�  :   �� #��z��6Q   #��z��5�  5   #= z��5�  5   > .  ? .  $��Disabled=�5�  5   5�  7   5�  3   5�  /     5�  .   $@ PART_VerticalScrollBar��6�   #y�zA 6A   $B Vertical=�6�   #D zC 5�  +   $E 0Q�6X   $F VerticalScrollBar��5�  +   $
��Auto��6a   8�� $G 1Q�6�   #I zH 5�  +   $��Disabled=�6[   $��Stretch=�5�  +   $��Stretch=�6P   $��Right=�5�  +   {�. $" 0Q�6n   J .  $��10q�6�   K 5�  +   �� *VerticalOffset+$L OneWay=� �� *TemplatedParent+��5�  G   Z� 6�   5�  +   5�  '   5�     5�     5�     .R�5�     � 6 5�       5�     ExpandedStates��7 5�  "     5�  &   $8 0:0:0.12D�67   .9 5�  "     IsExpandedState��.: 5�  &   �� .��5�  *   U� $ (UIElement.Opacity)�6H   $ Arrows��6x   .\�5�  .     $M 0��6C   $N 0Q�6O   5�  +   5�  '   5�  #     5�  "   NotExpandedState��6.   5�     .+�5�     � $ Arrows��6   $��0,7,0,7q�6/   .+�5�     F� ���	#ffcfcfcf+����    ��; ѐ�;     �8�w ��; �    ��; $	��Top=�6x   $��Center=�6�   F� 5�     ���	#ffcfcfcf+����    ��; ѐ�;     �8�w ��; �    ��; $��Bottom=�6x   $��Center=�6�   $O .5,.5&�6�   z�5�  "   �� 5�  &   $	P 180Q�66   5�     5�       5�     $Q PART_ListBox��6+   #��zR 5�     #T zS 5�     #V zU 5�     #���  5�     #��z��5�     $��Disabled=�5�     #���  5�       5�     $W PART_TriggerButton��6*   8�� 6F   5�     5�     5�     5�     5�     