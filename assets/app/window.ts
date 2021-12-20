export class AppWindow {
  constructor() {
    (window as any).app = {};
  }

  public attach(key: string, obj: any): void {
    (window as any).app[key] = obj;
  }
}