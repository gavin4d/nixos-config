import { Bar } from "./modules/topbar.js";
import Dashboard from "./modules/widgets/dashboard.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import { exec } from 'resource:///com/github/Aylur/ags/utils.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';

const scss = `${App.configDir}/scss/main.scss`
const css = `${App.configDir}/style.css`

exec(`sassc ${scss} ${css}`)

//exec('swww img ~/Downloads/1291412.jpg');

export default {
    style: App.configDir + '/style.css',
    cacheNotificationActions: true,
    windows: [
        Bar(),
        Dashboard(),
    ].flat(1),
};

globalThis.getNot = () => Notifications;
