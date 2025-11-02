import { Label, Box } from 'resource:///com/github/Aylur/ags/widget.js';
import Variable from 'resource:///com/github/Aylur/ags/variable.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const date = Variable('', {
    poll: [1000, 'date "+%l:%H"'],
});

export const Clock = () => Box({
    className: 'clock',
    //child: Label().poll(1000, label => label.label = exec('date "+%l:%H"')),
    //child: Label().bind('label', date),
    child: Label({
        label: '',
        connections: [
            [
                1000,
                label => execAsync(
                    ['date', '+%l:%M']
                ).then(
                    date => label.label = date
                ).catch(print)
            ],
        ],
    }), 
});
