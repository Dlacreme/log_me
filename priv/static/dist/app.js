class LiveState {
  static init() {
    window.addEventListener("phx:page-loading-start", (info) => console.log("start", info));
    window.addEventListener("phx:page-loading-stop", (info) => console.log("stop", info));
  }
}
LiveState.init();
