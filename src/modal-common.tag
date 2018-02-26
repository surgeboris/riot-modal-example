<modal-common class="{'overlay': opts.overlay}">
  <div class="modal" ref="modal">
    <button class="modal-close" onclick="{close}">&times;</button>
    <div class="modal-header">
      <yield from="header" />
    </div>
    <div class="modal-body">
      <yield from="body" />
    </div>
    <div class="modal-footer">
      <yield from="footer" />
    </div>
  </div>

  <style scoped>
    :scope.overlay {
      position: fixed;
      height: 100vh;
      width: 100vw;
      top: 0;
      left: 0;
      background: rgba(0, 0, 0, 0.3);
    }

    .modal {
      display: flex;
      flex-direction: column;
      position: fixed;
      height: 50vh;
      width: 50vw;
      top: 25vh;
      left: 25vw;
      background: #fff;
      border: 3px solid black;
    }

    .modal-close {
      display: flex;
      align-items: center;
      justify-content: space-around;
      position: absolute;
      top: -16px;
      right: -16px;
      width: 50px;
      height: 50px;
      padding: 0;
      border-radius: 50%;
    }

    .modal-header,
    .modal-footer {
      max-height: 100px;
      flex-grow: 0;
      padding: 10px 20px;
      overflow: auto;
    }

    .modal-body {
      min-height: 200px;
      width: 100%;
      flex-grow: 1;
      border-top: 3px solid #000;
      border-bottom: 3px solid #000;
      padding: 20px;
      overflow: auto;
    }

  </style>

  <script>
    this.mixin('unpackOpts');

    this.onDOMEvent('keyup', e => {
      const KEYCODE_ESC = 27;
      if (e.which === KEYCODE_ESC) {
        this.close();
      }
    });

    this.close = () => {
      const { close: optsClose } = this.opts;
      if (typeof optsClose === 'function') {
        optsClose();
      } else {
        this.parent.unmount();
      }
    };

    this.on('mount', () => {
      const { closeOnClickOutside = true } = this.opts;
      if (closeOnClickOutside) {
        this.onClickOutside(this.refs.modal, this.close);
      }
    });
  </script>
</modal-common>
