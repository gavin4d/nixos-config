import { Bar } from "./widget/topbar.js";
import Dashboard from "./widget/widgets/dashboard.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import { VolumeOSD } from './widget/on-screen/volume.js'
import { exec, execAsync, timeout } from 'resource:///com/github/Aylur/ags/utils.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import { notificationPopup } from './widget/on-screen/notificationPopup.js';

const scss = `${App.configDir}/scss/main.scss`
const css = `${App.configDir}/style.css`

exec(`sassc ${scss} ${css}`)

//execAsync(['swww', 'img', '~/Downloads/1291412.jpg']);

timeout(1000, () => execAsync([
    'notify-send',
    'Notification Popup Example',
    'Lorem ipsum dolor sit amet, qui minim labore adipisicing ' +
    'minim sint cillum sint consectetur cupidatat.',
    '-A', 'Cool!',
    '-i', 'info-symbolic',
]));

export default {
    style: App.configDir + '/style.css',
    cacheNotificationActions: true,
    windows: [
        Bar(),
        Dashboard(),
        notificationPopup,
        VolumeOSD(),
    ],
};

globalThis.getNot = () => Notifications;
