﻿#pragma checksum "..\..\..\View\Rooms.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "286E31ACC19F9B2505F01BA84A682724"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.1008
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Microsoft.Surface.Presentation;
using Microsoft.Surface.Presentation.Controls;
using Microsoft.Surface.Presentation.Controls.Primitives;
using Microsoft.Surface.Presentation.Controls.TouchVisualizations;
using Microsoft.Surface.Presentation.Input;
using Microsoft.Surface.Presentation.Palettes;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace MagicTactilForWindows.View {
    
    
    /// <summary>
    /// Rooms
    /// </summary>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
    public partial class Rooms : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 13 "..\..\..\View\Rooms.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Surface.Presentation.Controls.SurfaceListBox RoomsListBox1;
        
        #line default
        #line hidden
        
        
        #line 14 "..\..\..\View\Rooms.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Surface.Presentation.Controls.SurfaceButton CreateButton;
        
        #line default
        #line hidden
        
        
        #line 15 "..\..\..\View\Rooms.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Surface.Presentation.Controls.SurfaceButton RefreshButton;
        
        #line default
        #line hidden
        
        
        #line 20 "..\..\..\View\Rooms.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Surface.Presentation.Controls.SurfaceButton JoinButton;
        
        #line default
        #line hidden
        
        
        #line 21 "..\..\..\View\Rooms.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Surface.Presentation.Controls.SurfaceListBox playerListBox;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/MagicTactilForWindows;component/view/rooms.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\Rooms.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.RoomsListBox1 = ((Microsoft.Surface.Presentation.Controls.SurfaceListBox)(target));
            
            #line 13 "..\..\..\View\Rooms.xaml"
            this.RoomsListBox1.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.RoomsListBox1_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 2:
            this.CreateButton = ((Microsoft.Surface.Presentation.Controls.SurfaceButton)(target));
            return;
            case 3:
            this.RefreshButton = ((Microsoft.Surface.Presentation.Controls.SurfaceButton)(target));
            return;
            case 4:
            this.JoinButton = ((Microsoft.Surface.Presentation.Controls.SurfaceButton)(target));
            return;
            case 5:
            this.playerListBox = ((Microsoft.Surface.Presentation.Controls.SurfaceListBox)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}

