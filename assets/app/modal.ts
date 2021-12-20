interface Helpers {
  open(id: string): void;
  close(id: string): void;
}

export class Modal {
  constructor() { }

  static helpers(): Helpers {
    return {
      open: (id: string): void => {
        document.getElementById(id).style.display = 'block';
      },
      close: (id: string): void => {
        document.getElementById(id).style.display = 'none';
      }
    }
  }
}