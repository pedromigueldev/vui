/* window.vala
 *
 * Copyright 2024-2025 Pedro Miguel
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Vui.Widget;
using Vui.Model;
using Vui.Impl;

namespace Demo {

    public class FormScreen : View {

        private Store<bool> toogle = new Store<bool> (false);
        private Store<int> spinrow = new Store<int> (0);

        construct {
            view = new ToolBar ("Account") {
                make_title = {},
                show_headerbar_title = false,
                content = new VBox () {
                    margin = { 0, 0, 20, 20 },
                    content = {
                        new Section ("Personal Information") {
                            content = {
                                new Entry ("First Name") {
                                    append = new Button.from_icon_name ("document-edit-symbolic") {
                                        css_classes = { "flat" },
                                        on_click = () => message ("button was clicked")
                                    }
                                },
                                new Entry ("Last Name"),
                            }
                        },
                        new Section ("Actions") {
                            content = {
                                new PasswordEntry ("Password here"),
                                new Toggle ("Birthday", toogle),
                                new SpinRow ("Something is: ", spinrow),
                            },
                            bottom = new Button.with_label ("Solo button") {
                                css_classes = { "suggested-action" }
                            }
                        }
                    }
                }
            };
        }
    }

    public class StateScreen : View {
        private Store<string> state = new Store<string> ("There must be something here");
        private Store<bool> state2 = new Store<bool> (true);

        construct {
            view = new ToolBar ("Reacting to changes") {
                show_headerbar_title = false,
                content = new VBox (10) {
                    margin = { 0, 0, 20, 20 },
                    vexpand = true,
                    valign = Gtk.Align.CENTER,
                    content = {
                        new Vui.Flow.ShowIf (state2) {
                            content = {
                                new Label.ref (state) {
                                    css_classes = { "title-1" },
                                    margin_bottom = 30,
                                    wrap = true,
                                }
                            }
                        },
                        new Section () {
                            halign = Gtk.Align.FILL,
                            content = {
                                new Entry ("Type your password") {
                                    hexpand = true,
                                },
                            }
                        },
                        new Button.with_label ("Click me!!") {
                            css_classes = { "pill" },
                            halign = Gtk.Align.CENTER,
                            on_click = () => state2.state = !state2.state
                        }
                    },
                }
            };
        }
    }

    public class Overlay : View {

        private Store<int> spinrow = new Store<int> (0);

        public Overlay () {
            view = new Vui.Widget.Overlay () {
                overlay = new Button.from_icon_name ("list-add-symbolic") {
                    expand = { true },
                    align = { Gtk.Align.END },
                    margin_bottom = 20,
                    css_classes = { "fill", "circular", "suggested-action", "filter-icon" },
                    on_click = () => {
                        new Dialog () {
                            content_size = { 500, 500 },
                            content = new ToolBar ("Dialog") {
                                top_bar = new HeaderBar (),
                                content = new VBox () {
                                    valign = Gtk.Align.CENTER,
                                    content = {
                                        new Label ("TESTE") {
                                            css_classes = { "title-1" }
                                        }
                                    }
                                }
                            }
                        };
                    }
                },
                content = new ScrolledBox () {
                    content = new VBox (20) {
                        content = {
                            new Button.with_label ("Dialog") {
                                on_click = () => {
                                    new AlertDialog ("Hey it's a dialog!", "This is just a presentaion") {
                                        content = new VBox () {
                                            expand = { true },
                                            content = {
                                                new Entry ("Vui Entry"),
                                                new SpinRow ("SpinRow", spinrow),
                                                new Toggle ("Toggle"),
                                                new PasswordEntry ("Password here")
                                            }
                                        },
                                        action = "Try me.",
                                        action_suggested = "Close window",
                                        action_destructive = "Cancel",
                                    };
                                }
                            },
                            new PageLink (new FormScreen ()) {
                                valign = Gtk.Align.CENTER,
                                hexpand = true,
                                trigger = new Button.with_label ("Account Screen"),
                            },
                            new PageLink (new StateScreen ()) {
                                align = { Gtk.Align.CENTER, Gtk.Align.END },
                                hexpand = true,
                                trigger = new Label ("third screen"),
                            }
                        }
                    }
                }
            };
        }
    }

    public class Home : View {
        construct {
            view = new Navigation () {
                pages = {
                    new ToolBar ("Journal") {
                        show_headerbar_title = false,
                        make_title = {
                            new Button.from_icon_name ("document-edit-symbolic") {
                                css_classes = { "circular" }
                            },
                            new Button.from_icon_name ("view-more-horizontal-symbolic") {
                                css_classes = { "circular" }
                            }
                        },
                        content = new VBox () {
                            margin = { 0, 0, 20, 20 },
                            vexpand = true,
                            content = {
                                new Demo.Overlay ()
                            }
                        }
                    }
                }
            };
        }
    }
}
