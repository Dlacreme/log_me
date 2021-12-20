class LiveState {
  static init() {
    window.addEventListener("phx:page-loading-start", (info) => console.log("start", info));
    window.addEventListener("phx:page-loading-stop", (info) => console.log("stop", info));
  }
}
class Modal {
  constructor() {
  }
  static helpers() {
    return {
      open: (id) => {
        document.getElementById(id).style.display = "block";
      },
      close: (id) => {
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
window.app = {};
const appWindow = new AppWindow();
appWindow.attach("modal", Modal.helpers());
LiveState.init();
