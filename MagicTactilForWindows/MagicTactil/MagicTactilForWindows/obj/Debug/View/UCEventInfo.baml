   M S B A M L   `   `   `  ����  MagicTactilForWindows'    !MagicTactilForWindows.UCEventInfo   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e356Custom)http://schemas.microsoft.com/surface/2008  5      -   5          >�Name$  UserControl��5	      .��5      � -   5         �Name$ 
LayoutRoot��5      .+�5   
   �� -   5         ��Name$ 
contentBox��5      $��0,92.8,0,52q�6D    �� TextWrapping$
 Wrap=�6Y   {�.  �� 
IsReadOnly .  �� 	MaxLength$
 2000��6�   ��6&   �� *eventContent+6�   �� 5   
   -   5        $ nameBox��5      $
��24.8��6#   $
 Wrap=�61   $	��Top=�6`   $
��Left=�6x   {�.  . $	��167��6�   ��6E   �� *	eventName+6�   �� 5   
   -   5        $ locationBox��5      $��28��6'   $��0,44,0,0q�63   $
 Wrap=�6E   $	��Top=�6x   $
��Left=�6�   {�.  . $	��167��6�   ��6Y   �� *eventLocation+6�   �� 5   
   -   5        $ dateBox��5      $��28��6#   $��0,44,0,0q�6/   $
 Wrap=�6A   $	��Top=�6p   $��Right=�6�   {�.  . $	��167��6�   ��6U   �� *	eventDate+6�   �� 5   
   -   5        $ creatorNameBox��5      $
��24.8��6*   $
 Wrap=�68   $	��Top=�6i   $��Right=�6�   {�.  . $	��167��6�   ��6L   �� *creatorName+6�   ;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  5      -   5          Name$ 
SISOButton��5      $��8,0,0,10q�6r   $��Bottom=�6�   $
��Left=�6�   $	��100��6�   ��6-   �� *SignInLabel+��6M   �� *sign_up_to_event+6�     5   
   $
��Edit��6d   $
��26.8��6s   $��117,0,117,10q�6�   $��Bottom=�6�   $	��100��6�   y�6   �� *creatorRight+��6C   �� *modify_event+6�     5   
   $��Delete��6d   $��Right=�6u   $
��26.8��6�   $��0,0,8,10q�6�   $��Bottom=�6�   $	��100��6�   y�6   �� *creatorRight+��6C   �� *delete_event+6�   5      5      