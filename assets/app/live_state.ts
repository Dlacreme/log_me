export class LiveState {
  public static init(): void {
    window.addEventListener("phx:page-loading-start", info => console.log('start', info))
    window.addEventListener("phx:page-loading-stop", info => console.log('stop', info))
  }
}