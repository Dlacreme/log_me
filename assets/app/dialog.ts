export enum Type {
  Confirmation = 'confirmation'
}

interface Options {
  label: string;
}

export class Dialog {

  private readonly templateIds = {
    host: 'template-dialog',
    label: 'template-dialog-label'
  };

  constructor() { }

  public open(type: Type, options: Options): Promise<any> {
    return new Promise<any>((onRes, onErr) => {
      console.log('hello');
      const template = document.getElementById(this.templateIds.host);
      console.log('template');
    });
  }
}