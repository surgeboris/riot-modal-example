import './modal-common.tag';

<modal-important>
  <modal-common opts="{opts}">
    <yield to="header">
      <h1>Important modal.</h1>
    </yield>
    <yield to="body">
      <ul>
        <li>It has overlay</li>
        <li>You can close it only by "&times;" button</li>
      </ul>
    </yield>
    <yield to="footer">
      <p>{parent.opts.footer}</p>
    </yield>
  </modal-common>
</modal-important>
