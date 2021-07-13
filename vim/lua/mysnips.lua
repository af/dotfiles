-- My snippets, for snippets.nvim
-- For more ideas and tools, see https://github.com/norcalli/snippets.nvim/wiki
local U = require'snippets.utils'

local js_family_snips = {
  cl = [[console.log(${0})]];

  db = [[debugger]];

  ["for"] = U.match_indentation
[[for (let i = 0; i < ${1}; i++) {
	${0}
}]];

  switch = U.match_indentation
[[switch (${1}) {
case ${2}:
	${3}
	break
}]];
}

require'snippets'.snippets = {
  javascript = js_family_snips;
  typescript = js_family_snips;

  css = {
    ellipsis = U.match_indentation [[overflow: hidden;
text-overflow: ellipsis;
white-space: nowrap;]]
  };

  html = {
    html = [[<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${1}</title>
</head>
<body>
	${2}
</body>
</html>]];

    link = [[<link rel="${1:stylesheet}" href="${2}" type="${3:text/css}" media="${4:screen}">]];

    meta = [[<meta name="${1:name}" content="${2:content}">]];

    mailto = [[<a href="mailto:${1}?subject=${2}">${3}</a>]];

    ["select"] = U.match_indentation [[<select name="${1}">
	<option value="${2}">${3}</option>
	<option value="${4}">${5}</option>
</select>]];
  };

  lua = {
    req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']];
    func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]];
    ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]];
    ["for"] = U.match_indentation [[
for ${1:i}, ${2:v} in ipairs(${3:t}) do
  $0
end]];
  };
}
