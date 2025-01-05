public class Vui.Widget.App : Adw.Application {

    public static Gtk.Window window;

    protected delegate Vui.Widget.Window AppWindowAction (Adw.Application app);

    public unowned AppWindowAction? content {
        set {
            this.activate.connect (() => {
                window = this.active_window;
                if (window == null) {
                    window = value (this).widget;
                }
                window.present ();
            });
        }
    }

    public override void activate () {
        base.activate ();
    }

    public App (string id) {
        Object (application_id : id, flags: ApplicationFlags.DEFAULT_FLAGS);

        if (Vui.Impl.Generic.gsettings == null)
            Vui.Impl.Generic.gsettings = new GLib.Settings (this.get_application_id ());
    }
}
