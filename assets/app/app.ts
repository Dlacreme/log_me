import { LiveState } from './live_state';
import { Modal } from './modal';
import { AppWindow } from './window';

(window as any).app = {};

const appWindow = new AppWindow();
appWindow.attach('modal', Modal.helpers())

LiveState.init();