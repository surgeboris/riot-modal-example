import { repeat } from './utils.js';

export const incrementOne = () => ({
  type: 'INCREMENT1',
});

export const incrementTwo = () => ({
  type: 'INCREMENT2',
});

export const incrementOneMulti = count => repeat(count, {
  type: 'INCREMENT1',
});

export const incrementTwoMulti = count => repeat(count, {
  type: 'INCREMENT2',
});
