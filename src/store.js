import {
  combineReducers,
  applyMiddleware,
  createStore,
  compose
} from 'redux';
import { reduxBatch } from '@manaflair/redux-batch';

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

function getCountReducer(index) {
  return (state = { count: 0 }, action) => {
    if (action.type === `INCREMENT${index}`) {
      const { count } = state;
      return { count: count + 1 };
    }
    return state;
  };
}

const reducer = combineReducers({
  count1: getCountReducer(1),
  count2: getCountReducer(2),
});

const middleware = [
];

const store = createStore(reducer, /* preloadedState, */ composeEnhancers(
  reduxBatch,
  applyMiddleware(...middleware)
));

export default store;
