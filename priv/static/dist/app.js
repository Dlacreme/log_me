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
    this.currentDialog = void 0;
    this.templateIds = {
      container: "dialog-container",
      template: "template-dialog",
      title: "template-dialog-title",
      label: "template-dialog-label"
    };
  }
  open(type, options) {
    this.cancelCurrentDialog();
    return new Promise((onRes, onErr) => {
      this.currentDialogOnRes = onRes;
      this.currentDialogOnErr = onErr;
      const templateContent = document.getElementById(this.templateIds.template).content.cloneNode(true);
      this.findAndFill(templateContent, this.templateIds.title, options.title);
      this.findAndFill(templateContent, this.templateIds.label, options.label);
      document.getElementById(this.templateIds.container).replaceChildren(templateContent);
    });
  }
  confirm() {
    this.emptyContainer();
    this.currentDialogOnRes(true);
    this.currentDialog = void 0;
  }
  cancel() {
    this.emptyContainer();
    this.currentDialogOnRes(false);
    this.currentDialog = void 0;
  }
  findAndFill(template, id, content) {
    const el = template.querySelector(`#${id}`);
    el.innerText = content;
    el.id = "";
  }
  emptyContainer() {
    document.getElementById(this.templateIds.container).replaceChildren();
  }
  cancelCurrentDialog() {
    if (!this.currentDialog) {
      return;
    }
    this.emptyContainer();
    this.currentDialogOnErr("another dialog opened");
    this.currentDialog = void 0;
  }
}
class Flash {
  constructor() {
    this.flashContainers = [
      "alert-info",
      "alert-danger"
    ];
  }
  clear() {
    this.flashContainers.forEach((cl) => {
      const el = document.getElementById(cl);
      if (el && el.remove) {
        el.remove();
      }
    });
  }
}
window.app = {};
const appWindow = new AppWindow();
appWindow.attach("display", Display.helpers());
const dialog = new Dialog();
appWindow.attach("dialog", {
  confirmation: (options) => dialog.open(Type.Confirmation, options),
  confirm: () => dialog.confirm(),
  cancel: () => dialog.cancel()
});
const flash = new Flash();
appWindow.attach("flash", {
  clear: () => flash.clear()
});
LiveState.init();
