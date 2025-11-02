import { CircularProgress, Box, Label, Button} from 'resource:///com/github/Aylur/ags/widget.js';
import App from "resource:///com/github/Aylur/ags/app.js";
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';

const battery = Box({ child: CircularProgress({
    className: 'battery',
    value: Battery.bind('percent').transform(p => p / 100),
    child: Label({
           className: '',// /*(Battery.bind('charging') ? */'charging'/* : '')*/,
        })
            .bind(
                'className', 
                Battery, 
                'charging', 
                (p) => {return p ? 'charging' : ''
            }),
})});

const cpu = Box({ child: CircularProgress({
    className: 'cpu',
    child: Label(),
    connections: [
        [1000, progress => {
            execAsync(App.configDir + '/scripts/cpu.sh')
                .then(val => {
                    progress.value = val / 100;
                }).catch(print);
            progress.show_all();
        }],
    ],
})});

const ram = Box({ child: CircularProgress({
    className: 'ram',
    child: Label(),
    connections: [
        [30000, progress => {
            execAsync(App.configDir + '/scripts/ram.sh')
                .then(val => {
                    progress.value = val / 100;
                }).catch(print);
            progress.show_all();
        }],
    ],
})});


export const HardwareBar = () => Button({
    className: 'hardware-bar',
    child:
        Box({
            children: [
                cpu,
                ram,
                battery,
            ]
        }),
    onClicked: () => {
        print("hello");
        App.toggleWindow('dashboard');
    },
});
