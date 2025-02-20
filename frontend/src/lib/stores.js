import { writable } from 'svelte/store';

export const nickname = writable("");

// 変更があるたびに localStorage に保存
nickname.subscribe(value => {
    if (value) {
        localStorage.setItem("nickname", value);
    }
});

export const selectAvatar = writable("");

// 変更があるたびに localStorage に保存
selectAvatar.subscribe(value => {
    if (value) {
        localStorage.setItem("selectAvatar", value);
    }
});