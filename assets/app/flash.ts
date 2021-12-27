export class Flash {

  private flashContainers = [
    'alert-info',
    'alert-danger',
  ];

  public clear(): void {
    this.flashContainers.forEach((cl) => {
      const el = document.getElementById(cl);
      if (el && el.remove) {
        el.remove();
      }
    });
  }
}