import riot from 'riot';

import './index.css';
import './app-element.tag';
import store from './store.js';
import riotReduxConnect from 'riot-redux-connect';

riotReduxConnect(riot, store);
riot.mount('#app', 'app-element');
