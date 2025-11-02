import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import { Box, Label, Button, Icon } from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import App from "resource:///com/github/Aylur/ags/app.js";

export const Workspaces = () => Box({
    className: 'workspaces',
    children: Array.from({ length: 10 }, (_, i) => i+1).map(i => Button({
        attribute: i,
        on_clicked: () => dispatch(i),
        child: Label({
            label: `${i}`,
            class_name: 'indicator',
            vpack: 'center',
        }),
        setup: self => self.hook(Hyprland, () => {
            self.toggleClassName('active', Hyprland.active.workspace.id === i);
            self.toggleClassName('has-windows', (Hyprland.getWorkspace(i)?.windows || 0) > 0);
        }),
    })),


    //connections: [[Hyprland, box => {
    //    const arr = Array.from({ length: 10 }, (_, i) => i+1);
    //    box.children = arr.map(i => Button({
    //        onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`),
    //        child: Label({
    //            label: `${i}`,
    //            className: 'indecator',
    //        }),
    //        className: Hyprland.active.workspace.id == i ? 'active' :
    //            Hyprland.workspaces.find(item => item.id === i)?.windows > 0 ? 'has-windows' : "no-windows",
    //    }));
    //}]],
});
