import './modal-important.tag';
import './modal-light.tag';
import { lockAfterExecution } from './utils.js';

<app-element>
  <div class="wrapper">
    <div class="note">
      <p> App's root element occupies half of the screen and has "overflow: hidden".
      That means that it is impossible to show full-screen modal without
      breaking out of our app's component tree bounds.
      </p>
      <p>This project demonstrates how to solve this problem for RiotJS</p>
    </div>
    <div class="buttons">
      <button onclick={showRequiredModal}>Modal (required)</button>
      <button onclick={showLightModal}>Modal (light)</button>
    </div>
  </div>

  <style scoped>
    :scope {
      height: 50vh;
      overflow: hidden;
    }

    .wrapper {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      height: 100%;
      border-bottom: 3px solid #000;
      background: rgba(0, 255, 0, 0.3);
    }

    .note {
      padding: 10px;
      font-size: 24px;
      border-bottom: 3px solid #000;
      background: #fff;
    }

    .buttons {
      display: flex;
      flex-grow: 1;
      align-items: center;
      justify-content: space-around;
    }
  </style>

  <script>
    this.showRequiredModal = (e) => {
      e.stopPropagation();
      this.showPortal('modal-important', {
        footer: 'Required modal: we can pass opts from modal-triggering context.',
        closeOnClickOutside: false,
        overlay: true,
      });
    }

    this.showLightModal = lockAfterExecution(
      (unlock, e) => {
        e.stopPropagation();
        const { beforeClose } = this.showPortal('modal-light', {
          footer: 'Light modal: we can pass opts from modal-triggering context.',
        });
        beforeClose(unlock);
      },
      (unlock, e) => {
        e.stopPropagation();
        e.preventUpdate = true;
        return;
      }
    );
  </script>
</app-element>
