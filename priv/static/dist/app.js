class LiveState {
  static init() {
    window.addEventListener("phx:page-loading-start", (info) => console.log("start", info));
    window.addEventListener("phx:page-loading-stop", (info) => console.log("stop", info));
  }
}
class Display {
  constructor() {
  }
  static helpers() {
    return {
      show: (id) => {
        document.getElementById(id).style.display = "block";
      },
      hide: (id) => {
        document.getElementById(id).style.display = "none";
      }
    };
  }
}
class AppWindow {
  constructor() {
    window.app = {};
  }
  attach(key, obj) {
    window.app[key] = obj;
  }
}
var Type;
(function(Type2) {
  Type2["Confirmation"] = "confirmation";
})(Type || (Type = {}));
class Dialog {
  constructor() {
    this.templateIds = {
      host: "template-dialog",
      label: "template-dialog-label"
    };
  }
  open(type, options) {
    return new Promise((onRes, onErr) => {
      console.log("hello");
      document.getElementById(this.templateIds.host);
      console.log("template");
    });
  }
}
window.app = {};
const appWindow = new AppWindow();
appWindow.attach("display", Display.helpers());
const dialog = new Dialog();
appWindow.attach("dialog", {
  confirmation: (options) => dialog.open(Type.Confirmation, options)
});
LiveState.init();
