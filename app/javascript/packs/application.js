// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// const ham = document.querySelector('#js-hamburger'); //js-hamburgerの要素を取得し、変数hamに格納
// const nav = document.querySelector('#js-nav'); //js-navの要素を取得し、変数navに格納

// ham.addEventListener('click', function () { //ハンバーガーメニューをクリックしたら
//   ham.classList.toggle('active'); // ハンバーガーメニューにactiveクラスを付け外し
//   nav.classList.toggle('active'); // ナビゲーションメニューにactiveクラスを付け外し
// });