import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { lookUpIcon } from 'resource:///com/github/Aylur/ags/utils.js';

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
const NotificationIcon = ({ app_entry, app_icon, image }) => {
    print(app_entry)
    print(app_icon)
    /*
    if (image) {
        return Widget.Box({
            css: `
                min-width: 2rem;
                min-height: 2rem;
                background-image: url("${image}");
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
            `,
        });
    }
    */

    let icon = 'dialog-information-symbolic';
    if (lookUpIcon(app_icon))
        icon = app_icon;

    if (app_entry && lookUpIcon(app_entry))
        icon = app_entry;

    return Widget.Icon({
        size: 48, 
        icon: icon,
    });
};

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
export const Notification = n => {
    const icon = Widget.Box({
        //vpack: 'start',
        class_name: 'icon',
        child: NotificationIcon(n),
    });

    const title = Widget.Label({
        class_name: 'title',
        xalign: 0,
        justification: 'left',
        hexpand: true,
        max_width_chars: 24,
        truncate: 'end',
        wrap: true,
        label: n.summary,
        use_markup: true,
    });

    const body = Widget.Label({
        class_name: 'body',
        hexpand: true,
        use_markup: true,
        xalign: 0,
        justification: 'left',
        label: n.body,
        wrap: true,
    });

    const actions = Widget.Box({
        class_name: 'actions',
        children: n.actions.map(({ id, label }) => Widget.Button({
            class_name: "normal-button",
            class_name: 'action-button',
            on_clicked: () => n.invoke(id),
            hexpand: true,
            child: Widget.Label(label),
        })),
    });

    return Widget.EventBox({
        on_primary_click: () => n.dismiss(),
        child: Widget.Box({
            class_name: `notification ${n.urgency}`,
            vertical: true,
            children: [
                Widget.Box({
                    children: [
                        icon,
                        Widget.Box({
                            vertical: true,
                            children: [
                                title,
                                body,
                            ],
                        }),
                    ],
                }),
                actions,
            ],
        }),
    });
};

export const NotificationWidget = (w,h) => Widget.Box({
    css: `
        min-width: ${w}rem;
        min-height: ${h}rem;
    `,
    vertical: true,
    children: [
        Widget.CenterBox({
            startWidget: Widget.Label({
                label: "Notifications",
            }),
            endWidget: Widget.Button({
                class_name: "normal-button",
                on_primary_click: () => Notifications.clear(),
                child: Widget.Label({label: "close all"}),
            }),
        }),
        Widget.Scrollable({
            hscroll: 'never',
            vscroll: 'always',
            css: 'min-height: 140px;',
            vexpand: true,
            child: Widget.Box({
                class_name: 'notifications',
                vertical: true,
                spacing: 8,
                children: Notifications.bind('notifications').transform(notifications => {
                    return notifications.map(Notification).reverse();
                }),
            }),
        }),
    ]
});

export const NotificationPopup = Widget.Window({
    name: 'notifications',
    anchor: ['bottom', 'right'],
    child: Widget.Box({
        css: `padding: 1px;`,
        children: [
            //Widget.Label({label: "close all"}),
            Widget.Box({
                class_name: 'notifications',
                vertical: true,
                spacing: 10,
                children: Notifications.bind('popups').transform(popups => {
                    return popups.map(Notification);
                }),
            }),
        ]
    })
});
