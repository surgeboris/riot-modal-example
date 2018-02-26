export function lockAfterExecution(fn, onLock) {
  let isLocked = false;
  const unlock = () => { isLocked = false };
  return (...args) => {
    if (isLocked) {
      onLock(unlock, ...args);
      return;
    }
    const result = fn(unlock, ...args);
    isLocked = true;
    return result;
  };
}
