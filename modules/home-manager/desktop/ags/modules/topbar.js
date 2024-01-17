import { Window, CenterBox, Box, Label } from 'resource:///com/github/Aylur/ags/widget.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

import { Workspaces } from './widgets/workspaces.js';
import { Clock } from './widgets/clock.js';
import { HardwareBar } from './widgets/hardware.js';



// layout of the bar
const Left = () => Box({
    children: [
        Workspaces(),
    ],
});

const Center = () => Box({
    children: [
        Clock(),
    ],
});

const Right = () => Box({
    hpack: "end",
    children: [
        HardwareBar(),
    ],
});



export const Bar = ({ monitor } = {}) => Window ({
    name: `bar${monitor || ''}`,
    className: 'bar-bg',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: "exclusive",
    child: CenterBox({
        className: 'bar',
        startWidget: Left(),
        centerWidget: Center(),
        endWidget: Right(),
    }),
})
