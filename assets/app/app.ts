import { LiveState } from './live_state';
import { Display } from './display';
import { AppWindow } from './window';
import { Dialog, Type as DialogType } from './dialog';

(window as any).app = {};
const appWindow = new AppWindow();

/* Helpers to show/hide elements using IDs */
appWindow.attach('display', Display.helpers());

/* Display a modal that requires confirmation from users */
const dialog = new Dialog();
appWindow.attach('dialog', {
  confirmation: (options) => dialog.open(DialogType.Confirmation, options),
  confirm: () => dialog.confirm(),
  cancel: () => dialog.cancel(),
});

LiveState.init();