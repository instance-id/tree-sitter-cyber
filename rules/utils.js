// --| Key Value Arg ------------------
function key_val_arg(arg, ...args) {
  if (args.length > 0) {
    return seq(field("name", arg), token.immediate("="), field("val", ...args));
  } else return field("name", arg);
}

// --| Repeat -------------------------
function commaSep1($, rule, newline = false) {
  return sep1($, rule, ",", newline);
}

function sep1($, rule, separator, newline = false) {
  if (newline){ return seq(
    rule, repeat1(seq(
      separator, 
      optional($._newline),
      rule
    )),
  ); }
  else { return seq(rule, repeat1(seq(separator, rule))); }
}

// --| Parenthesis --------------------
function parenthesized($, rule, isOptional = false) {
  if (isOptional) {
    return choice(
      seq(optional("("), optional($._newline), rule, optional($._newline), optional(")")),
    );
  }

  return seq("(", optional($._newline), rule, optional($._newline), ")");
}


// --| List Of ------------------------
function list_of($, rule, separator = ',', separatorIsOptional = false) {
  if (separatorIsOptional) {
    return seq(
      rule, optional($._newline),
      repeat(seq(
        optional(separator),
        rule,
        optional($._newline),
      )),
      optional(separator)
    );
  } else {
    return seq(
      rule, 
      optional($._newline),
      repeat(
        seq(
          separator,
          rule,
          optional($._newline))
      ),
      optional(separator)
    );
  }
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
  key_val_arg,
  list_of,
  commaSep1,
  sep1,
  parenthesized,
};
