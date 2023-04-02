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

module.exports = {
  keyword,
  key_val_arg,
  commaSep1,
  sep1,
  command,
};
