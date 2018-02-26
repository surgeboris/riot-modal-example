export function makeHandlerSilent(
  fn,
  shouldPreventDefault,
  shouldStopPropagation
) {
  return (e, ...args) => {
    e.preventUpdate = true;
    if (shouldPreventDefault) e.preventDefault();
    if (shouldStopPropagation) e.stopPropagation();
    return fn(e, ...args);
  };
}

export function repeat(n, value) {
  const result = new Array(n);
  for (let i = 0; i < n; i++) {
    result[i] = value;
  }
  return result;
}
