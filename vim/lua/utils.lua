-- see https://pragprog.com/magazines/2013-05/a-functional-introduction-to-lua

-- TODO: flatmap
-- TODO: includes

local utils = {}

utils.isEmpty = function(t)
  return next(t) == nil
end

-- reverse an indexed table in place
utils.reverse = function(t)
  local i, j = 1, #t
  while i < j do
    t[i], t[j] = t[j], t[i]

    i = i + 1
    j = j - 1
  end
end

utils.map = function(items, fn)
  local mapped = {}
  for index, item in pairs(items) do
    mapped[index] = fn(item)
  end
  return mapped
end

utils.filter = function(items, fn)
  local filtered = {}
  table.foreach(items, function(item)
    if fn(item) then
      table.insert(filtered, item)
    end
  end)
  return filtered
end

return utils
