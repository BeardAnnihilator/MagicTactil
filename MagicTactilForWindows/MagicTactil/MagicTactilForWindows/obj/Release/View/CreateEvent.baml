   M S B A M L   `   `   `  ���� P  LMagicTactilForWindows, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null=#clr-namespace:MagicTactilForWindowsMagicTactilForWindows  ,    &MagicTactilForWindows.View.CreateEvent   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     e aMicrosoft.Surface.Presentation, Version=2.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e352my)http://schemas.microsoft.com/surface/2008  ?MagicTactilForWindows#clr-namespace:MagicTactilForWindows  .��� -     �Name$  
LayoutRoot������  �� ImageSource$B </MagicTactilForWindows;component/Resources/green-pattern.jpg�� j� Stretch$ UniformToFill=� � ColumnDefinitions �� $
��184* ��� $
��456* � � RowDefinitions �� $	��55* ��� $	��44* ��� $	��51* ��� $
��330* �.+�<  6Microsoft.Surface.Presentation.Controls.SurfaceTextBox  -   $��nameTextBox��$��	7,14,12,3q�$��1������ *	eventName+ �� UpdateSourceTrigger$ PropertyChanged=�  -   $��dateTextBox��$��7,3,12,3q�$��1��$��1������ *	eventDate+$ PropertyChanged=�  -   $��locationTextBox��$��	7,3,12,10q�$��1��$��2������ *eventLocation+$ PropertyChanged=�  -   $��contentTextBox��$��
7,11,12,67q�$��1��$��3�� �� AcceptsReturn . ���� *eventContent+$ PropertyChanged=��� -   $��	nameLabel��$��
Event Name��$��	11,12,0,0q�$��40��;  5Microsoft.Surface.Presentation.Controls.SurfaceButton  -   $��createButton��$��Create��$��7,0,0,12q�$��38��$��Bottom=�$
��Left=�$	��101��$��3��$��1������ *create+  -   $��cancelButton��$��Cancel��$��
157,0,0,12q�$��38��$��Bottom=�$��3��$��1��$
��Left=�$	��101������ *cancel+�� -	   $��	dateLabel��$��
Event Date��$��40��$��12,3,0,0q�$	��Top=�$��1���� -
   $��locatioLabel��$��Location��$
��Left=�$��11,3,0,0q�$	��173��$��2��$��48���� -   $��contentLabel��$��Event Description��$��40��$
��Left=�$��	11,11,0,0q�$	��Top=�$	��173��$��3���� -   $��errLabel��$��3��$��
11,57,16,0q�
���  �����	#FF3C3434y��� *errVisibility+.���� ���� *	errMess+