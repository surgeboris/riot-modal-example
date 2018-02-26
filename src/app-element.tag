import { makeHandlerSilent } from './utils.js';
import {
  incrementOne,
  incrementTwo,
  incrementOneMulti,
  incrementTwoMulti,
} from './action-creators.js';

const updateCountMixin = {
  init() {
    this.updated = 0;
    const increment = () => ++this.updated;
    this.on('update', increment);
  }
}

<count-with-updates>
  <pre>{parent.opts.count}, rendered {parent.updated} times</pre>
</count-with-updates>

<app-element>
  <count-one class="part" />
  <multicount-one class="part" />
  <count-two class="part" />
  <multicount-two class="part" />
  <style>
    :scope {
      display: flex;
      align-items: center;
      justify-content: space-around;
      height: 100vh;
      min-height: 200px;
      overflow: hidden;
    }

    .part {
      flex-basis: 0;
      flex-grow: 1;
      text-align: center;
    }
  </style>
</app-element>

<count-one>
  <count-with-updates />
  <button type="button" onclick="{this.increment}">Increment 1</button>
  <script>
    this.mixin(updateCountMixin);
    this.reduxConnect(
      ({ count1: { count } }) => ({ count }),
      {
        increment: makeHandlerSilent(incrementOne),
      },
    );
  </script>
</count-one>

<count-two>
  <count-with-updates />
  <button type="button" onclick="{this.increment}">Increment 2</button>
  <script>
    this.mixin(updateCountMixin);
    this.reduxConnect(
      ({ count2: { count } }) => ({ count }),
      {
        increment: makeHandlerSilent(incrementTwo),
      },
    );
  </script>
</count-two>

<multicount-one>
  <count-with-updates />
  <button type="button" onclick={increment}>
    {INCREMENT_STEP} x "Increment 1"
  </button>
  <script>
    this.mixin(updateCountMixin);

    this.INCREMENT_STEP = 10;
    this.reduxConnect(
      ({ count1: { count } }) => ({ count }),
      {
        increment: makeHandlerSilent(
          e => incrementOneMulti(this.INCREMENT_STEP)
        ),
      },
    );
  </script>
</multicount-one>

<multicount-two>
  <count-with-updates />
  <button type="button" onclick={increment}>
    {INCREMENT_STEP} x "Increment 2"
  </button>
  <script>
    this.mixin(updateCountMixin);

    this.INCREMENT_STEP = 10;
    this.reduxConnect(
      ({ count2: { count } }) => ({ count }),
      {
        increment: makeHandlerSilent(
          e => incrementTwoMulti(this.INCREMENT_STEP)
        ),
      },
    );
  </script>
</multicount-two>
