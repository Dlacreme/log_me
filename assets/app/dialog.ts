export enum Type {
  Confirmation = 'confirmation'
}

interface Options {
  label: string;
}

export class Dialog {
  constructor() { }

  public open(type: Type, options: Options): Promise<any> {
    return new Promise<any>((onRes, onErr) => {
      console.log('hello');
    });
  }
}