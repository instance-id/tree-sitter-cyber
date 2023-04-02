local vim = vim
local q = require"vim.treesitter.query"

local function i(value)
    print(vim.inspect(value))
end

i("dicks")

-- goto exit

local bufnr = 43

local language_tree = vim.treesitter.get_parser(bufnr, 'cyber')
local syntax_tree = language_tree:parse()
local root = syntax_tree[1]:root()

local query = vim.treesitter.parse_query('cyber', [[
(assignment_statement
  left: (identifier) @variable )
 ]])

-- local query = vim.treesitter.parse_query('cyber', [[
-- (method_declaration
--     (modifiers
--         (marker_annotation
--             name: (identifier) @annotation (#eq? @annotation "Test")))
--     name: (identifier) @method (#offset! @method))
-- ]])

for _, captures, metadata in query:iter_matches(root, bufnr) do
    i(captures)
    i(q.get_node_text(captures[1], bufnr))
    i(metadata)
end

::exit::
