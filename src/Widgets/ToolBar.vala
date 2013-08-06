// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/***
  BEGIN LICENSE

  Copyright (C) 2013 Mario Guerriero <mario@elementaryos.org>
  This program is free software: you can redistribute it and/or modify it
  under the terms of the GNU Lesser General Public License version 3, as published
  by the Free Software Foundation.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranties of
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public License along
  with this program.  If not, see <http://www.gnu.org/licenses/>

  END LICENSE
***/

using Gtk;
using Granite.Widgets;

namespace Scratch.Widgets {

    public class Toolbar : Gtk.Toolbar {

        public ToolButton open_button;
        public ToolButton templates_button;
        public ToolButton save_button;
        public ToolButton undo_button;
        public ToolButton repeat_button;
        public ToolButton revert_button;
        public ToolButton find_button;

        public Gtk.Menu share_menu;
        public Gtk.Menu menu;

        public Granite.Widgets.ToolButtonWithMenu share_app_menu;
        public AppMenu app_menu;

        public Toolbar () {

            // Toolbar properties
            // compliant with elementary HIG
            get_style_context ().add_class ("primary-toolbar");

            // Create ToolButtons       
            open_button = main_actions.get_action ("Open").create_tool_item() as Gtk.ToolButton;
            templates_button = main_actions.get_action ("Templates").create_tool_item() as Gtk.ToolButton;
            save_button = main_actions.get_action ("SaveFile").create_tool_item() as Gtk.ToolButton;
            undo_button = main_actions.get_action ("Undo").create_tool_item() as Gtk.ToolButton;
            repeat_button = main_actions.get_action ("Redo").create_tool_item() as Gtk.ToolButton;
            revert_button = main_actions.get_action ("Revert").create_tool_item() as Gtk.ToolButton;
            find_button = main_actions.get_action ("Fetch").create_tool_item() as Gtk.ToolButton;
            
            // Create Share and AppMenu
            share_menu = new Gtk.Menu ();
            share_app_menu = new Granite.Widgets.ToolButtonWithMenu (new Image.from_icon_name ("document-export", IconSize.MENU), _("Share"), share_menu);
            share_menu.insert.connect (() => {
                if (share_menu.get_children ().length () > 0) {
                    share_app_menu.no_show_all = false;
                    share_app_menu.visible = true;
                    share_app_menu.show_all ();
                }
                else {
                    share_app_menu.no_show_all = true;
                    share_app_menu.visible = false;
                    share_app_menu.hide ();
                }
            });
            share_menu.remove.connect (() => {
                if (share_menu.get_children ().length () > 0) {
                    share_app_menu.no_show_all = false;
                    share_app_menu.visible = true;
                    share_app_menu.show_all ();
                }
                else {
                    share_app_menu.no_show_all = true;
                    share_app_menu.visible = false;
                    share_app_menu.hide ();
                }
            });
            share_app_menu.no_show_all = true;

            // Add everything to the toolbar
            add (open_button);
            add (templates_button);
            add (save_button);
            add (new SeparatorToolItem ());
            add (revert_button);
            add (undo_button);
            add (repeat_button);
            add (new SeparatorToolItem ());
            add (find_button);
            add_spacer ();
            add (share_app_menu);

            // Show/Hide widgets
            show_all ();

            // Some signals...
            settings.changed.connect (() => {
                save_button.visible = !settings.autosave;
            });

        }

        private void add_spacer () {
            var spacer = new ToolItem ();
            spacer.set_expand (true);
            add (spacer);
        }
    }
}
