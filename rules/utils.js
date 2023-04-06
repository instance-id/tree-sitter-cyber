function key_val_arg(arg, ...args) {
  if (args.length > 0) {
    return seq(field("name", arg), token.immediate("="), field("val", ...args));
  } else return field("name", arg);
}

function commaSep1(rule) {
  return sep1(rule, ",");
}

function sep1(rule, separator) {
  return seq(rule, repeat(seq(separator, rule)));
}

function command($, cmd, ...args) {
  return seq(keyword($, cmd), ...args);
}

function keyword(k, name) {
  return alias(k["_" + name], name);
}

function selector(word, aliasAsWord = true) {
  let pattern = ''
  for (const letter of word) {
    pattern += `[${letter}${letter.toLocaleUpperCase()}]`
  }
  let result = new RegExp(pattern)
  if (aliasAsWord) result = alias(result, word)
  return result
}


// --| Create Custom Regex -----
function createCaseInsensitiveRegex(word) {
  return new RegExp(
    word
      .split("")
      .map(letter => `[${letter.toLowerCase()}${letter.toUpperCase()}]`)
      .join(""),
  );
}

function kv(key, value) {
  return alias(
    value === null
      ? createCaseInsensitiveRegex(key)
      : seq(createCaseInsensitiveRegex(key), "=", field("value", value)),
    key.toLowerCase(),
  );
}

module.exports = {
  keyword,
  key_val_arg,
  commaSep1,
  sep1,
  command,
};
