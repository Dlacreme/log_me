export enum Type {
  Confirmation = 'confirmation'
}

interface Options {
  title: string;
  label: string;
}

export class Dialog {

  private currentDialog?: Promise<boolean> = undefined;
  private currentDialogOnRes: any;
  private currentDialogOnErr: any;
  private readonly templateIds = {
    container: 'dialog-container',
    template: 'template-dialog',
    title: 'template-dialog-title',
    label: 'template-dialog-label'
  };

  constructor() { }

  public open(type: Type, options: Options): Promise<any> {
    this.cancelCurrentDialog();
    return new Promise<any>((onRes, onErr) => {
      this.currentDialogOnRes = onRes;
      this.currentDialogOnErr = onErr;
      const templateContent = (document.getElementById(this.templateIds.template) as any)
        .content.cloneNode(true);
      this.findAndFill(templateContent, this.templateIds.title, options.title);
      this.findAndFill(templateContent, this.templateIds.label, options.label);
      document.getElementById(this.templateIds.container).replaceChildren(
        templateContent
      )
    });
  }

  public confirm(): void {
    this.emptyContainer();
    this.currentDialogOnRes(true);
    this.currentDialog = undefined;
  }

  public cancel(): void {
    this.emptyContainer();
    this.currentDialogOnRes(false);
    this.currentDialog = undefined;
  }

  private findAndFill(template: HTMLElement, id, content): void {
    const el = (template.querySelector(`#${id}`) as HTMLElement);
    el.innerText = content;
    el.id = "";
  }

  private emptyContainer(): void {
    document.getElementById(this.templateIds.container).replaceChildren();
  }

  private cancelCurrentDialog(): void {
    if (!this.currentDialog) {
      return;
    }
    this.emptyContainer();
    this.currentDialogOnErr('another dialog opened');
    this.currentDialog = undefined;
  }
}