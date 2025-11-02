import { App, Widget } from "astal/gtk3"
import { Variable } from "astal"
// import app from "ags/gtk3/app"
// import Gtk from "gi://Gtk?version=3.0"
// import { createBinding, createState } from "ags"
import style from "./style.scss"
import {Bar, Show} from "./widget/Bar"
import NotificationPopups from "./widget/NotificationPopups"
// import MprisPlayers from "./widget/MediaPlayer"

// App.start({
//     instanceName: "notifications",
//     css: style,
//     main: () => App.get_monitors().map(NotificationPopups),
// })


App.start({
    instanceName: "main-ags",
    css: style,
    main() {
        App.get_monitors().map(Bar);
        App.get_monitors().map(NotificationPopups);
        // new Widget.Window({}, MprisPlayers())
    },
    requestHandler(request: string, res: (response: any) => void) {
        if (request == "show bar") {
            Show(true);
        }
        if (request == "hide bar") {
            Show(false);
        }
        res("unknown command")
    },
})

// App.start({
//     instanceName: "players",
//     css: style,
//     main: () => {
//         new Widget.Window({}, MprisPlayers())
//     }
// })