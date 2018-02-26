import './modal-common.tag';

<modal-light>
  <modal-common opts="{opts}">
    <yield to="header">
      <h1>Light modal.</h1>
    </yield>
    <yield to="body">
      <ul>
        <li>No overlay</li>
        <li>You can close it by clicking outside of it</li>
      </ul>
    </yield>
    <yield to="footer">
      <p>{parent.opts.footer}</p>
    </yield>
  </modal-common>
</modal-light>
