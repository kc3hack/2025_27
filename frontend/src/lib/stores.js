import { writable } from 'svelte/store';

// localStorage から読み込み (デフォルト値はランダムなユーザー名)

export const nickname = writable("");

// 変更があるたびに localStorage に保存
nickname.subscribe(value => {
    if (value) {
        localStorage.setItem("nickname", value);
    }
});