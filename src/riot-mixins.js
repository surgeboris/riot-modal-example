import riot from 'riot';

riot.mixin({
  onDOMEvent(type, fn) {
    const boundFn = fn.bind(this);
    this.on('mount', () => {
      document.addEventListener(type, boundFn);
    });
    this.on('before-unmount', () => {
      document.removeEventListener(type, boundFn);
    });
  }
});

(() => {
  const handlers = [];
  document.addEventListener('click', (e) => {
    handlers.forEach(h => { h(e); });
  });
  riot.mixin({
    onClickOutside(node, fn) {
      const applyFnIfClickedOutside = (e) => {
        const isNodeClicked = e.target === node;
        const isNodeChildClicked = node.contains(e.target);
        if (isNodeClicked || isNodeChildClicked) return;
        // timeout prevents erroneous changes to "handlers", that may occur
        // if handlerDispose will be triggered during handlers.forEach
        setTimeout(() => fn(e), 0);
      };
      handlers.push(applyFnIfClickedOutside);
      const handlerDispose = () => {
        const index = handlers.indexOf(applyFnIfClickedOutside);
        handlers.splice(index, 1);
      };
      this.on('before-unmount', handlerDispose);
      return handlerDispose;
    },
  });
})();

riot.mixin({
  showPortal(name, opts) {
    const portal = document.createElement('div');
    document.body.appendChild(portal);
    const [instance] = riot.mount(portal, name, opts);
    return {
      beforeClose(fn) {
        instance.on('before-unmount', fn);
      },
      close() {
        instance.unmount();
      },
      afterClose(fn) {
        instance.on('unmount', fn);
      },
    };
  },
});

riot.mixin('unpackOpts', {
  init() {
    const unpackOpts = () => {
      const packedOpts = this.opts.opts || {};
      Object.keys(packedOpts).forEach(key => {
        this.opts[key] = packedOpts[key]
      });
    };
    unpackOpts();
    this.on('before-mount', unpackOpts);
    this.on('update', unpackOpts);
  },
});
