import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import PopupWindow from './PopupWindow.js';

export default () => PopupWindow({
    name: 'dashboard',
    transition: 'slide_down',
    child: Widget.Box({
        children: [
//            NotificationColumn(),
            Widget.Separator({ orientation: 1 }),
//            DateColumn(),
        ],
    }),
});
