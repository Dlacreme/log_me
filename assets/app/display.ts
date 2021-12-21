interface Helpers {
  show(id: string): void;
  hide(id: string): void;
}

export class Display {
  constructor() { }

  static helpers(): Helpers {
    return {
      show: (id: string): void => {
        document.getElementById(id).style.display = 'block';
      },
      hide: (id: string): void => {
        document.getElementById(id).style.display = 'none';
      }
    }
  }
}